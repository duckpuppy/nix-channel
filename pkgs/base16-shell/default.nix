{ stdenv }:

stdenv.mkDerivation {
  name = "base16-shell";
  src = stdenv.fetchFromGitHub {
    owner = "chriskempson";
    repo = "base16-shell";
    rev = "master";
    sha256 = "1yj36k64zz65lxh28bb5rb5skwlinixxz6qwkwaf845ajvm45j1q";
  };
  installPhase = ''
     mkdir -p $out/share/base16-shell
     cp -r * $out/share/base16-shell/
  '';
}
