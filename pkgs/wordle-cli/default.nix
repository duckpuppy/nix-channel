{ pkgs, lib, stdenv, fetchFromGitHub, sources ? import ../../nix/sources.nix }:
let
  version = sources.vault-aws-creds.version;
in
pkgs.python3Packages.buildPythonApplication rec {
  inherit version;
  pname = "wordle-cli";
  format = "other";

  nativeBuildInputs = [
    pkgs.makeWrapper
  ];

  src = sources.wordle-cli;

  buildPhase = "";
  installPhase = ''
    mkdir -p $out/bin
    # patchShebangs $src/play.py
    makeWrapper $src/play.py $out/bin/wordle-cli
  '';
}
