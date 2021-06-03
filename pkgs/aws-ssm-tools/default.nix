{ pkgs ? import <nixpkgs> {}, lib, python3Packages }:
with pkgs;
python3Packages.buildPythonApplication rec {
  pname = "aws-ssm-tools";
  version = "1.3.2";

  src = fetchFromGitHub {
    owner = "mludvig";
    repo = "aws-ssm-tools";
    rev = "4194c91557b139fca650f030441aee2af2aaaef9";
    sha256 = "1vv8qb2b2l81ivfchsvx05saf261rkq3mla4iyvsy66z1rhp1206";
  };

  propagatedBuildInputs = with python3Packages; [
    botocore
    packaging
    pexpect
    boto3
  ];

  # src = python3Packages.fetchPypi {
  #   inherit pname version;
  #   sha256 = "0901nc00r6iiyjvbq9n7gnskdbbgcgjb16z5izcl4d8c2bwrrm8b";
  # };

  doCheck = false;

  meta = {
    description = "Helper tools for AWS Systems Manager: ssm-session, ssm-ssh and ssm-tunnel.";
    homepage = "https://github.com/mludvig/aws-ssm-tools";
    license = lib.licenses.asl20;
  };
}
