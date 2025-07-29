let
  inherit (import ./keys.nix) admins all;
in {
  # TX-02 Font files
  "fonts/TX-02-Regular.otf.age".publicKeys      = admins;
  "fonts/TX-02-Bold.otf.age".publicKeys         = admins;
  "fonts/TX-02-Oblique.otf.age".publicKeys      = admins;
  "fonts/TX-02-Bold-Oblique.otf.age".publicKeys = admins;
}