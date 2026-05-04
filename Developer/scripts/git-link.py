#!/usr/bin/env python3
"""
Generate GitLab and GitHub links to files in the current git repository.
"""

import argparse
import os
import re
import subprocess
import sys
from urllib.parse import quote


def git_output(*args):
    try:
        result = subprocess.run(
            ["git", *args],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None


def get_git_remote_url():
    """Get the remote URL from git config."""
    return git_output("config", "--get", "remote.origin.url")


def get_current_commit():
    """Get the current commit hash."""
    return git_output("rev-parse", "HEAD")


def parse_remote_url(remote_url):
    """Parse remote URL to extract base URL, project path, and platform type."""
    if not remote_url:
        return None, None, None

    # Handle both SSH and HTTPS URLs
    if remote_url.startswith("git@"):
        # SSH format: git@github.com:user/repo.git or git@gitlab.com:user/repo.git
        match = re.match(r"git@([^:]+):(.+?)(?:\.git)?$", remote_url)
        if match:
            host, project_path = match.groups()
            base_url = f"https://{host}"
            platform = "github" if "github.com" in host else "gitlab"
            return base_url, project_path, platform
    elif remote_url.startswith("https://"):
        # HTTPS format: https://github.com/user/repo or https://gitlab.com/user/repo
        match = re.match(r"https://([^/]+)/(.+?)(?:\.git)?$", remote_url)
        if match:
            host, project_path = match.groups()
            base_url = f"https://{host}"
            platform = "github" if "github.com" in host else "gitlab"
            return base_url, project_path, platform
    return None, None, None


def generate_link(file_path, start_line=None, end_line=None):
    """Generate link to a file or line range for GitLab or GitHub."""
    remote_url = get_git_remote_url()
    if not remote_url:
        print(
            "Error: Not in a git repository or no remote origin found", file=sys.stderr
        )
        return None

    base_url, project_path, platform = parse_remote_url(remote_url)
    if not base_url or not project_path or not platform:
        print(f"Error: Could not parse remote URL: {remote_url}", file=sys.stderr)
        return None

    commit_hash = get_current_commit()
    if not commit_hash:
        print("Error: Could not get current commit hash", file=sys.stderr)
        return None

    git_root = git_output("rev-parse", "--show-toplevel")
    if git_root:
        abs_file_path = os.path.abspath(file_path)
        if os.path.commonpath([abs_file_path, git_root]) == git_root:
            rel_file_path = os.path.relpath(abs_file_path, git_root)
        else:
            rel_file_path = file_path
    else:
        rel_file_path = file_path

    encoded_file_path = quote(rel_file_path)

    if platform == "github":
        url = f"{base_url}/{project_path}/blob/{commit_hash}/{encoded_file_path}"
        if start_line is not None:
            line_fragment = f"L{start_line}"
            if end_line is not None and end_line != start_line:
                line_fragment = f"{line_fragment}-L{end_line}"
            url = f"{url}#{line_fragment}"
    else:
        url = f"{base_url}/{project_path}/-/blob/{commit_hash}/{encoded_file_path}"
        if start_line is not None:
            line_fragment = f"L{start_line}"
            if end_line is not None and end_line != start_line:
                line_fragment = f"{line_fragment}-{end_line}"
            url = f"{url}#{line_fragment}"

    return url


def parse_line(value):
    try:
        line = int(value)
    except ValueError:
        raise argparse.ArgumentTypeError(f"invalid line number: {value!r}")
    if line < 1:
        raise argparse.ArgumentTypeError("line number must be greater than 0")
    return line


def debug_enabled():
    executable = os.path.basename(sys.argv[0])
    return executable == "git-link-debug" or os.environ.get("GIT_LINK_DEBUG")


def write_debug_log():
    if not debug_enabled():
        return
    with open("/tmp/git-link-debug.log", "a") as f:
        f.write(f"Args: {sys.argv}\n")
        f.write(f"CWD: {os.getcwd()}\n")
        f.write("---\n")


def parse_args():
    parser = argparse.ArgumentParser(
        description="Generate a GitHub or GitLab link for a file in the current repository."
    )
    parser.add_argument("file_path")
    parser.add_argument("start_line", nargs="?", type=parse_line)
    parser.add_argument("end_line", nargs="?", type=parse_line)
    args = parser.parse_args()
    if args.start_line is None and args.end_line is not None:
        parser.error("end_line requires start_line")
    if (
        args.start_line is not None
        and args.end_line is not None
        and args.end_line < args.start_line
    ):
        parser.error("end_line must be greater than or equal to start_line")
    return args


def main():
    write_debug_log()
    args = parse_args()
    link = generate_link(args.file_path, args.start_line, args.end_line)
    if link:
        print(link)
        try:
            subprocess.run(["pbcopy"], input=link, text=True, check=True)
        except (subprocess.CalledProcessError, FileNotFoundError):
            pass
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
