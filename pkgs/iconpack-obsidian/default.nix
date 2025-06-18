{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  gtk3,
  gnome-icon-theme,
  mint-x-icons,
  hicolor-icon-theme,
}:

stdenvNoCC.mkDerivation rec {
  pname = "iconpack-obsidian";
  version = "4.15";

  src = fetchFromGitHub {
    owner = "EightBitApple";
    repo = "iconpack-obsidian";
    rev = "master";
    sha256 = "sha256-7G2XDS49CZgQqbnUADHWyw9Ko8kGuFkFWc0fqHR7xgE=";
  };

  nativeBuildInputs = [ gtk3 ];

  propagatedBuildInputs = [
    gnome-icon-theme
    mint-x-icons
    hicolor-icon-theme
  ];
  # still missing parent themes: Ambient-MATE, Faenza-Dark, KFaenza

  dontDropIconThemeCache = true;

  installPhase = ''
    mkdir -p $out/share/icons
    mv Obsidian* $out/share/icons

    for theme in $out/share/icons/*; do
      gtk-update-icon-cache $theme
    done
  '';

  meta = with lib; {
    description = "Gnome icon pack based upon Faenza";
    homepage = "https://github.com/EightBitApple/iconpack-obsidian";
    license = licenses.gpl3Only;
    # darwin cannot deal with file names differing only in case
    platforms = platforms.linux;
    maintainers = [ maintainers.romildo ];
  };
}
