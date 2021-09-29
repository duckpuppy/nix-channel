{ stdenv
, lib
, makeWrapper
, fetchFromGitLab
, sources ? import ../../nix/sources.nix
}:
stdenv.mkDerivation rec {
  pname = "wsl-open";
  version = sources.wsl-open.version;
  src = sources.wsl-open;
  buildInputs = [ makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    makeWrapper ${src}/wsl-open.sh $out/bin/wsl-open
    mkdir -p $out/usr/share/man/man1
    cp wsl-open.1 $out/usr/share/man/man1
  '';

  meta = with lib; {
    description = "Open files with xdg-open on Bash for Windows in Windows applications";
    license = licenses.mit;
    homepage = "https://gitlab.com/4U6U57/wsl-open";
    # maintainers = [ maintainers.meatcar ];
    # platforms = platforms.linux;
  };
}
