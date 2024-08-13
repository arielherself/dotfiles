with import <nixpkgs> {};
pkgs.stdenv.mkDerivation rec {
    name = "thorium-${version}";
    version = "124.0.6367.218";

    src = pkgs.fetchurl {
        url = "https://github.com/Alex313031/thorium/releases/download/M${version}/thorium-browser_${version}_AVX2.deb";
        hash = "sha256-nXz5ocZYDBWLIaARk8lN9LhP+7p8bEx+Kk+JAT2tG5c=";
    };
    sourceRoot = ".";
    unpackPhase = "dpkg-deb --fsys-tarfile ${src} | tar -x --no-same-owner";

    nativeBuildInputs = [
        pkgs.dpkg
        pkgs.autoPatchelfHook
        pkgs.qt5.wrapQtAppsHook
        pkgs.wrapGAppsHook
    ];

    buildInputs = with pkgs; [
        glib
        libgcc
        qt5.full
        qt6.full
        qt5.qtbase
        cairo
        at-spi2-atk
        pango
        cups
        libGL
    ];

    dontConfigure = true;
    dontBuild = true;

    installPhase= ''
        runHook preInstall

        mkdir -p $out/bin
        mkdir -p $out/share
        cp -R usr/bin $out/
        cp -R usr/share $out/
        cp -R opt $out/
        substituteInPlace $out/share/applications/thorium-browser.desktop --replace /usr/bin/ $out/bin/
        substituteInPlace $out/share/applications/thorium-shell.desktop --replace /usr/bin/ $out/bin/
        substituteInPlace $out/share/applications/thorium-shell.desktop --replace /opt/ $out/opt/
        substituteInPlace $out/bin/thorium-shell --replace /opt/ $out/opt/

        patchelf $out/opt/chromium.org/thorium/thorium --add-needed libGL.so.1

        ln -fs $out/opt/chromium.org/thorium/thorium-browser $out/bin/thorium-browser

        runHook postInstall
    '';

    # preFixup = ''
    #     makeWrapperArgs+=("''${qtWrapperArgs[@]}")
    # '';

    meta = with lib; {
        homepage = "https://thorium.rocks";
        description = "Web Browser";
        platforms = platforms.linux;
    };
}
