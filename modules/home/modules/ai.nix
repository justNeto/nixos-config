{ pkgs, lib, config, ... }:
{
    options = {
        ai.enable = lib.mkEnableOption "enables Home-Manager ai module";
    };

    config = lib.mkIf config.ai.enable {
        home.packages = [
            pkgs.llama-cpp
        ];
    };
}
