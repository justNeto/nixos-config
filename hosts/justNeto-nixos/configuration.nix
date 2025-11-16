{ inputs, pkgs, systemSettings, config, ... }:
{
    imports = [ ../../modules/core ];
    bluetooth.enable = false;

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

            BROWSER             = "zen";
            LANGUAGE            = "en_US.UTF-8";
            LC_ALL              = "en_US.UTF-8";
            LANG                = "en_US.UTF-8";
            LC_TYPE             = "en_US.UTF-8";
        };

        programs = {
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
                enable = true;
                enableCompletion = false;
                autosuggestion.enable = true;

                autocd = true;

                history = {
                    path = "$ZDOTDIR/history";
                    save = 2000;
                };

                dotDir = ".config/shell";

                shellAliases = {
                    cs     = "sudo chmod +x";
                    sn     = "sudoedit";
                    rmd    = "sudo rm -rf";
                    srwpt  = "sudo cat /tmp/rwptimer";
                    awp    = "sudo chmod a+w";
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
                };

                initContent = ''
                    (cat ~/.cache/wal/sequences &)

                    function y() {
                        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
                        yazi "$@" --cwd-file="$tmp"
                        if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
                            builtin cd -- "$cwd"
                        fi
                            rm -f -- "$tmp"
                    }

                    # Change Yazi's CWD to PWD on subshell exit
                    if [[ -n "$YAZI_ID" ]]; then
                        function _yazi_cd() {
                            ya emit cd "$PWD"
                        }
                        add-zsh-hook zshexit _yazi_cd
                    fi

                    # INFO: Zsh overrides for terminal shortcuts
                    autoload edit-command-line; zle -N edit-command-line
                    bindkey '^e' edit-command-line
                    bindkey '^t' clear-screen
                    bindkey -r '^l'

                    bindkey '^?' backward-delete-char # backspace key sequence
                    bindkey "^[[P" delete-char # delete key sequence

                    # bindkey -s '^f' 'tmux-sessionizer\n' # tmux sessionizer
                    # bindkey -s '^y' 'fmrun\n' # run fmrun
                    '';
            };

            starship = {
                enable = true;
                settings = {
                    format = ''
                        ╭─   \( \[$username\] | \[$directory\]$git_branch \)
                        $character
                        '';
                    add_newline = true;

                    directory = {
                        style = "bold yellow";
                        read_only = " 󰌾";
                        format = "[$path]($style)";
                        truncate_to_repo = false;
                        truncation_length = 0;
                    };

                    username = {
                        style_user = "violet";
                        format = "($user)";
                        show_always = true;
                    };

                    character = {
                        success_symbol = "[╰─](bold green)";
                        error_symbol = "[╰─](bold red)";
                    };

                    git_branch = {
                        symbol = " ";
                        style = "white";
                        format = " | \\[[$symbol$branch]($style)\\]";
                    };

                    git_status = {
                        style = "red";
                        format = "([$all_status]($style)) ";
                    };

                    git_state = {
                        style = "blue";
                        format = "( $state( $progress_current/$progress_total)) ";
                    };

                    git_commit = {
                        tag_symbol = "  ";
                    };

                    aws.symbol = "  ";
                    buf.symbol = " ";
                    bun.symbol = " ";
                    c.symbol = " ";
                    cpp.symbol = " ";
                    cmake.symbol = " ";
                    conda.symbol = " ";
                    crystal.symbol = " ";
                    dart.symbol = " ";
                    deno.symbol = " ";
                    docker_context.symbol = " ";
                    elixir.symbol = " ";
                    elm.symbol = " ";
                    fennel.symbol = " ";
                    fossil_branch.symbol = " ";
                    gcloud.symbol = "  ";
                    golang.symbol = " ";
                    guix_shell.symbol = " ";
                    haskell.symbol = " ";
                    haxe.symbol = " ";
                    hg_branch.symbol = " ";
                    java.symbol = " ";
                    julia.symbol = " ";
                    kotlin.symbol = " ";
                    lua.symbol = " ";
                    memory_usage.symbol = "󰍛 ";
                    meson.symbol = "󰔷 ";
                    nim.symbol = "󰆥 ";
                    nix_shell.symbol = " ";
                    nodejs.symbol = " ";
                    ocaml.symbol = " ";
                    package.symbol = "󰏗 ";
                    perl.symbol = " ";
                    php.symbol = " ";
                    pijul_channel.symbol = " ";
                    pixi.symbol = "󰏗 ";
                    python.symbol = " ";
                    rlang.symbol = "󰟔 ";
                    ruby.symbol = " ";
                    rust.symbol = "󱘗 ";
                    scala.symbol = " ";
                    swift.symbol = " ";
                    zig.symbol = " ";
                    gradle.symbol = " ";

                    os.symbols = {
                        Alpaquita = " ";
                        Alpine = " ";
                        AlmaLinux = " ";
                        Amazon = " ";
                        Android = " ";
                        Arch = " ";
                        Artix = " ";
                        CachyOS = " ";
                        CentOS = " ";
                        Debian = " ";
                        DragonFly = " ";
                        Emscripten = " ";
                        EndeavourOS = " ";
                        Fedora = " ";
                        FreeBSD = " ";
                        Garuda = "󰛓 ";
                        Gentoo = " ";
                        HardenedBSD = "󰞌 ";
                        Illumos = "󰈸 ";
                        Kali = " ";
                        Linux = " ";
                        Mabox = " ";
                        Macos = " ";
                        Manjaro = " ";
                        Mariner = " ";
                        MidnightBSD = " ";
                        Mint = " ";
                        NetBSD = " ";
                        NixOS = " ";
                        Nobara = " ";
                        OpenBSD = "󰈺 ";
                        openSUSE = " ";
                        OracleLinux = "󰌷 ";
                        Pop = " ";
                        Raspbian = " ";
                        Redhat = " ";
                        RedHatEnterprise = " ";
                        RockyLinux = " ";
                        Redox = "󰀘 ";
                        Solus = "󰠳 ";
                        SUSE = " ";
                        Ubuntu = " ";
                        Unknown = " ";
                        Void = " ";
                        Windows = "󰍲 ";
                    };
                };
            };
        };
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
        graphics.enable = true;

        nvidia = {
            modesetting.enable = true;
            open = true;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.beta;
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
        openssl
        libvdpau
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
        glib
        inputs.ghostty.packages.${pkgs.system}.default
        inputs.zen-browser.packages.${pkgs.system}.default
    ];
}
