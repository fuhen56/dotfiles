{pkgs}: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      hplipWithPlugin
      # This doesn't work, sadly:( pkgs.writeTextDir "share/cups/model/HP_Laser_10x_Series.ppd" (builtins.readFile /home/james/HP_Laser_10x_Series.ppd ) )
    ];
  };
}
