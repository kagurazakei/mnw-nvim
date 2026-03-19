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
        vim.cmd.colorscheme "rose-pine-main"

    vim.lsp.enable({
    	"fish_lsp",
    	"gleam",
    	"lua_ls",
    	"nil_ls",
    	"basedpyright",
    	"ts_ls",
    	"marksman",
    	"tinymist",
    	"clangd",
    })
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
            ./snippets
          ];
        };
      impure = "~/Projects/final-nvim";
    };

    startAttrs = inputs.mnw.lib.npinsToPluginsAttrs pkgs ./start.json;

    start = builtins.attrValues {
      inherit (pkgs.vimPlugins)
        lz-n
        luvit-meta
        mini-align
        nvim-surround
        mini-cursorword
        mini-comment
        cord-nvim
        snacks-nvim
        smart-open-nvim
        vim-moonfly-colors
        sqlite-lua
        statuscol-nvim
        which-key-nvim
        better-escape-nvim
        rose-pine
        catppuccin-nvim
        luasnip
        blink-cmp-nixpkgs-maintainers
        colorful-menu-nvim
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

    optAttrs = inputs.mnw.lib.npinsToPluginsAttrs pkgs ./opt.json;

  };

  extraBinPath = builtins.attrValues {
    #
    # Runtime dependencies
    #
    inherit (pkgs)
      deadnix
      statix
      nil

      lua-language-server
      stylua

      #rustfmt

      ripgrep
      fd
      chafa
      vscode-langservers-extracted
      ;
  };

}
