{
  config,
  pkgs,
  ...
}: {
  config = {
    users = {
      users = {
        james = {
          packages = with pkgs; [
            android-tools
            heimdall
            heimdall-gui
            libusb1
          ];
        };
      };
    };
    # services.udev.extraRules = ''
    #     SUBSYSTEM=="usb", ATTR{idVendor}=="04e8", MODE="0666", GROUP="plugdev"
    #   '';
  };
}
