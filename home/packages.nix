{ pkgs, ...}: {

  home.packages = with pkgs; [
    git-credential-manager
  ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = "auto";
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
        credential = {
          helper = "/usr/local/share/gcm-core/git-credential-manager";
        };
        gpg = {
          format = "ssh";
        };
        "gpg \"ssh\"" = {
          program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
        };
      };
    };

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
        "ll" = "ls -l";
        "la" = "ls -la";
        "l" = "ls -CF";
      };
    };
  };
}
