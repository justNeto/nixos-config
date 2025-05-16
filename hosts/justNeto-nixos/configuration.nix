{ inputs, pkgs, pkgs-unstable, systemSettings, config, ... }:
# This file should be to both enable common configuration coming from MODULES and add any extra,
# additional, specific configuration for the current host. This includes package/flake/system/home-manager
# configuration as well.
{

    programs = {
        zsh.enable = true;
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users = {
        defaultUserShell = pkgs.zsh;
        users.${systemSettings.username} = {
            isNormalUser = true;
            description = "Ernesto L";
            extraGroups = [ "networkmanager" "wheel" "video" "input" ];
        };
    };

    home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        extraSpecialArgs = { inherit inputs; inherit systemSettings; inherit pkgs; inherit pkgs-unstable; };
        # users.${systemSettings.username} = (import ../../modules/home); # importing the file from modules/home
        users.${systemSettings.username} = { # activating/deactivating modules

            import = [ ../../modules/home  ]
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

            home.sessionVariables = {
                FZF_DEFAULT_COMMAND = "rg --files --hidden";
                VISUAL              = "nvim";
                EDITOR              = "nvim";
                VIDEO               = "mpv";
                IMAGE               = "imv";

                NSFW_WALLPAPERS     = "$HOME/.local/wallpapers/NSFW_WALLPAPERS";
                SFW_WALLPAPERS      = "$HOME/.local/wallpapers/SFW_WALLPAPERS";

                BROWSER             = "firefox";
                LANGUAGE            = "en_US.UTF-8";
                LC_ALL              = "en_US.UTF-8";
                LANG                = "en_US.UTF-8";
                LC_TYPE             = "en_US.UTF-8";
            };

            programs = {
                firefox = {
                    enable = true;

                    profiles.justNeto = {
                        id = 0;
                        isDefault = true;
                        name = "justNeto";

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
                        id = 1;
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

                git = {
                    enable = true;
                    userName = "justNeto";
                    userEmail = "continental.lelgg.2b@gmail.com";
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

                        function y() {
                            local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
                                yazi "$@" --cwd-file="$tmp"
                                if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                                    builtin cd -- "$cwd"
                                        fi
                                        rm -f -- "$tmp"
                        }

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

                                                                                        bindkey -s '^p' 'youtube-playlists\n' # select a playlist to listen to
                                                                                        bindkey -s '^f' 'fmrun\n' # run fmrun
                                                                                        '';
                };
            };
        };
    };

    # imports = [ ../../modules/core ];
    # bluetooth.enable = true;

    services = {
        displayManager.sddm.enable = true;
        xserver = {
            enable = true;
            videoDrivers = [ "nvidia" ];
        };
    };

    # Select display manager as well for login shell
    hardware = {

        # Enable OpenGL for host
        graphics = {
            enable = true;
        };

        # Select graphics drivers for host
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

        # Enable resetting ZSA keyboards
        keyboard = {
            zsa.enable = true;
            qmk.enable = true;
        };
    };
}
