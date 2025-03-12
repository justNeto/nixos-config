{ pkgs, lib, config, ... }:
{
    options = {
        cad.enable = lib.mkEnableOption "enables Home-Manager cad module";
    };

    config = lib.mkIf config.cad.enable {

        home.packages = [
            pkgs.openscad-unstable
            pkgs.prusa-slicer
            pkgs.blender
        ];
    };
}
