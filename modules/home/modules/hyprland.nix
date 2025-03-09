{ inputs, pkgs, lib, config, ... }: {

    options = {
        hyprlandwm.enable = lib.mkEnableOption "enables Home-Manager Hyprland module";
        hyprlandwm.hostConfig = lib.mkOption { };
    };

    config = lib.mkIf config.hyprlandwm.enable {
        home.packages = [
            pkgs.beauty-line-icon-theme
            pkgs.dolphin
            pkgs.grimblast
            pkgs.hyprpicker
            pkgs.hyprcursor
            pkgs.hyprland-protocols
            pkgs.hyprwayland-scanner
            pkgs.imv
            pkgs.mako
            pkgs.nwg-displays
            pkgs.pywal
            pkgs.pulsemixer
            pkgs.swww
            pkgs.sweet
            pkgs.waybar
            pkgs.wl-clipboard
            pkgs.wofi
            pkgs.wev
            pkgs.wdisplays
            pkgs.wlogout
            inputs.ags.packages.${pkgs.system}.io
            inputs.ags.packages.${pkgs.system}.notifd
        ];

        home.sessionVariables = {
            NIXOS_OZONE_WL = "1";
            MOZ_DBUS_REMOTE = "1";
            HYPRCURSOR_SIZE = "32";
            TERMINAL = "xterm-ghostty";
            MOZ_ENABLE_WAYLAND = "1";
            ELM_ENGINE = "wayland_egl";
            GBM_BACKEND = "nvidia-drm";
            QT_QPA_PLATFORM = "wayland";
            XDG_SESSION_TYPE = "wayland";
            LIBVA_DRIVER_NAME = "nvidia";
            WLR_NO_HARDWARE_CURSORS = "1";
            _JAVA_AWT_WM_NONREPARENTING = "1";
            QT_WAYLAND_FORCE_DPI = "physical";
            ECORE_EVAS_ENGINE = "wayland_egl";
            _GLX_VENDOR_LIBRARY_NAME = "nvidia";
            __VK_LAYER_NV_optimus = "NVIDIA_only";
            QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
            HYPRCURSOR_THEME = "rose-pine-hyprcursor";
        };

        services = {
            hypridle = {
                enable = true;
                settings = {

                    general = {
                        lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances.
                            before_sleep_cmd = "loginctl lock-session"; # lock before suspend.
                            after_sleep_cmd =
                            "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
                    };

                    listener = [

                    {
                        timeout = 150;
                        on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
                            on-resume =
                            "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
                    }
                    {
                        timeout = 300;
                        on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
                    }
                    {
                        timeout = 600;
                        on-timeout = "systemctl suspend"; # suspend pc
                    }
                    ];

                };
                # package = inputs.hyprland.packages.${pkgs.system}.hypridle;
            };
        };
    };
}
