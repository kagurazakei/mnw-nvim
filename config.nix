{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  inherit (inputs.neovim-nightly.packages.${pkgs.stdenv.system}) neovim;

  appName = "gerg";

  extraLuaPackages = p: [ p.jsregexp ];

  providers = {
    ruby.enable = true;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = true;
  };

  # Source lua config
  initLua = ''
    require("gerg")
    LZN = require("lz.n")
    LZN.register_handler(require("handlers.which-key"))
    LZN.load("lazy")
    vim.cmd.colorscheme "tokyonight-night"
  '';

  desktopEntry = false;
  plugins = {
    dev.gerg = {
      pure =
        let
          fs = lib.fileset;
        in
        fs.toSource {
          root = ./.;
          fileset = fs.unions [
            ./lua
            ./after
          ];
        };
      impure = "~/Projects/nvim-flake";
    };

    startAttrs = inputs.mnw.lib.npinsToPluginsAttrs pkgs ./start.json;
    opt = builtins.attrValues {
      inherit (pkgs.vimPlugins)
        catppuccin-nvim
        rose-pine
        ;
    };
    start = builtins.attrValues {
      inherit (pkgs.vimPlugins)
        lz-n
        luvit-meta
        mini-align
        nvim-autopairs
        nvim-surround
        mini-cursorword
        mini-comment
        cord-nvim
        snacks-nvim
        smart-open-nvim
        sqlite-lua
        statuscol-nvim
        which-key-nvim
        better-escape-nvim
        blink-cmp
        ;

      treesitter =
        let
          nts = pkgs.vimPlugins.nvim-treesitter;
          tsg = pkgs.tree-sitter-grammars;
          norgG = [
            tsg.tree-sitter-norg
            tsg.tree-sitter-norg-meta
          ];
        in
        nts.withPlugins (_: nts.allGrammars ++ norgG);
    };

    optAttrs =
      #"blink.cmp" = inputs.self.packages.${pkgs.stdenv.system}.blink-cmp;
      inputs.mnw.lib.npinsToPluginsAttrs pkgs ./opt.json;

  };

  extraBinPath = builtins.attrValues {
    #
    # Runtime dependencies
    #
    inherit (pkgs)
      deadnix
      statix
      nil
      wl-clipboard
      imagemagick
      lua-language-server
      stylua
      nixd
      #rustfmt

      ripgrep
      fd
      chafa
      vscode-langservers-extracted
      ;
  };

}
