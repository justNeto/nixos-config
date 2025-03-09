{ pkgs, lib, config, ... }:
{
    options = {
        additions.enable = lib.mkEnableOption "enables Home-Manager additional packages module";
    };

    config = lib.mkIf config.additions.enable {

        home.packages = [
            pkgs.file
            pkgs.zip
            pkgs.gimp
            pkgs.unzip
            pkgs.zathura
            pkgs.v4l-utils
            pkgs.libreoffice
        ];
    };
}
