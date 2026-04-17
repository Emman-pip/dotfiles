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
  

  boot.loader = {
	  systemd-boot.enable = false;
	  efi.canTouchEfiVariables = true;
	  grub = {
		  enable = true;
		  efiSupport = true;
		  device = "nodev";
		  useOSProber = true;
	  };
  };

  hardware.trackpoint = {
	  enable = true;
	  speed = 100;
  };

  networking.hostName = "nixos"; # Define your hostname.
	system.autoUpgrade.enable = true; # failing

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;
  networking.wireless.iwd = {
    enable = true;
    settings.Settings = {
      AutoConnect = true;
    };
  };

  # networking.firewall.extraStopCommands = ''
  #   iptables -P OUTPUT ACCEPT
  # '';
  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [ "all" ];
    extraLocaleSettings = {
      LANG="en_US.UTF-8";
      LC_ALL="en_US.UTF-8";
    };
  };
	

  # i18n.extraLocaleSettings = {
	#        LANGUAGE =  "en_PH.UTF-8";
  #          LC_ALL = "C.UTF-8";
	#          LC_COLLATE = "en_PH.UTF-8";
  #          LC_MESSAGES="en_PH.UTF-8";
	#            LC_CTYPE = "en_PH.UTF-8";
  #          LC_ADDRESS = "fil_PH.UTF-8";
  #          LC_IDENTIFICATION = "fil_PH.UTF-8";
  #          LC_MEASUREMENT = "fil_PH.UTF-8";
  #          LC_MONETARY = "fil_PH.UTF-8";
  #          LC_NAME = "fil_PH.UTF-8";
  #          LC_NUMERIC = "fil_PH.UTF-8";
  #          LC_PAPER = "fil_PH.UTF-8";
  #          LC_TELEPHONE = "fil_PH.UTF-8";
  #          LC_TIME = "fil_PH.UTF-8";
  #      };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.

  services.xserver = {
	  enable = true;

	  # Enable i3wm
	  windowManager.i3 = {
		  enable =	true;
		  extraPackages = with pkgs; [
			  dmenu #application launcher most people use
			  i3status # gives you the default i3 status bar
			  i3blocks #if you are planning on using i3blocks over i3status
			  lxappearance # to change themes in i3
			  tiramisu
			  lxappearance
		  ];

	  };

	  # Configure keymap in X11
	  xkb = {
		  layout = "ph";
		  variant = "";
	  };

  };
  programs.i3lock.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = false;
  services.displayManager.ly = { 
	  enable = true;
	  settings = {
		  animation = "matrix";
		  vi_mode = true;

	  };
  };

  services.desktopManager.plasma6.enable = true;


  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
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

	# users.groups.libvirtd = {
	# 	# members = ["emmanpip"];
	# 	enable = true;
	# };

	users.groups = {
		libvirtd = {
			members = [ "emmanpip" ];
		};
	};

	virtualisation = { 
		libvirtd.enable = true;
		docker.enable = true;
		virtualbox.host.enable = true;
	};
	programs.virt-manager.enable = true;
	virtualisation.spiceUSBRedirection.enable = true;

  users.users.emmanpip = {
    isNormalUser = true;
    description = "Emman-pip";
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };


  # Install firefox.
  # programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  	neovim
	  vim
	  wget
	  curl
	  git
	  gcc
	  emacs
	  ripgrep
	  kitty
	  stow
	  zsh
	  cmake
    gnumake
    libtool
    glibc
    autoconf
    automake
	  # support both 32-bit and 64-bit applications
	  wineWowPackages.stable
	  # wine-staging (version with experimental features)
	  # wineWowPackages.staging
    # winetricks (all versions)
    winetricks
	  docker
	  docker-compose
	  fzf
	  fd
	  python314
		pyright
	  brightnessctl
	  nodejs
	  # install ly display manager
	  ly
	  # browser
	  librewolf
    chromium

    # eye protection
    redshift

    # mouseless navigation
    keynav

    # sound
    pulseaudio

    # direnv
    direnv
    ispell

    # tmux
    tmux

    # for wifi TUI
    impala

    # for power management
    # auto-cpufreq

		# for file sharing
		samba

    # for screenshots
    xclip
    maim

		# for python environment
		pyenv

    # for converting to other file formats
    pandoc

    # for office work
    libreoffice

    # for ambient sount
    blanket

    # java
    javaPackages.compiler.openjdk25

    brave
		gdb
		openvpn
		update-systemd-resolved

		clementine
		lazygit
		webkitgtk_4_1
		gtk3
		glib
		libsoup_3


		typescript-language-server
		black
		prettierd
		
  ];		

  programs.appimage.enable = true;
	programs.appimage.binfmt = true;


	services.power-profiles-daemon.enable = false;
	services.tlp = {
		enable = true;
		settings = {
			CPU_SCALING_GOVERNOR_ON_AC = "performance";
			CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

			CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
			CPU_ENERGY_PERF_POLICY_ON_AC = "performance"; # can be changed to power for power conservation

			CPU_MIN_PERF_ON_AC = 50;
			CPU_MAX_PERF_ON_AC = 100;
			CPU_BOOST_ON_AC = 1;
			CPU_HWP_DYN_BOOST_ON_AC=1;
			CPU_MIN_PERF_ON_BAT = 0;
			CPU_MAX_PERF_ON_BAT = 20;  # can be changed to 20 for power conservation

#Optional helps save long term battery health
			START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
			STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging


			START_CHARGE_THRESH_BAT1 = 40; # 40 and below it starts to charge
			STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging

			TLP_DEFAULT_MODE = "BAT";
      TLP_PERSISTENT_DEFAULT = 1;

		};
	};

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
		webkitgtk_4_1
		gtk3
		glib
		libsoup_3
    # Add other common libraries if needed
  ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
    settings = {
      General = {
        # Shows battery charge of connected devices on supported
        # Bluetooth adapters. Defaults to 'false'.
        Experimental = true;
        # When enabled other devices can connect faster to us, however
        # the tradeoff is increased power consumption. Defaults to
        # 'false'.
        FastConnectable = true;
      };
      Policy = {
        # Enable all controllers when they are found. This includes
        # adapters present on start as well as adapters that are plugged
        # in later on. Defaults to 'true'.
        AutoEnable = true;
      };
    };
  };

  services.blueman.enable = true;


  # programs.emacs = {
  #   enable = true;
  #   package = pkgs.emacs;
  #   defaultEditor = true;
  # };

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
  };

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

  services.keyd = {
	  enable = true;
	  keyboards = {
		  default = {
			  ids = [ "*" ];
			  settings = {
				  main = {
					  capslock = "overload(control, esc)";
					  rightalt = "overload(control, esc)";
					  leftalt = "overload(alt, enter)";
				  };
			  };
		  };
	  };
  };

  programs.git.enable = true;
  # programs.thefuck.enable = true;

  # ZSH
  users.defaultUserShell = pkgs.zsh;
  environment.shells = with pkgs; [ zsh ];
  programs.zsh = {
	  enable = true;
	  enableCompletion = true;
	  autosuggestions.enable = true;
	  syntaxHighlighting.enable = true;

	  shellAliases = {
	  	f = "cd $(fzf --walker=dir)";
		  # update-sys = "sudo nixos-rebuild switch";
		  update-sys = "sudo nixos-rebuild switch --flake ~/.dotfiles/OSConfig";
		  edit-sys = "sudo nvim /etc/nixos/configuration.nix";
		  packettracker = "wine /home/emmanpip/.wine/drive_c/Program\ Files/Cisco\ Packet\ Tracer\ 9.0.0/bin/PacketTracer.exe";
		  gg = "git log --all --oneline --graph";
	  };

	  histSize = 10000;
	  histFile = "$HOME/.zsh_history";


	  setOptions = [
		  "HIST_IGNORE_ALL_DUPS"
	  ];

	  ohMyZsh = {
		  enable = true;
		  plugins = [
			  "git"         # also requires `programs.git.enable = true;`
			  # "thefuck"     # also requires `programs.thefuck.enable = true;` 
		  ];
		  theme = "amuse";
	  };
  };
  system.userActivationScripts.zshrc = "touch .zshrc";


  # enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  networking.useDHCP = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8000 ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
