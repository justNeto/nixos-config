{ pkgs-unstable, lib, config, ... }:
{
    options = {
       unstable.enable = lib.mkEnableOption "enables Home-Manager unstable module";
    };

    config = lib.mkIf config.unstable.enable {
        home.packages = [
            # pkgs-unstable.deskflow
            pkgs-unstable.freecad
            pkgs-unstable.imhex
        ];
    };
}
