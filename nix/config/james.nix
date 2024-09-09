# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Bootloader.
  config = {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    
    hardware = {
      firmware = with pkgs; [
        rtl8761b-firmware
      ];

      # Enable bluetooth:
      bluetooth = {
        enable = true;
        powerOnBoot = true; # Adds to the "boot sequence". Elias.
        settings = {
          General = {
            Experimental = true; # Battery life.
            EnableLEFeatures = true; # Bluetooth Low-Energy.
          };
        };
      };
    };
    
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
    # And
    # Enable the KDE Plasma Desktop Environment.
    services = {
      xserver = {
        enable = true;
        desktopManager.plasma5.enable = true;
      };
      jackett = {
        enable = true;
      };
      displayManager.defaultSession = "plasmawayland";
    };

    # Configure keymap in X11
    # services.xserver.xkbDir = "/home/james/BigBagKbdTrixXKB/xkb-data_xmod/xkb/";

    # Configure console keymap
    # console.keyMap = "uk";

    # Enable CUPS to print documents.
    services.printing = {
      enable = true;
      drivers = with pkgs; [
        hplipWithPlugin
        # This doesn't work, sadly:( pkgs.writeTextDir "share/cups/model/HP_Laser_10x_Series.ppd" (builtins.readFile /home/james/HP_Laser_10x_Series.ppd ) )
      ];
    };

    # Enable sound with pipewire.
    sound.enable = true;
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
    users = {
      users = {
        james = {
          isNormalUser = true;
          description = "James";
          extraGroups = ["networkmanager" "wheel"];
          packages = with pkgs; [
            firefox
            firefox-devedition-bin
            easyeffects
            # thunderbird

            # Programming languages:
            # Web
            typescript
            # Low level
            rustc
            cargo #for rust
            gcc
            clang
            zig
            # Scripting
            python313
            python311Packages.ipython
            lua
            luajit
            # JavaScript runtime and tools
            nodejs
            create-react-app
            # LSPs:
            lua-language-server
            vscode-langservers-extracted
            javascript-typescript-langserver
            nixd
            rust-analyzer
            marksman
            neofetch
          ];
        };
        temp = {
          description = "Temporary user";
          group = "temp";
          isNormalUser = true;
          packages = with pkgs; [
            firefox
          ];
        };
      };
      groups = {
        temp = {};
      };
    };
    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
      # Shell and utilities:
      # zsh-powerlevel10k
      zoxide
      # CLI:
      # TUI Browsers:
      # browsh
      # carbonyl
      # gpg-tui
      git
      lazygit
      wget
      #	Archiving tools
      unar
      unzip
      # 	ls modern alternative
      eza
      # 	cat modern alternative
      bat
      # Back up software
      rclone

      # system monitoring
      btop

      # Easy VM setup
      # quickemu
      # windows emulator
      # wine
      # used it to clean up my boot menu: efibootmgr
      # Multi-ISO usb flashing
      # ventoy
      lm_sensors
      tmux
      # youtube-tui
      # Cross-distro application runner
      # distrobox
      # Desk utilisation
      du-dust
      gdu
      # List of desks
      duf
      # find alternative
      fd
      ripgrep
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
      # Fonts:
      #font-awesome
      nerdfonts
      # Editors:
      helix

      # Knowledge system software:
      obsidian

      # Spaced repetition
      anki
      mnemosyne

      # Clipbaord Provider for Neovim
      wl-clipboard

      # Photo editors:
      # - Kde native program
      krita
      # Vector image editor
      inkscape

      # Media-downloder/sharer:
      # torrenting
      qbittorrent
      jackett

      # Recording
      obs-studio

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

      # Office suite:
      libreoffice

      # Document Conversion; No walled garden
      pandoc
      mupdf
      # Documentation reader: for offline MDN browsing, though still haven't figured it out
      zeal
      # Ebook Library
      calibre
      zathura
      # Phone integration
      # Keyboard customizing
      # RSS
      # Partioning software
      partition-manager
      gparted
      # ntfs support
      ntfs3g
      # HP printing support
      hplip
      # Linux unified blabla
      samsung-unified-linux-driver
    ];

    # It's taken from the wiki, and it doesn't work for some reason. The old method of using services.xserver.desktopManager.plasma5.excludePackages does work
    environment.plasma5.excludePackages = with pkgs.libsForQt5; [
      spectacle
      elisa
    ];

    # Configuring an exception for Electron so I can get an update. This is a bad idea for long term, but it's been months since my last update.

    nixpkgs.config.permittedInsecurePackages = [
      "electron-25.9.0"
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
    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;
    systemd.services.Kmonad = {
      enable = true;
      description = "Keyboard remapping software - For using the Extend layer and such clever stuff.";
      serviceConfig = {
        Owner = "root";
        Group = "root";
        Restart = "always";
        ExecStart = "/home/james/Kmonad/kmonad-0.4.1-linux '/home/james/Kmonad/colemak-dh-extend-iso(1).kbd'";
      };
      wantedBy = ["graphical.target"];
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "23.05"; # Did you read the comment?
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
