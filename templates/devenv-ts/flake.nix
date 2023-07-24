{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
    flake-parts.url = "github:hercules-ci/flake-parts";
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
            nodejs
            nodePackages.typescript-language-server
            yarn
          ];

          devcontainer.enable = true;

          # https://devenv.sh/languages/
          languages.typescript.enable = true;

          # https://devenv.sh/pre-commit-hooks/
          pre-commit.hooks.nixfmt.enable = true;
          pre-commit.hooks.convco.enable = true;
          pre-commit.hooks.eslint.enable = true;
          pre-commit.hooks.prettier.enable = true;

          pre-commit.settings.eslint = {
            extensions = "\\.(ts|js)$";
          };
        };
      };
    };
}
