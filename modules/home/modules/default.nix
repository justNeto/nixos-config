{ inputs, pkgs-unstable, pkgs, lib, ... }:
{
    imports = [
        ./ai.nix
        ./cad.nix
        ./latex.nix
        ./comms.nix
        ./others.nix
        ./neovim.nix
        ./gaming.nix
        ./android.nix
        ./hyprland.nix
        ./internet.nix
        ./unstable.nix
        ./dev-tools.nix
        ./additions.nix
        ./utilities.nix
    ];

    ai.enable = lib.mkDefault false;
    cad.enable = lib.mkDefault false;
    latex.enable = lib.mkDefault false;
    comms.enable = lib.mkDefault false;
    neovim.enable = lib.mkDefault false;
    others.enable = lib.mkDefault false;
    gaming.enable = lib.mkDefault false;
    android.enable = lib.mkDefault false;
    unstable.enable = lib.mkDefault false;
    internet.enable = lib.mkDefault false;
    additions.enable = lib.mkDefault false;
    utilities.enable = lib.mkDefault false;
    dev-tools.enable = lib.mkDefault false;
    hyprlandwm.enable = lib.mkDefault false;
}
