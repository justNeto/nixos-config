{
    description = "Rewrite of my first NixOS system flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
        nixpkgs-darwin.url = "github:LnL7/nix-darwin/master";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        darwin = {
            url = "github:lnl7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs-darwin";
        };

        home-manager = {
            url			= "github:nix-community/home-manager/release-25.05";
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

        yt-x = {
            url = "github:Benexl/yt-x";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
        neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
        zen-browser.url = "github:MarceColl/zen-browser-flake";
    };

    # TODO: complete adding macos config
    outputs = inputs@{ nixpkgs, nixpkgs-unstable, nixpkgs-darwin, home-manager, ... }:
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
        pkgs-darwin = import nixpkgs-darwin {
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
