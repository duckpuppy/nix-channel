{ pkgs ? import <nixpkgs> {}, stdenv, fetchFromGitHub, sources ? import ../../nix/sources.nix }:

stdenv.mkDerivation rec {
  name = "ls-colors";
  src = sources.LS_COLORS;
  installPhase = ''
    mkdir -p $out/bin $out/share/ls-colors
    cp ${src}/LS_COLORS $out/share/ls-colors
  '';
}
