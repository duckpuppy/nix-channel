{ stdenv
, lib
, makeWrapper
, fetchFromGitLab
}:
stdenv.mkDerivation rec {
  pname = "wsl-open";
  version = "2.2.1";
  src = fetchFromGitLab {
    owner = "4U6U57";
    repo = "wsl-open";
    rev = "6419bb63845acd0533f30bdc8258f8df5fbb25cb";
    sha256 = "00d2f7cw5mqj6czidlc6xwih0id33kf9c94k8nis28k0fw6s8ska";
  };
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
