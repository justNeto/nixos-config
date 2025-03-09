{ inputs, pkgs, pkgs-unstable, systemSettings, lib, ... }:
let
    user = ${systemSettings.username};
    # Libraries to use for general build processes (don't forget to add them to LD_LIBRARY_PATH)
    # let myLibs = with pkgs; [ openssl.dev freetype.dev fontconfig.dev pkg-config ];
in {

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; inherit systemSettings; inherit pkgs; inherit pkgs-unstable; };
        users.${user} = (import ../modules/home);
    };

    nix = {
        settings = {
            experimental-features = [ "nix-command" "flakes" ];
        };

        optimise.automatic = true;
        gc = {
            automatic = true;
            dates = "daily";
            options = "--delete-older-than 7d";
        };
    };

    documentation = {
        enable = true;

        man = {
            enable = true;
        };

        dev = {
            enable = true;
        };
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

    services = {
        # Enable CUPS to print documents.
        printing.enable = true;

        # Enable the OpenSSH daemon.
        openssh.enable = true;

        # Using localtimed for windows/linux dual booting compatibility
        localtimed.enable = true;

        # Automount drive
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;

        pulseaudio.enable = false;
        pipewire = {
            enable = true;
            pulse.enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
        };
    };

    # Enable resetting ZSA keyboards
    hardware.keyboard = {
        zsa.enable = true;
        keyboard.qmk.enable = true;
    };

    # Enable networking
    networking = {
        networkmanager.enable = true;
    }

    # Set your time zone.
    time.timeZone = "${systemSettings.timezone}";

    # Select internationalisation properties.
    i18n.defaultLocale = "${systemSettings.locale}";

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
        defaultUserShell = pkgs.zsh;
        users.${user} = {
            isNormalUser = true;
            description = "Ernesto L";
            extraGroups = [ "networkmanager" "wheel" "video" "input" ];
        };
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment = {
        sessionVariables = {
            TERMINAL = "xterm-ghostty";
            # Export the library paths for compiling and linking targets
            # LD_LIBRARY_PATH = lib.makeLibraryPath myLibs;
            # PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" myLibs;
        };

        pathsToLink = [ "/share/nautilus-python/extensions" ];
    };

    xdg.portal = {
        enable = true;
        extraPortals = [
            inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland
            pkgs.xdg-desktop-portal-gtk
        ];
        # configPackages = [ inputs.hyprland.packages.${pkgs.system}.hyprland ];
        xdgOpenUsePortal = true;
    };

    programs = {
        ssh.startAgent = true;
        zsh.enable = true;

        hyprland = {
            enable = true;
            xwayland.enable = true;
            package = inputs.hyprland.packages.${pkgs.system}.hyprland;
            portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
        };
    };

    system.stateVersion = "24.05"; #
}
