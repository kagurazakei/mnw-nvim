{ pkgs, fetchFromGitHub, ... }:

pkgs.vimPlugins.blink-cmp-nixpkgs-maintainers.overrideAttrs {
  src = fetchFromGitHub {
    owner = "GaetanLepage";
    repo = "blink-cmp-nixpkgs-maintainers";
    rev = "b572f807ca3b4b6f87c791b0d5ceaa81dbb00d70";
    hash = "sha256-ollZI9Bd3eAKvzS84oIzToVruYbCERKKhZpIR+cBxBE=";
  };
}
