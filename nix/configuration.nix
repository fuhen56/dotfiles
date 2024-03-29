# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Africa/Casablanca";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable Storage Optimisation:
  nix.settings.auto-optimise-store = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.defaultSession = "plasmawayland";
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  # services.xserver.xkbDir = "/home/james/BigBagKbdTrixXKB/xkb-data_xmod/xkb/";

  # Configure console keymap
  console.keyMap = "uk";

  # Enable CUPS to print documents.
  services.printing = {
  enable = true;
  drivers = with pkgs; [ hplipWithPlugin
  # This doesn't work, sadly:( pkgs.writeTextDir "share/cups/model/HP_Laser_10x_Series.ppd" (builtins.readFile /home/james/HP_Laser_10x_Series.ppd ) )
    ];


  };

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.james = {
    isNormalUser = true;
    description = "James";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
    #  thunderbird
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.firefox.speechSynthesisSupport = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  # Declarative Home Manager:
  home-manager
  # Shell and utilities:
  #zsh-powerlevel10k
  zoxide
  # CLI:
  gpg-tui
  git
  wget
  #	Archiving tools
	unar
	unzip
  # 	ls modern alternative
  	eza
  # 	cat modern alternative
  	bat
  rclone
  btop
  # used it to clean up my boot menu: efibootmgr
  # Multi-ISO usb flashing
    ventoy
  lm_sensors
  tmux
  etcher
  woeusb
  youtube-tui
  # Cross-distro application runner
  distrobox
  # Desk utilisation
  du-dust
  gdu
  ncdu
  # List of desks
  duf
  # find alternative
  fd
  # sed alternative
  sd
  # something for browsing tree directories. Must know if it's > eza -T
  broot
  # Man pages summaries
  tldr
  # History browsing
  mcfly
  # fuzzy finder
  fzf
  # Terminal Emulators:
  alacritty
  # Editors:
  helix
  vscode
  # LSPs:
	lua-language-server
	vscode-langservers-extracted
	javascript-typescript-langserver
	#rust-language-server
	#mark
  # Knowledge system software:
  # Obsidian Removed for electron non-free errors
  obsidian
  # Clipbaord Provider for Neovim
  wl-clipboard
  # Photo editors:
  # - Kde native program
  krita
  # Media-downloder/sharer:
  # torrenting
  qbittorrent
  jackett
  # youtube/web video pirating
  yt-dlp
  # Media player
  mpv
  ffmpeg
  # Video editing
  shotcut
  # Communication:
  telegram-desktop
  # Password Manager:
  keepassxc
  # Screenshot program:
  flameshot
  # Some stuff for Flameshot to work Wayland
  xdg-desktop-portal
  xdg-desktop-portal-kde
  # Office suite:
  libreoffice
  # Ebook Library
  calibre
  # Phone integration
  # Keyboard customizing
  # Programming languages:
    typescript
	  rustc
	  cargo #for rust
	  zig
  # JavaScript runtime and tools
  nodejs
  # RSS
  # Partioning software
  partition-manager # Kde stuff
  gparted # Gnome stuff
  # ntfs support
  ntfs3g
  # HP printing support
  hplip
  # Linux unified blabla
  samsung-unified-linux-driver_1_00_37
  ];

  # It's taken from the wiki, and it doesn't work for some reason. The old method of using services.xserver.desktopManager.plasma5.excludePackages does work
  environment.plasma5.excludePackages = with pkgs.libsForQt5; 
  [
  spectacle
  elisa
  ];	

# Configuring an exception for Electron so I can get an update. This is a bad idea for long term, but it's been months since my last update.

nixpkgs.config.permittedInsecurePackages = [
      "electron-19.1.9"
];

  # Enable KDE Connect for Phone-Computer connection
  programs.kdeconnect.enable = true;
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.jackett.enable = true;
  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  systemd.services.Kmonad = {
  	enable = true;
	description = "Keyboard remapping software - For using the Extend layer and such clever stuff.";
	serviceConfig = {
		Owner="root";
		Group="root";
		Restart="always";
		ExecStart="/home/james/Kmonad/kmonad-0.4.1-linux '/home/james/Kmonad/colemak-dh-extend-iso(1).kbd'";
  	};
  	wantedBy=["graphical.target"];
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
