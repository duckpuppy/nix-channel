{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  name = "vault-aws-creds";
  src = fetchFromGitHub {
    owner = "jantman";
    repo = "vault-aws-creds";
    rev = "master";
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

