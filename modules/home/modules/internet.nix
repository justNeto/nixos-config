{ pkgs, lib, config, ... }:
{
    options = {
        internet.enable = lib.mkEnableOption "enables Home-Manager internet module";
    };

    config = lib.mkIf config.internet.enable {

        home.packages = [
            pkgs.firefox
            # pkgs.qbittorrent
            pkgs.speedtest-cli
            pkgs.tor-browser
        ];
    };
}
