{ pkgs, systemSettings, config, ... }:
{
    imports = [ ../../modules/core ];
    bluetooth.enable = true;

    home-manager.users.${systemSettings.username} = {
        ai.enable = true;
        cad.enable = true;
        latex.enable = true;
        comms.enable = true;
        neovim.enable = true;
        others.enable = true;
        gaming.enable = true;
        android.enable = true;
        unstable.enable = true;
        internet.enable = true;
        additions.enable = true;
        utilities.enable = true;
        dev-tools.enable = true;
        hyprlandwm.enable = true;
    };

    services = {
        displayManager.sddm.enable = true;
        xserver = {
            enable = true;
            videoDrivers = [ "nvidia" ];
        };
    };

    # Select display manager as well for login shell
    hardware = {
        opengl = {
            enable = true;
            driSupport = true;
            driSupport32Bit = true;
        };

        nvidia = {
            modesetting.enable = true;
            open = false;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
                version = "555.58.02";
                sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
                sha256_aarch64 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
                openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
                settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
                persistencedSha256 = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
            };
        };
    };

    environment.systemPackages = with pkgs; [
        git
        gcc
        wget
        mesa
        tmux
        curl
        cmake
        gnumake
        ghostty
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
}
