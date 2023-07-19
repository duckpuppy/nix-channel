{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Updated Rust toolchains
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-parts, ... } @ inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        inputs.devenv.flakeModule
      ];
      systems = import inputs.systems;

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devenv.shells.default = {
          # https://devenv.sh/reference/options/
          packages = with pkgs; [
            git
            zig
            cargo-zigbuild
          ];

          devcontainer.enable = true;

          # https://devenv.sh/languages/
          languages.rust.enable = true;
          languages.rust.channel = "stable";

          # https://devenv.sh/pre-commit-hooks/
          pre-commit.hooks.nixfmt.enable = true;
          pre-commit.hooks.cargo-check.enable = true;
          pre-commit.hooks.clippy.enable = true;
          pre-commit.hooks.convco.enable = true;
          pre-commit.hooks.rustfmt.enable = true;
        };
      };
    };
}
