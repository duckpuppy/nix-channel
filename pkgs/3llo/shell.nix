with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    ruby_3_1
    pkg-config
    bundix
  ];
}
