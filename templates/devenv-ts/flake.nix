{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    devenv.url = "github:cachix/devenv";
  };

  outputs = {
    self,
    nixpkgs,
    devenv,
    ...
  } @ inputs: let
    systems = ["x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];
    forAllSystems = f:
      builtins.listToAttrs (map (name: {
          inherit name;
          value = f name;
        })
        systems);
  in {
    devShells =
      forAllSystems
      (system: let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        default = devenv.lib.mkShell {
          inherit inputs pkgs;
          modules = [
            {
              # https://devenv.sh/basics/
              env.GREET = "devenv";

              # https://devenv.sh/packages/
              packages = with pkgs; [
                git
                nodejs
                nodePackages.typescript-language-server
              ];

              # https://devenv.sh/languages/
              languages.typescript.enable = true;

              # https://devenv.sh/pre-commit-hooks/
              pre-commit.hooks.eslint.enable = true;
              pre-commit.hooks.alejandra.enable = true;
              # pre-commit.hooks.statix.enable = true;
              pre-commit.hooks.prettier.enable = true;

              pre-commit.settings.eslint = {
                extensions = "\\.(ts|js)$";
              };

              # https://devenv.sh/processes/
              # processes.ping.exec = "ping example.com";
            }
          ];
        };
      });
  };
}
