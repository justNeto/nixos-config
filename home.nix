{ config, pkgs, inputs, ... }:
{
    home.username      = "neto";
    home.homeDirectory = "/home/neto";

    home.sessionPath   = [
        "$HOME/.local/bin/"
        "$HOME/.local/bin/"
        "$HOME/.local/bin/system"
        "$HOME/.local/bin/py-scripts"
        "$HOME/.local/bin/utils"
        "$HOME/.local/bin/utils/.local"
        "$HOME/.local/bin/utils/.local/share"
        "$HOME/.local/bin/utils/.local/share/nvim"
        "$HOME/.local/bin/wallpaper"
    ];

    home.packages = with pkgs; [
        ani-cli
        android-tools
        android-studio
        android-studio-tools
        bat
        beauty-line-icon-theme
        btop
        blueman
        ctpv
        cinnamon.nemo
        calc
        evtest
        freecad
        fzf
        file
        firefox
        flutter
        fd
        fastfetch
        gamescope
        gamemode
        gimp
        grimblast
        hyprpicker
        imv
        kitty
        lf
        lsd
        mako
        mangohud
        mpvpaper
        morgen
        nwg-displays
        obs-studio
        obsidian
        openscad-unstable
        python3
        pipe-viewer
        pulsemixer
        prusa-slicer
        pv
        pywal
        pico-sdk
        qbittorrent
        ripgrep
        ripdrag
        slack
        speedtest-cli
        stow
        steam
        swww
        scrcpy
        tor-browser
        telegram-desktop
        tree
        vesktop
        unzip
        waybar
        wl-clipboard
        wofi
        wally-cli
        yt-dlp
        cargo
        zathura
        zoom
        zoxide
        zip
        qmk
        libreoffice
    ];

    programs = {

        firefox = {
            enable		= true;

            profiles.justNeto = {

                id                                 = 0;
                isDefault                          = true;
                name                               = "justNeto";

                settings = {
                    full-screen-api.ignore-widgets = true;
                };

                search.engines = {
                    "Nix Packages" = {
                        urls = [{
                            template = "https://search.nixos.org/packages?query={searchTerms}";
                        }];

                        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
                        definedAliases = [ "@np" ];
                    };

                    "NixOS Opts" = {
                        urls = [{
                            template = "https://search.nixos.org/options?query={searchTerms}";
                        }];
                        definedAliases = [ "@no" ];
                    };

                    "NixOS Wiki" = {
                        urls = [{ template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; }];
                        iconUpdateURL = "https://wiki.nixos.org/favicon.png";
                        updateInterval = 24 * 60 * 60 * 1000; # every day
                            definedAliases = [ "@nw" ];
                    };

                    "Brave Search" = {
                        urls = [{ template = "https://search.brave.com/search?q={searchTerms}"; }];
                        definedAliases = [ "@bs" ];
                    };
                };

                extensions     = with inputs.firefox-addons.packages."x86_64-linux"; [
                    ublock-origin
                    darkreader
                    return-youtube-dislikes
                    vimium-c
                ];

                search.default = "Brave Search";

                search.force   = true;

                search.order   = [
                    "Brave Search"
                        "Nix Packages"
                        "DuckDuck Go"
                ];

            };

            profiles.Profesional = {

                id   = 1;
                name = "Profesional";

                settings = {
                    full-screen-api.ignore-widgets = true;
                };

                extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
                    ublock-origin
                        darkreader
                        return-youtube-dislikes
                        vimium-c
                ];
            };
        };

        neovim = {
            enable = true;

            viAlias = true;
            vimAlias = true;
            vimdiffAlias = true;

            defaultEditor	= true;
        };

        git = {
            enable		= true;
            userName 	= "justNeto";
            userEmail	= "continental.lelgg.2b@gmail.com";
        };

        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };

        zsh = {
            enable			= true;
            enableCompletion	= true;

            autocd = true;

            autosuggestion = {
                enable		= true; # highlight	= "fg=#ff00ff,bg=cyan,bold,underline";
            };

            history = {
                path = "$ZDOTDIR/history";
                save = 2000;
            };

            dotDir = ".config/shell";

            shellAliases = {

                # Sudo aliases I need available
                cs     = "sudo chmod +x";
                sn     = "sudoedit";
                rmd    = "sudo rm -rf";
                srwpt  = "sudo cat /tmp/rwptimer";
                awp    = "sudo chmod a+w";

                # Regular aliases
                cd     = "z";
                cp     = "cp -iv";
                mv     = "mv -iv";
                rm     = "rm -vI";
                mkd    = "mkdir -pv";
                ffmpeg = "ffmpeg -hide_banner";
                ls     = "lsd --sort extension --group-dirs first --total-size --permission octal";
                grep   = "grep --color = auto";
                diff   = "diff --color = auto";
                cat    = "bat";
                gcl    = "git clone";
                gA     = "git add -A";
                ga     = "git add";
                gs     = "git status";
                gc     = "git commit";
                gps    = "git push";
                gpl    = "git pull";
                gb     = "git branch";
                gnb    = "git checkout -b";
                gcb    = "git checkout";
                gbu    = "git remote update origin --prune";
                n      = "nvim";
                ff     = "fastfetch";
                img    = "imv";
                vid    = "mpv";
                aud    = "mpv";
                pdf    = "zathura";
                open   = "xdg-open";
                erwp   = "nvim /tmp/rwptimer";
                ewt    = "nvim /tmp/wtimer";
                ehypr  = "nvim $HOME/.config/hypr/.";
            };

            initExtra = ''
                (cat ~/.cache/wal/sequences &)

                setopt interactive_comments
                stty stop undef

                autoload -Uz add-zsh-hook
                autoload -U colors && colors

                red='%{'$(print -P '\e[38;5;196m')'%}'
                reset='%{'$(print -P '\e[0m')'%}'
                green='%{'$(print -P '\e[1;32m')'%}'
                gray='%{'$(print -P '\e[1;37m')'%}'
                yellow='%{'$(print -P '\e[1;33m')'%}'
                blue='%{'$(print -P '\e[1;34m')'%}'
                black='%{'$(print -P '\e[1;30m')'%}'
                greenl='%{'$(print -P '\e[1;32;5m')'%}'

                gitscript() {
                    psvar[1]=$(gitstat)
                }

                add-zsh-hook precmd gitscript

                PROMPT=$'\n'"%240F$gray ╭─   ( $green($yellow%n$green) $blue| $green($yellow%~$green) $blue| $green($yellow%1v$green)$gray )"$'\n'"%240F$gray ╰─ $reset"

                bindkey -v
                export KEYTIMEOUT=1

                autoload edit-command-line; zle -N edit-command-line
                bindkey '^e' edit-command-line
                bindkey '^t' clear-screen
                bindkey -r '^l'

                bindkey '^?' backward-delete-char # backspace key sequence
                bindkey "^[[P" delete-char # delete key sequence

                bindkey -s '^f' 'lfrun\n'
                bindkey -s '^s' 'lfrun $(fzf)\n'
                bindkey -s '^p' 'youtube-playlists\n' # select a playlist to listen to
                bindkey -s '^o' 'lfcd\n' # go to last dir
            '';

            sessionVariables = {

                FZF_DEFAULT_COMMAND = "rg --files --hidden";

                VISUAL              = "nvim";
                VIDEO               = "mpv";
                IMAGE               = "imv";

                LOCAL_CONFIG_DIR    = "$HOME/.local";
                LOCAL_BIN_DIR       = "$LOCAL_CONFIG_DIR/bin";

                XDG_SCREENSHOTS_DIR = "$HOME/.screenshots";
                XDG_DATA_HOME       = "$HOME/.local/share";
                XDG_DOCUMENTS_DIR   = "$HOME/projects";
                XDG_DOWNLOAD_DIR    = "$HOME/downloads";
                XDG_CONFIG_DIR      = "$HOME/.config";
                XDG_PICTURES_DIR    = "$HOME/imgs";
                XDG_CACHE_DIR       = "$HOME/.cache";
                XDG_VIDEOS_DIR      = "$HOME/vids";

                NSFW_WALLPAPERS     = "$HOME/.local/wallpapers/NSFW_WALLPAPERS";
                SFW_WALLPAPERS      = "$HOME/.local/wallpapers/SFW_WALLPAPERS";

                BROWSER             = "firefox";
                LANGUAGE            = "en_US.UTF-8";
                LC_ALL              = "en_US.UTF-8";
                LANG                = "en_US.UTF-8";
                LC_TYPE             = "en_US.UTF-8";
            };
        };
    };

    home.stateVersion            = "24.05";
    programs.home-manager.enable = true;
}
