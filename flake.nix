{
  description = "Nix for MacOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # don't use "follows" for nixpkgs here, as this can cause compat issues
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    determinate,
    pre-commit-hooks,
    ...
  }: let
    username = "thurstonsand";
    useremail = "thurstonsand@gmail.com";
    system = "aarch64-darwin";
    hostname = "Thurstons-MacBook-Pro";
    specialArgs =
      inputs
      // {
        inherit username useremail system hostname;
      };
  in {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake ~/.config/nix-darwin
    darwinConfigurations."${hostname}" = darwin.lib.darwinSystem {
      inherit system specialArgs;
      modules = [
        ./modules/enhanced-homebrew.nix
        ./modules/homebrew.nix
        ./modules/nix-core.nix
        ./modules/system.nix
        ./modules/users.nix

        # home manager
        home-manager.darwinModules.home-manager
        {
          users.users.${username}.home = "/Users/${username}";
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = specialArgs;
            users.thurstonsand = {
              imports = [
                (import ./home/default.nix)
              ];
            };
          };
        }
        determinate.darwinModules.default
      ];
    };
    checks.${system} = {
      # pre-commit hooks
      pre-commit-check = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          alejandra.enable = true;
        };
      };
    };
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.default = with nixpkgs.legacyPackages.${system}.pkgs;
      mkShell {
        inherit (self.checks.${system}.pre-commit-check) shellHook;
        buildInputs =
          [
            alejandra
            nixd
            nil
          ]
          ++ self.checks.${system}.pre-commit-check.enabledPackages;
      };
  };
}
