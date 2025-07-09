externalFlakes: final: prev: {
  helix = externalFlakes.helix.packages.${final.system}.helix;
}
