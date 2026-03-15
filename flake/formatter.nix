{ pkgs }:

pkgs.writeShellApplication {
  name = "format";
  runtimeInputs = builtins.attrValues {
    inherit (pkgs)
      nixfmt
      deadnix
      statix
      fd
      stylua
      ;
  };
  text = ''
    fd "$@" -t f -e nix -x statix fix -- '{}'
    fd "$@" -t f -e nix -X deadnix -e -- '{}' \; -X nixfmt '{}'
    fd "$@" -t f -e lua -X stylua --indent-type Spaces --indent-width 2 '{}'
  '';
}
