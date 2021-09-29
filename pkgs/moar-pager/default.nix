{ lib, buildGoModule, fetchFromGitHub, sources ? import ../../nix/sources.nix }:

let
  moar-pager-src = sources.moar;
  moar-pager = buildGoModule rec {
    pname = "moar";
    version = sources.moar.version;

    src = moar-pager-src;

    vendorSha256 = "0zhjbs8n1321307y17sjnmz4j1kzjpn4m2q27v8a9kvd0m8i73p8";

    doCheck = false;

    meta = with lib; {
      description = "Moar is a pager.";
      homepage = "https://github.com/walles/moar";
    };
  };
in
  moar-pager
