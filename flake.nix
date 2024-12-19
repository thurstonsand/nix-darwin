{
  description = "Nix for MacOS";

  # the nixConfig here only affects the flake itself, not the system configuration
  #   nixConfig = {
  #     substituters = [
  #     # Query the mirror of USTC first, and then the official cache.
  #     "https://mirrors.ustc.edu.cn/nix-channels/store"
  #     "https://cache.nixos.org"
  #     ];
  # };
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
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/0.1";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    darwin,
    determinate,
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
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    devShells.${system}.default = with nixpkgs.legacyPackages.${system}.pkgs;
      mkShell {
        buildInputs = [
          alejandra
          nixd
          nil
        ];
      };
  };
}
