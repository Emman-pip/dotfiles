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
	  speed = 255;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Manila";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_PH.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fil_PH";
    LC_IDENTIFICATION = "fil_PH";
    LC_MEASUREMENT = "fil_PH";
    LC_MONETARY = "fil_PH";
    LC_NAME = "fil_PH";
    LC_NUMERIC = "fil_PH";
    LC_PAPER = "fil_PH";
    LC_TELEPHONE = "fil_PH";
    LC_TIME = "fil_PH";
  };

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
  users.users.emmanpip = {
    isNormalUser = true;
    description = "Emman-pip";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
      #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

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
	  flameshot
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
	  brightnessctl
	  nodejs
	  # install ly display manager
	  ly
	  # browser
	  librewolf
  ];

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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
