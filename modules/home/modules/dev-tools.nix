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
            pkgs.qmk
            pkgs.scrcpy
            pkgs.stow
        ];

        programs = {
            cargo.enable = true;
            cpio.enable = true;
            evtest.enable = true;
            pico-sdk.enable = true;
            qmk.enable = true;
            scrcpy.enable = true;
            stow.enable = true;
        };
    };
}
