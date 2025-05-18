{ pkgs, lib, config, ... }:
{
    options = {
        comms.enable = lib.mkEnableOption "enables Home-Manager communication's module";
    };

    config = lib.mkIf config.comms.enable {

        home.packages = [
            pkgs.zoom
            pkgs.slack
            pkgs.vesktop
            pkgs.webcord-vencord
            pkgs.telegram-desktop
        ];
    };
}
