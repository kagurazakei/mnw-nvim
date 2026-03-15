{ pkgs, fetchFromGitHub, ... }:

pkgs.vimPlugins.blink-cmp.overrideAttrs {
  src = fetchFromGitHub {
    owner = "Saghen";
    repo = "blink.cmp";
    rev = "19c25fa5e95f1387f53b461a425ad2129ed1d681";
    hash = "sha256-4RuzzT+4jF1N1Ks+qZtyvnZt3L0icEdUX++rpRcDrVQ=";
  };
}
