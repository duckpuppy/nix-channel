{ pkgs ? import <nixpkgs> {} }:

with pkgs;
bundlerApp {
  pname = "3llo";

  gemfile = ./Gemfile;
  lockfile = ./Gemfile.lock;

  gemset = import ./gemset.nix;

  inherit ruby;

  exes = [ "3llo" ];

  meta = with lib; {
    description = "Trello interactive CLI on terminal";
    license = licenses.mit;
    homepage = "https://github.com/qcam/3llo";
    maintainers = with maintainers; [ ];
  };
}
