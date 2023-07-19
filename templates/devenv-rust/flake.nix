{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, devenv, systems, fenix, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            # pkgs = nixpkgs.legacyPackages.${system};
            pkgs = import nixpkgs {
              inherit system;
              overlays = [
                fenix.overlays.default
              ];
            };
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = with pkgs; [
                    git
                    zig
                    cargo-zigbuild
                  ];

                  # https://devenv.sh/languages/
                  languages.rust.enable = true;
                  languages.rust.channel = "stable";

                  # https://devenv.sh/pre-commit-hooks/
                  pre-commit.hooks.nixfmt.enable = true;
                  pre-commit.hooks.cargo-check.enable = true;
                  pre-commit.hooks.clippy.enable = true;
                  pre-commit.hooks.convco.enable = true;
                  pre-commit.hooks.rustfmt.enable = true;
                }
              ];
            };
          });
    };
}
