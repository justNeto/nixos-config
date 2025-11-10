{ inputs, pkgs, lib, config, ... }:
{
    options = {
        others.enable = lib.mkEnableOption "enables Home-Manager other modules";
    };

    config = lib.mkIf config.others.enable {

        home.packages = [
            pkgs.calc
            pkgs.jq
            pkgs.pv
            pkgs.man-pages
            pkgs.beauty-line-icon-theme
            pkgs.kdePackages.dolphin
            pkgs.grimblast
            pkgs.wlr-randr
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
    };
}
