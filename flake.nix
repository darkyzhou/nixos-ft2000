{
  description = "NixOS for Phytium FT-2000/4";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    { self, nixpkgs }:
    let
      systemCross = "x86_64-linux";
      eachSystem = nixpkgs.lib.genAttrs [ systemCross ];
    in
    {
      legacyPackages = eachSystem (
        system:
        import nixpkgs {
          inherit system;
          crossSystem = {
            config = "aarch64-unknown-linux-gnu";
          };
        }
      );

      packages.${systemCross}.kernel = self.legacyPackages.${systemCross}.callPackage ./kernel { };

      nixosConfigurations.raven = nixpkgs.lib.nixosSystem {
        system = "aarch64-linux";
        modules = [
          ./configuration.nix
          ./hardware.nix
          { nixpkgs.pkgs = self.legacyPackages.${systemCross}; }
        ];
      };
    };
}
