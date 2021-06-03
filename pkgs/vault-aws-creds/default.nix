{ lib, stdenv, fetchFromGitHub }:
let
  version = "0.2.9";
in
  stdenv.mkDerivation {
    inherit version;
    name = "vault-aws-creds";
    src = fetchFromGitHub {
      owner = "jantman";
      repo = "vault-aws-creds";
      rev = "338a1d2b4b653c83452de4842a4bf811958a94a3";
      sha256 = "116q9ya4z70vcjhb6ibrdzv8prh8kk9adhwf3blffs4h2xrjvixb";
    };
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

