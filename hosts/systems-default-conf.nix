{ inputs, pkgs, pkgs-unstable, systemSettings, ... }:
{
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
                noto-fonts-cjk-sans
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
        geoclue2.enable = true;
        localtimed.enable = true;

        # Automount drive
        devmon.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;

        pipewire = {
            enable = true;
            pulse.enable = true;
            alsa.enable = true;
            alsa.support32Bit = true;
        };
    };

    # Enable networking
    networking = {
        networkmanager.enable = true;
    };

    # Select internationalisation properties.
    i18n.defaultLocale = "${systemSettings.locale}";

    environment = {
        sessionVariables = {
            TERMINAL = "xterm-ghostty";
            # Export the library paths for compiling and linking targets
            # LD_LIBRARY_PATH = lib.makeLibraryPath myLibs;
            # PKG_CONFIG_PATH = lib.makeSearchPath "lib/pkgconfig" myLibs;
        };

        systemPackages = with pkgs; [
            # Packages that I always want in my system
            git
            gcc
            wget
            tmux
            curl
            cmake
            gnumake
            openssl
            nerdfonts
            libva-utils
            vulkan-tools
            linuxHeaders
            zenith-nvidia
            vulkan-loader
            vulkan-headers
            vulkan-tools-lunarg
            vulkan-validation-layers
            mesa

            # TODO: move ghostty + rose-pine to module files
            inputs.ghostty.packages.${pkgs.system}.default
            inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default

            # Some graphic oriented system graphics. TODO: move them to extra packages
            libnotify
            libvdpau
            libvdpau-va-gl
            nvidia-vaapi-driver
        ];
    };

    system.stateVersion = "24.11"; #
}
