{ pkgs, lib, config, ... }:
{
    options = {
        others.enable = lib.mkEnableOption "enables Home-Manager other modules";
    };

    config = lib.mkIf config.others.enable {

        home.packages = [
            pkgs.calc
            pkgs.jq
            pkgs.pv
        ];
    };
}
