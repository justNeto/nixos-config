{ pkgs, lib, config, ... }:
{
    options = {
        android.enable = lib.mkEnableOption "enables Home-Manager Android dev module";
    };

    config = lib.mkIf config.android.enable {
        home.packages = [
            pkgs.android-studio
            pkgs.android-studio-tools
            pkgs.android-tools
            pkgs.flutter
            pkgs.odin
        ];
    };
}
