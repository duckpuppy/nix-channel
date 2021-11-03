{ pkgs, lib, stdenv, fetchFromGitHub, sources ? import ../../nix/sources.nix }:
let
  version = sources.vault-aws-creds.version;
in
  pkgs.python3Packages.buildPythonApplication rec {
    inherit version;
    pname = "vault-aws-creds";
    format = "other";

    nativeBuildInputs = [
      pkgs.makeWrapper
    ];

    src = sources.vault-aws-creds;

    buildPhase = "";
    installPhase = ''
      mkdir -p $out/bin $out/share/vault-aws-creds
      cp $src/*.py $out/share/vault-aws-creds

      cat > $out/bin/aws-console <<EOF
      #! /bin/bash
      open \$($out/share/vault-aws-creds/aws-sts-console-url.py)
      EOF
      chmod +x $out/bin/aws-console
    '';
  }

