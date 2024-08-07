# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:
{
	imports =
		[ # Include the results of the hardware scan.
		./hardware-configuration.nix
		];

# Use the systemd-boot EFI boot loader.
	boot = {
		loader = {
			systemd-boot.enable 	= true;
			efi.canTouchEfiVariables 	= true;
			timeout			= 120;
		};

		tmp = {
			cleanOnBoot = true;
		};
	};

	networking.hostName = "justNeto-nixos"; # Define your hostname.
	# Pick only one of the below networking options.
	# networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
	networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

	# Set your time zone.
	time.timeZone = "America/Mexico_City";

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";

	# Enable the X11 windowing system.
	# services.xserver.enable = true;
	programs.zsh.enable = true;

	# Enable CUPS to print documents.
	services.printing.enable = true;

	# Documentation for man pages and stuff
	documentation = {
		enable = true;

		man = {
			enable = true;
		};

		dev = {
			enable = true;
		};
	};

	# Enable sound.
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.neto = {
		shell = pkgs.zsh;
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
	};

	# List packages installed in system profile. To search, run:
	nix.settings.experimental-features = ["nix-command" "flakes" ];

    # Enable resetting ZSA keyboards
    hardware.keyboard.zsa.enable = true;

	environment = {

		systemPackages = with pkgs; [
			git
			neovim
			wget
			curl
			tmux
			gcc
			libnotify
			nerdfonts
			inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
		];

		variables.EDITOR = "neovim";

		sessionVariables = {
			TERMINAL		= "kitty";
			NIXOS_OZONE_WL	= "1";
		};

		pathsToLink = [ "/share/zsh" ];
	};

	programs.ssh = {
		startAgent = false;
	};

	fonts.packages = with pkgs; [
		noto-fonts
		(nerdfonts.override { fonts = [ "Inconsolata" ]; })
	];

	# `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
	system.stateVersion = "24.05"; # Did you read the comment?
}
