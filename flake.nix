{
    description = "My first NixOS system flake!";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
        rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

        home-manager = {
            url			= "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows 	= "nixpkgs";
        };

        firefox-addons = {
            url 			= "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows 	= "nixpkgs";
        };

        ags = {
            url = "github:Aylur/ags";
            inputs.nixpkgs.follows = "nixpkgs-unstable";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            system 	= "x86_64-linux";
            unstable = import inputs.nixpkgs-unstable {inherit system;};
        in
        {
            nixosConfigurations.justNeto-nixos = nixpkgs.lib.nixosSystem
            {
                specialArgs = { inherit inputs; };
                modules = [
                        ./configuration.nix
                        ./hyprland.nix
                        home-manager.nixosModules.home-manager
                        {
                            home-manager.extraSpecialArgs 		= { inherit inputs; inherit unstable; };
                            home-manager.useGlobalPkgs		    = true;
                            home-manager.useUserPackages		= true;
                            home-manager.users.neto			    = import ./home.nix;
                        }
                ];
            };
    };
}
