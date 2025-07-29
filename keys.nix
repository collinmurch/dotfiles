let
  keys = {
    # Bitwarden-managed SSH key for encryption
    collin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBHh+CNtM2mS/S4rFao4zCVgVRYH9lmQ8F/hIAa8fTKH";
  };
in keys // {
  admins = [ keys.collin ];
  all    = builtins.attrValues keys;
}