{ inputs, pkgs, pkgs-unstable, lib, systemSettings, ... }:
{
    home.username = "${systemSettings.username}";
    home.homeDirectory = "/home/${systemSettings.username}";
    home.stateVersion = "24.05";

    home.packages = [
        pkgs.ani-cli
        pkgs.bat
        pkgs.btop
        pkgs.dogdns
        pkgs.fastfetch
        pkgs.ffmpeg
        pkgs.fd
        pkgs.fzf
        pkgs.lazygit
        pkgs.lsd
        pkgs.mpv
        pkgs.morgen
        pkgs-unstable.nodejs_23
        pkgs.obs-studio
        pkgs.obsidian
        pkgs.pipe-viewer
        pkgs.python3
        pkgs.ripgrep
        pkgs.tree
        pkgs.yt-dlp
        pkgs.yazi
        pkgs.zoxide
    ];

    # Common, simple programs every system should have
    programs = {
        home-manager.enable = true; # enable home manager

        btop = {
            enable = true;
            settings = {
                vim_keys = true;
                color_theme = "default";
                theme_background = true;
            };
        };

        yt-dlp.enable = true;
        yazi.enable = true;
        zoxide.enable = true;
    };

    imports = [ ./modules ];

    xdg = {
        enable = true;
        userDirs = {
            enable = true;
            createDirectories = false;
            desktop = "/home/${systemSettings.username}/desktop";
            documents = "/home/${systemSettings.username}/projects";
            download = "/home/${systemSettings.username}/downloads";
            pictures = "/home/${systemSettings.username}/imgs";
            templates = "/home/${systemSettings.username}/templates";
            videos = "/home/${systemSettings.username}/vids";
            extraConfig = {
                XDG_SCREENSHOTS_DIR = "/home/${systemSettings.username}/.screenshots";
            };
        };

        mime.enable = true;
    };

    dconf = {
        enable = true;
        settings = { "org/gnome/desktop/interface" = { color-scheme = "prefer-dark"; }; };
    };

    gtk = {
        enable = true;
        theme = {
            name = "Sweet";
            package = (pkgs.sweet.override {
                    colorVariants = [ "Sweet-Dark" ];
            });
        };

        iconTheme = {
            name = "BeautyLine";
            package = pkgs.beauty-line-icon-theme;
        };

        font = {
            name = "Inconsolata Nerd Font";
            size = 14;
        };
    };

    home.sessionVariables = { GTK_THEME = "Sweet-Dark"; };
}
