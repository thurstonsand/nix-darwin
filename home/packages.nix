{...}: {

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
