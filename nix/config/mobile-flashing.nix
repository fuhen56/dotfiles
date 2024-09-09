{
  config,
  pkgs,
  ...
}: {
  config.users = {
    users = {
      james = {
        packages = with pkgs; [
          android-tools
          heimdall
          lz4
          libusb1
        ];
      };
    };
  };
}
