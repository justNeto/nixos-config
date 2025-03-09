{ pkgs, pkgs-unstable, lib, config, systemSettings, ... }:
{
    imports = [
        ./bluetooth.nix
    ];
    bluetooth.enable = lib.mkDefault false;
}
