{
  pkgs,
  mnw,
  small ? false,
}:

mnw.lib.wrap pkgs {
  appName = "zakei";
  neovim = pkgs.neovim.unwrapped.overrideAttrs {
    version = "0.12.0";
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "8499af1119f0f96b4fd57ef9099ce5a2503bc952";
      hash = "sha256-/PyUJOW1PMUdfy+ewWbngxttcaNsQmWpCEueNsAUBZE=";
    };
    doInstallCheck = false;
  };

  plugins = {
    startAttrs = mnw.lib.npinsToPluginsAttrs pkgs ./start.json;

    start =
      let
        nts = pkgs.vimPlugins.nvim-treesitter;
        tsg = pkgs.tree-sitter-grammars;
        norgG = [
          tsg.tree-sitter-norg
          tsg.tree-sitter-norg-meta
        ];
      in
      [
        pkgs.vimPlugins.lz-n
        pkgs.vimPlugins.luvit-meta
        pkgs.vimPlugins.mini-align
        pkgs.vimPlugins.nvim-autopairs
        pkgs.vimPlugins.nvim-surround
        pkgs.vimPlugins.mini-cursorword
        pkgs.vimPlugins.mini-comment
        pkgs.vimPlugins.cord-nvim
        pkgs.vimPlugins.snacks-nvim
        pkgs.vimPlugins.smart-open-nvim
        pkgs.vimPlugins.sqlite-lua
        pkgs.vimPlugins.statuscol-nvim
        pkgs.vimPlugins.which-key-nvim
        pkgs.vimPlugins.better-escape-nvim
        pkgs.vimPlugins.blink-cmp
        pkgs.vimPlugins.rainbow-delimiters-nvim
        (nts.withPlugins (_: nts.allGrammars ++ norgG))
      ];

    optAttrs = mnw.lib.npinsToPluginsAttrs pkgs ./opt.json;

    dev.gerg = {
      pure =
        let
          fs = pkgs.lib.fileset;
        in
        fs.toSource {
          root = ./.;
          fileset = fs.unions [
            ./lua
            ./after
          ];
        };
      impure = "/home/antonio/Projects/nvim-flake"; # Adjust path as needed
    };
  };

  extraLuaPackages = p: [ p.jsregexp ];

  providers = {
    ruby.enable = true;
    python3.enable = true;
    nodeJs.enable = true;
    perl.enable = true;
  };

  initLua = ''
    require("gerg")
    LZN = require("lz.n")
    LZN.register_handler(require("handlers.which-key"))
    LZN.load("lazy")
    vim.cmd.colorscheme "catppuccin-mocha"
  '';

  desktopEntry = false;

  extraBinPath = [
    pkgs.deadnix
    pkgs.statix
    pkgs.nil
    pkgs.wl-clipboard
    pkgs.imagemagick
    pkgs.lua-language-server
    pkgs.stylua
    pkgs.nixd
    pkgs.ripgrep
    pkgs.fd
    pkgs.chafa
    pkgs.vscode-langservers-extracted
  ]
  ++ (
    if small then
      [ ]
    else
      [
        # Add any extra binaries for non-small builds here
        # pkgs.rustfmt
      ]
  );
}
