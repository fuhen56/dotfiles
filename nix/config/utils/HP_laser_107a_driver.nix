{
  lib,
  fetchurl,
  stdenv,
  fetchzip,
}: let
  model = "HP_Laser_10x_Series.ppd";
  archiveUrl = "https://ftp.hp.com/pub/softlib/software13/printers/CLP150/uld-hp_V1.00.39.12_00.15.tar.gz"; # Replace with the actual URL of the archive
  archiveSha256 = "cebb9b7b6125e7406634bb9c2a98b01477d1e11d66c7c90474669de9927bc91d";
in
  stdenv.mkDerivation rec {
    name = "hp-laser-107a";

    src = fetchurl {
      url = archiveUrl;
      sha256 = archiveSha256;
    };

    installPhase = ''
      mkdir -p $out/share/cups/HP/
      tar -xzf $src --wildcards "*HP_Laser_10x_Series*" --strip-components=4 -C $out/share/cups/HP-addition/$model
    '';

    meta = with lib; {
      description = "HP Laser 107a Printer Driver";
    };
  }
