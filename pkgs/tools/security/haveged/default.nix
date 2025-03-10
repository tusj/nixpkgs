{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "haveged";
  version = "1.9.15";

  src = fetchFromGitHub {
    owner = "jirka-h";
    repo = "haveged";
    rev = "v${version}";
    sha256 = "sha256-bU+/lRx0RAqHheNQ9CWT/V0oZnZd0W9EHhhX3RRIZ/0=";
  };

  strictDeps = true;

  postPatch = ''
    patchShebangs ent # test shebang
  '';

  installFlags = [
    "sbindir=$(out)/bin" # no reason for us to have a $out/sbin, its just a symlink to $out/bin
  ];

  doCheck = true;

  meta = with lib; {
    description = "A simple entropy daemon";
    longDescription = ''
      The haveged project is an attempt to provide an easy-to-use, unpredictable
      random number generator based upon an adaptation of the HAVEGE algorithm.
      Haveged was created to remedy low-entropy conditions in the Linux random device
      that can occur under some workloads, especially on headless servers. Current development
      of haveged is directed towards improving overall reliability and adaptability while minimizing
      the barriers to using haveged for other tasks.
    '';
    homepage = "https://github.com/jirka-h/haveged";
    license = licenses.gpl3;
    maintainers = with maintainers; [ domenkozar ];
    platforms = platforms.unix;
  };
}
