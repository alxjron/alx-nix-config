{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  name = "alx-wallpapers";
  pname = name;

  src = ./src-backgrounds;

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp $src/* $out/share/wallpapers/
  '';
}
