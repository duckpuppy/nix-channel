{
  description = "My personal NUR repository";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  outputs = { self, nixpkgs }:
    let
      systems = [
        "x86_64-linux"
        "i686-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "armv6l-linux"
        "armv7l-linux"
      ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in
    {
      packages = forAllSystems (system: import ./default.nix {
        pkgs = import nixpkgs { inherit system; };
      });

      templates =
        {
          simple = {
            path = ./templates/devenv-simple;
            description = "A basic direnv supported Nix flake with devenv integration.";
          };
          typescript = {
            path = ./templates/devenv-ts;
            description = "Minimal TypeScript project using devenv.";
          };
          default = simple;
        };
    };
}
