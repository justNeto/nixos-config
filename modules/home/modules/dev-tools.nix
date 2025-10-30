{ pkgs, lib, config, ... }:
{
    options = {
        dev-tools.enable = lib.mkEnableOption "enables Home-Manager dev tools module";
    };

    config = lib.mkIf config.dev-tools.enable {

        home.packages = [
            pkgs.cargo
            pkgs.cpio
            pkgs.evtest
            pkgs.pico-sdk
            pkgs.arduino-cli
            pkgs.arduino-ide
            pkgs.picocom
            pkgs.qmk
            pkgs.scrcpy
            pkgs.stow
            pkgs.uv
        ];
    };
}
