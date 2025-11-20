{
  isWSL,
  inputs,
  ...
}:
{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    just
    silver-searcher
    tree
  ];

  home.sessionVariables = {
		EDITOR = "code";
  };

  programs.home-manager = {
    enable = true;
  };

  xdg = {
    enable = true;
    configFile = {
      "ghostty" = {
        source = ./config/ghostty;
        recursive = true;
      };
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.jq = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
  };

  programs.eza = {
    enable = true;
    git = true;
    extraOptions = [
      "--group-directories-first"
    ];
    theme = {
      extensions = { };
    };
  };

  programs.fzf = {
    colors = {
      bg = "-1";
      "bg+" = "#2a2a37";
      fg = "-1";
      "fg+" = "#dcd7ba";
      hl = "#938aa9";
      "hl+" = "#c4746e";
      header = "#b6927b";
      info = "#658594";
      pointer = "#7aa89f";
      marker = "#7aa89f";
      prompt = "#c4746e";
      spinner = "#8ea49e";
    };
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    defaultCommand = "ag -l '.'";
    defaultOptions = [
      "-e"
      "--height=40%"
      "--color=dark"
      "--layout=reverse"
    ];
  };

  programs.git = {
    enable = true;
    delta.enable = true;
    lfs.enable = true;

    userName = "Kenneth Hill";
    userEmail = "hillk7037@gmail.com";

    ignores = [
      ".DS_Store"
      ".direnv/"
      "*.sw?"
    ];
  };

  programs.zoxide = {
    enable = true;
  };

  programs.direnv = {
    enable = true;

    config = {
      global = {
        warn_timeout = "30s";
        strict_env = true;
        hide_env_diff = true;
      };
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "TTY";
      theme_background = false;
    };
  };

  programs.neovim = {
    enable = false;
    plugins = with pkgs.vimPlugins; [
      kanagawa-paper-nvim
      nvim-lspconfig
      nvim-ufo
      plenary-nvim
      hunk-nvim
      (nvim-treesitter.withPlugins (
        plugins: with plugins; [
          c
          c-sharp
          css
          dockerfile
          elixir
          erlang
          go
          html
          javascript
          jsdoc
          json
          jsonc
          just
          ledger
          lua
          nix
          python
          razor
          terraform
          toml
          tsx
          typescript
          yaml
        ]
      ))
    ];
  };

  programs.zsh = {
    enable = true;

    autocd = true;
    autosuggestion.enable = false;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initContent = builtins.readFile ./init.zsh;

    shellAliases = {
      j = "just";
      vi = "nvim";
      vim = "nvim";
    };

    sessionVariables = {
      EZA_CONFIG_DIR = "~/.config/eza";
    };

    history = {
      append = true;
      extended = true;
      ignoreAllDups = true;
      ignoreDups = true;
      ignoreSpace = true;
      path = "${config.home.homeDirectory}/.zsh_history";
      save = 8000;
      saveNoDups = true;
      share = true;
    };
  };
}
