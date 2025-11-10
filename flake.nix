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

        ags = {
            url = "github:Aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        ghostty = {
            url = "github:ghostty-org/ghostty";
        };

        mango = {
            url = "github:DreamMaoMao/mangowc";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        zen-browser = {
            url = "github:0xc000022070/zen-browser-flake";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };

        neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
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
