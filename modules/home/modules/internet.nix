{ pkgs, lib, config, ... }:
{
    options = {
        internet.enable = lib.mkEnableOption "enables Home-Manager internet module";
    };

    config = lib.mkIf config.internet.enable {

        home.packages = [
            pkgs.speedtest-cli
            pkgs.tor-browser
            pkgs.qbittorrent-enhanced
        ];
    };
}
