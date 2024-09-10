{pkgs, ...}: {
  # Enable CUPS to print documents.
  services.printing = {
    enable = true;
    drivers = with pkgs; [
      (writeTextDir
        "share/cups/model/HP_Laser_10x_Series.ppd"
        (builtins.readFile ./drivers/HP_Laser_10x_Series.ppd))
      # (callPackage
      #   "./HP_laser_107a_driver.nix" {})
    ];
  };
}
