{pkgs, ...}: {
  home.packages = with pkgs; [
    ack
    git-credential-manager
    prettyping
    tldr
  ];

  programs = {
    bat = {
      enable = true;
    };

    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    git = {
      enable = true;
      ignores = [
        ".DS_Store"
        ".vscode"
        ".cache"
        ".nix"
      ];
      userEmail = "thurstonsand@gmail.com";
      userName = "Thurston Sandberg";
      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF6GpY+hdZp60Fbnk9B03sntiJRx7OgLwutV5vJpV6P+";
        signByDefault = true;
      };
      lfs.enable = true;
      maintenance = {
        enable = true;
        repositories = [
          "/Users/thurstonsand/.config/nix-darwin"
        ];
      };
      extraConfig = {
        color.ui = "auto";
        credential.helper = "/usr/local/share/gcm-core/git-credential-manager";
        gpg.format = "ssh";
        "gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        init.defaultBranch = "main";
        pull.rebase = true;
        push = {
          default = "simple";
          autoSetupRemote = true;
        };
      };
    };

    htop.enable = true;

    lazygit.enable = true;

    neovim = {
      enable = true;
      defaultEditor = true;
      coc.enable = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPython3Packages = ps: [ps.pynvim];
    };

    starship = {
      enable = true;
      settings = {
        hostname.disabled = true;
        username.disabled = true;
      };
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;

      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        ignoreSpace = true;
        share = true;
        size = 1000;
        save = 10000;
      };
      shellAliases = {
        "cat" = "TRY bat\n; cat";
        "grep" = "echo TRY ack\n; grep";
        "ll" = "ls -l";
        "la" = "ls -la";
        "l" = "ls -CF";
        "ping" = "prettyping";
        "switch" = "darwin-rebuild switch --flake ~/.config/nix-darwin";
        "top" = "htop";
      };
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = [
        "--cmd j"
      ];
    };
  };
}
