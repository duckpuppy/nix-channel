{ pkgs, lib, stdenv, fetchFromGitHub, sources ? import ../../nix/sources.nix }:
pkgs.python3Packages.buildPythonApplication rec {
  pname = "wordle-cli";
  format = "other";
  version = "0.1.0";

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
