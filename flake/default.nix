{
  pkgs,
  inputs,
  mnw,
  self,
  system,
}:

let
  neovim = mnw.lib.wrap { inherit pkgs inputs; } ../config.nix;
in
{
  default = neovim;

  dev = neovim.devMode;
  inherit (neovim) configDir;

  blink-cmp = pkgs.callPackage ../packages/blink-cmp/package.nix { };
  neovim = neovim;
}
