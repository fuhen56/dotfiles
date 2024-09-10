{
  description = "First time writing a flake, with the help of GPTo and Nix Wiki";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixvim.url = "github:nix-community/nixvim/";
    #nix-doom.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = {
    self,
    nixpkgs,
    # nixvim,
    # nix-doom,
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      james = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./config/james.nix
          ./config/mobile-flashing.nix
          ./config/utils/printing.nix
          # nixvim.nixosModule
          # nix-doom.nixosModule
        ];
      };
    };
  };
}
