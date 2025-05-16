# Different host profiles when building NixOS
{ inputs, pkgs, pkgs-unstable, systemSettings, home-manager, ... }:
let
  lib = inputs.nixpkgs.lib;
  darwin = inputs.darwin.lib;
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
      ./justNeto-nixos/hardware-configuration.nix
    ];
  };

  neto-work = darwin.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs pkgs systemSettings; };
    modules = [
      home-manager.nixosModules.home-manager
      ./macos-nix/configuration.nix
      ./macos-nix/hardware-configuration.nix
    ];
  };
}
