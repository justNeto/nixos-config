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

    # Using localtimed for windows/linux dual booting compatibility
    services.localtimed.enable = true;

    # Automount drive
    services.devmon.enable = true;
    services.gvfs.enable = true;
    services.udisks2.enable = true;

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
    hardware.keyboard.qmk.enable = true;

    environment = {

        systemPackages = with pkgs; [
            git
            wget
            curl
            tmux
            gcc
            mesa
            cmake
            gnumake
            openssl
            libvdpau
            nerdfonts
            libnotify
            libva-utils
            vulkan-tools
            linuxHeaders
            zenith-nvidia
            vulkan-loader
            vulkan-headers
            libvdpau-va-gl
            nvidia-vaapi-driver
            vulkan-tools-lunarg
            vulkan-validation-layers
            inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default
            inputs.neovim-nightly-overlay.packages.${pkgs.system}.default
        ];

        variables.EDITOR = "neovim";

        sessionVariables = {
            TERMINAL		= "xterm-ghostty";
            NIXOS_OZONE_WL	= "1";
        };

        pathsToLink = [ "/share/zsh" ];
    };

    programs.ssh = {
        startAgent = false;
    };

    fonts = {
        enableDefaultPackages = true;
        packages = with pkgs; [
            (nerdfonts.override { fonts = [ "Inconsolata" ]; })
                noto-fonts
                noto-fonts-cjk
                noto-fonts-emoji
        ];

        fontconfig = {
            defaultFonts = {
                serif =  [ "Inconsolata" "Noto" ];
                sansSerif = [ "Inconsolata"  ];
                monospace = [ "Inconsolata" ];
            };
        };
    };

    # `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
    system.stateVersion = "24.05"; # Did you read the comment?
}
