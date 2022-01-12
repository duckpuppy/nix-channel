with import <nixpkgs> { };
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    ruby_3_0
    pkg-config
    bundix
  ];
}
