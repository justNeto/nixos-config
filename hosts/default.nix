# Different host profiles when building NixOS
{ inputs, pkgs, pkgs-unstable, systemSettings, home-manager, ... }:
let
  lib = inputs.nixpkgs.lib;
  system = systemSettings.system;
in
{
  justNeto-nixos = lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs pkgs-unstable systemSettings; };
    modules = [
      home-manager.nixosModules.home-manager
      ./systems-default-conf.nix
      ./justNeto-nixos/configuration.nix
      ./neto-macos/configuration.nix
    ];
  };

  # other-hostname = lib.nixosSystem {
  #   inherit system;
  #   specialArgs = { inherit inputs pkgs systemSettings; };
  #   modules = [
  #     nixos-hardware.nixosModules.lenovo-thinkpad-x1-9th-gen
  #     home-manager.nixosModules.home-manager
  #     ./configuration.nix
  #     ./x1c/hardware-configuration.nix
  #     ./x1c/configuration.nix
  #   ];
  # };
}
