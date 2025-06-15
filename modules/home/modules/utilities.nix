{ pkgs, lib, config, ... }:
{
    options = {
        utilities.enable = lib.mkEnableOption "enables Home-Manager utilities module";
    };

    config = lib.mkIf config.utilities.enable {

        home.packages = [
            pkgs.jq
            pkgs.pv
            pkgs.calc
            pkgs.starship
            pkgs.zsh-fast-syntax-highlighting
            pkgs.zsh-autosuggestions
            pkgs.zsh-autocomplete
        ];
    };
}
