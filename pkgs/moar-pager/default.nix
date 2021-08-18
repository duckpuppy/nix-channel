{ lib, buildGoModule, fetchFromGitHub }:

let
  moar-pager = buildGoModule rec {
    pname = "moar";
    version = "1.8.1";

    src = fetchFromGitHub {
      owner = "walles";
      repo = "moar";
      rev = "v1.8.1";
      sha256 = "19q0w0384qr8zygl5jg3f28hp8p54cadf2fismcpbd360l11ivz9";
    };

    vendorSha256 = "0zhjbs8n1321307y17sjnmz4j1kzjpn4m2q27v8a9kvd0m8i73p8";

    doCheck = false;

    meta = with lib; {
      description = "Moar is a pager.";
      homepage = "https://github.com/walles/moar";
    };
  };
in
  moar-pager
