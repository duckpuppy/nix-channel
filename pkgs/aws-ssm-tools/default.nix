{ pkgs ? import <nixpkgs> { }, lib, python3Packages }:
with pkgs;
python3Packages.buildPythonApplication rec {
  pname = "aws-ssm-tools";
  version = "1.5.1";

  src = fetchFromGitHub {
    owner = "mludvig";
    repo = "aws-ssm-tools";
    rev = "efd8bb405632fa9090b03c3dd3ef0f1cd7804cac";
    sha256 = "sha256-9YnsmyITwbuzOBhJ+YDLQot/qFlKpyr5pZ8UI9vwNCc=";
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
