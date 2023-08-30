{
  description = "Nix-powered system configuration & dotfiles";

  inputs = {
    nixpkgs.follows = "nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    nur.url = github:nix-community/NUR;
    nixpkgs-fmt = {
      url = "github:nix-community/nixpkgs-fmt";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { self
    , nixpkgs
    , nix-darwin
    , home-manager
    , flake-utils
    , ...
    } @inputs:

    let
      mkHomeConfig = system: userModule: home-manager.lib.homeManagerConfiguration rec {
        pkgs = nixpkgs.legacyPackages.${system};

        modules = [
          {
            nixpkgs.overlays = [
              inputs.nur.overlays.default
              inputs.nix-vscode-extensions.overlays.default
            ];
          }
          ./home
          ./home/shell
          ./home/desktop
          userModule
        ];
      };
    in
    {
      darwinConfigurations = {
        "jabuk" = nix-darwin.lib.darwinSystem {
          specialArgs = { inherit nixpkgs inputs; };
          system = "aarch64-darwin";
          modules = [
            ./hosts/macbook-aarch64
            ./users/shared
            ./users/shared/darwin
            ./users/shared/darwin/zsh.nix
          ];
        };
      };

      homeConfigurations = {
        "davidm" = mkHomeConfig "aarch64-darwin" ./users/davidm;
        "linux" = mkHomeConfig "x86_64-linux" ./users/davidm;
      };
    } // flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import inputs.nixpkgs { inherit system; };
    in
    {
      devShells = {
        default = pkgs.mkShell {
          NIX_CONFIG = "experimental-features = nix-command flakes";
          buildInputs = [
            pkgs.nix
            pkgs.git
            pkgs.home-manager
          ];
        };
      };

      formatter = inputs.nixpkgs-fmt.defaultPackage.${system};
    });

  nixConfig = {
    commit-lockfile-summary = "chore: bump inputs";
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
}
