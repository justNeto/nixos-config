{
    description = "Rewrite of my first NixOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        home-manager = {
            url			= "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows 	= "nixpkgs-unstable";
        };

        firefox-addons = {
            url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows 	= "nixpkgs";
        };

        ags = {
            url = "github:Aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        ghostty = {
            url = "github:ghostty-org/ghostty";
        };

        hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
        hyprland-plugins = {
            url = "github:hyprwm/hyprland-plugins";
            inputs.hyprland.follows = "hyprland";
        };

        rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
        neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
        zen-browser.url = "github:MarceColl/zen-browser-flake";
    };

    outputs = inputs@{  nixpkgs, nixpkgs-unstable, home-manager, ghostty, ... }:
    let
        systemSettings = {
            system = "x86_64-linux";
            timezone = "America/Mexico_City";
            locale = "en_US.UTF-8";
            username = "neto";
        };
        pkgs = import nixpkgs {
            system = systemSettings.system;
            config = { allowUnfree = true; };
        };
        pkgs-unstable = import nixpkgs-unstable {
            system = systemSettings.system;
            config = { allowUnfree = true; };
        };
    in
    {
        nixosConfigurations = (import ./hosts {
            inherit (nixpkgs) lib;
            inherit inputs nixpkgs pkgs pkgs-unstable systemSettings home-manager;
        });
    };
}
