final: prev: {
  bitwarden-cli = prev.buildNpmPackage rec {
    pname = "bitwarden-cli";
    version = "2025.7.0";

    src = prev.fetchFromGitHub {
      owner = "bitwarden";
      repo = "clients";
      tag = "cli-v${version}";
      hash = "sha256-vucd2eKZYosW/DR/yxuXxXpsNobJmB1EerkKNv+1V8M=";
    };

    postPatch = ''
      # remove code under unfree license
      rm -r bitwarden_license
    '';

    nodejs = prev.nodejs_20;

    npmDepsHash = "sha256-NnkT+NO3zUI71w9dSinnPeJbOlWBA4IHAxnMlYUmOT4=";

    nativeBuildInputs = [ prev.installShellFiles prev.cacert ] ++ prev.lib.optionals prev.stdenv.hostPlatform.isDarwin [
      prev.cctools
      prev.perl
      prev.xcbuild.xcrun
    ];

    makeCacheWritable = true;

    env = {
      ELECTRON_SKIP_BINARY_DOWNLOAD = "1";
      npm_config_build_from_source = "true";
      npm_config_offline = "false";
      npm_config_cache_prefer_offline = "false";
      SSL_CERT_FILE = "${prev.cacert}/etc/ssl/certs/ca-bundle.crt";
      NODE_EXTRA_CA_CERTS = "${prev.cacert}/etc/ssl/certs/ca-bundle.crt";
    };

    npmBuildScript = "build:oss:prod";

    npmWorkspace = "apps/cli";

    npmFlags = [ "--legacy-peer-deps" "--no-offline" ];

    npmInstallFlags = [ "--no-offline" ];

    npmRebuildFlags = [
      # we'll run npm rebuild manually later
      "--ignore-scripts"
    ];

    preConfigure = ''
      # Try to bypass npm's cache-only mode by setting registry
      npm config set registry https://registry.npmjs.org/
      npm config set offline false
      npm config set prefer-offline false
    '';

    postConfigure = ''
      # we want to build everything from source
      shopt -s globstar
      rm -rf node_modules/**/prebuilds 2>/dev/null || true
      shopt -u globstar

      # FIXME one of the esbuild versions fails to download @esbuild/linux-x64
      rm -rf node_modules/esbuild 2>/dev/null || true
      rm -rf node_modules/vite/node_modules/esbuild 2>/dev/null || true

      npm rebuild --verbose
    '';

    postBuild = ''
      # remove build artifacts that bloat the closure
      shopt -s globstar
      rm -r node_modules/**/{*.target.mk,binding.Makefile,config.gypi,Makefile,Release/.deps}
      shopt -u globstar
    '';

    postInstall = ''
      # The @bitwarden modules are actually npm workspaces inside the source tree, which
      # leave dangling symlinks behind. They can be safely removed, because their source is
      # bundled via webpack and thus not needed at run-time.
      rm -rf $out/lib/node_modules/@bitwarden/clients/node_modules/{@bitwarden,.bin}
    ''
    + prev.lib.optionalString (prev.stdenv.buildPlatform.canExecute prev.stdenv.hostPlatform) ''
      installShellCompletion --cmd bw --zsh <($out/bin/bw completion --shell zsh)
    '';

    passthru = {
      tests = {
        vaultwarden = prev.nixosTests.vaultwarden.sqlite;
      };
      updateScript = prev.nix-update-script {
        extraArgs = [
          "--version=stable"
          "--version-regex=^cli-v(.*)$"
        ];
      };
    };

    meta = {
      changelog = "https://github.com/bitwarden/clients/releases/tag/${src.tag}";
      description = "Secure and free password manager for all of your devices";
      homepage = "https://bitwarden.com";
      license = prev.lib.licenses.gpl3Only;
      mainProgram = "bw";
      maintainers = with prev.lib.maintainers; [ dotlambda ];
      # Don't mark as broken on Darwin - we're fixing this!
      broken = false;
    };
  };
}