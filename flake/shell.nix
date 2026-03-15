{ pkgs }:

pkgs.mkShellNoCC {
  packages = [
    pkgs.npins
    (pkgs.writeShellScriptBin "opt" ''
      npins --lock-file opt.json "$@"
    '')
    (pkgs.writeShellScriptBin "start" ''
      npins --lock-file start.json "$@"
    '')
  ];
}
