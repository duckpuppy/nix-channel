{ pkgs ? import <nixpkgs> {}, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "ls-colors";
  src = fetchFromGitHub {
    owner = "trapd00r";
    repo = "LS_COLORS";
    rev = "master";
    sha256 = "1wnzaay4r6sbqnxylpc31pwsq89km8y5f9caf0fq60lfabg139g3";
    # sha256 = "1cxa95qhg2x0az20rg19pc9larlgp1igl9w43bpbqqxs8m32qdka";
  };
  installPhase = ''
    mkdir -p $out/bin $out/share/ls-colors
    cp ${src}/LS_COLORS $out/share/ls-colors
  '';
}
