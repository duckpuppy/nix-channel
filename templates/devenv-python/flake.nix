{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  # https://devenv.sh/reference/options/
                  packages = with pkgs; [
                    git
                    pdm
                  ];

                  # https://devenv.sh/languages/
                  languages.python.enable = true;
                  languages.python.package = pkgs.python311;
                  languages.python.venv.enable = true;

                  # https://devenv.sh/pre-commit-hooks/
                  pre-commit.hooks.black.enable = true;
                  pre-commit.hooks.alejandra.enable = true;
                  pre-commit.hooks.prettier.enable = true;
                }
              ];
            };
          });
    };
}
