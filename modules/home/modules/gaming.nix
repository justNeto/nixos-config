{ pkgs, lib, config, ... }:
{
    options = {
        gaming.enable = lib.mkEnableOption "enables Home-Manager gaming module";
    };

    config = lib.mkIf config.gaming.enable {

        home.packages = [
            pkgs.gamescope
            pkgs.gamemode
            pkgs.mangohud
            pkgs.steam
        ];

        programs.steam = {
            enable = true;
            remotePlay.openFirewall = true;
            dedicatedServer.openFirewall = true;
            package = pkgs.steam.override {
                extraPkgs = pkgs: with pkgs; [
                    libkrb5
                    keyutils
                ];
            };
        };
    };
}
