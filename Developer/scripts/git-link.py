#!/usr/bin/env python3
"""
Script to generate GitLab and GitHub links to current line/selection in Helix editor.
Uses Helix's expansion variables to get file path, line numbers, and git info.
"""

import os
import re
import subprocess
import sys
from urllib.parse import quote


def get_git_remote_url():
    """Get the remote URL from git config."""
    try:
        result = subprocess.run(
            ["git", "config", "--get", "remote.origin.url"],
            capture_output=True,
            text=True,
            check=True,
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None


def get_current_commit():
    """Get the current commit hash."""
    try:
        result = subprocess.run(
            ["git", "rev-parse", "HEAD"], capture_output=True, text=True, check=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError:
        return None


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


def generate_link(file_path, start_line, end_line=None):
    """Generate link to file at specific line(s) for GitLab or GitHub."""
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

    # Make file path relative to git root
    try:
        git_root = subprocess.run(
            ["git", "rev-parse", "--show-toplevel"],
            capture_output=True,
            text=True,
            check=True,
        ).stdout.strip()
        abs_file_path = os.path.abspath(file_path)
        if abs_file_path.startswith(git_root):
            rel_file_path = os.path.relpath(abs_file_path, git_root)
        else:
            rel_file_path = file_path
    except subprocess.CalledProcessError:
        rel_file_path = file_path

    # URL encode the file path
    encoded_file_path = quote(rel_file_path)

    # Build the appropriate URL based on platform
    if platform == "github":
        if end_line and end_line != start_line:
            line_fragment = f"L{start_line}-L{end_line}"
        else:
            line_fragment = f"L{start_line}"
        url = f"{base_url}/{project_path}/blob/{commit_hash}/{encoded_file_path}#{line_fragment}"
    else:  # gitlab
        if end_line and end_line != start_line:
            line_fragment = f"L{start_line}-{end_line}"
        else:
            line_fragment = f"L{start_line}"
        url = f"{base_url}/{project_path}/-/blob/{commit_hash}/{encoded_file_path}#{line_fragment}"

    return url


def main():
    """Main function - expects file_path, start_line, and optional end_line as arguments."""
    # Debug: log all arguments to a file
    with open("/tmp/helix-debug.log", "a") as f:
        f.write(f"Args: {sys.argv}\n")
        f.write(f"CWD: {os.getcwd()}\n")
        f.write("---\n")
    if len(sys.argv) < 3:
        print(
            "Usage: gitlab-link.py <file_path> <start_line> [end_line]",
            file=sys.stderr,
        )
        sys.exit(1)
    file_path = sys.argv[1]
    # Handle case where Helix expansions aren't working
    try:
        start_line = int(sys.argv[2])
    except ValueError:
        print(
            f"Error: Invalid line number '{sys.argv[2]}' - Helix expansions may not be supported",
            file=sys.stderr,
        )
        print(
            "Try using: python3 git-link.py <file> <line>",
            file=sys.stderr,
        )
        sys.exit(1)
    try:
        end_line = int(sys.argv[3]) if len(sys.argv) > 3 else None
    except ValueError:
        end_line = start_line
    link = generate_link(file_path, start_line, end_line)
    if link:
        print(link)
        # Copy to clipboard if available
        try:
            subprocess.run(["pbcopy"], input=link, text=True, check=True)
        except (subprocess.CalledProcessError, FileNotFoundError):
            # pbcopy not available, just print the link
            pass
    else:
        sys.exit(1)


if __name__ == "__main__":
    main()
