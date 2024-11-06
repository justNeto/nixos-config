{
    description = "My first NixOS system flake!";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
        unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
        rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";

        home-manager = {
            url			= "github:nix-community/home-manager/release-24.05";
            inputs.nixpkgs.follows 	= "nixpkgs";
        };

        firefox-addons = {
            url 			= "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
            inputs.nixpkgs.follows 	= "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
        system 	= "x86_64-linux";
    in {
        nixosConfigurations.justNeto-nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
            modules = [
                    ./configuration.nix
                    ./hyprland.nix
                    home-manager.nixosModules.home-manager
                    {
                        home-manager.extraSpecialArgs 		= { inherit inputs; };
                        home-manager.backupFileExtension 	= "backup";
                        home-manager.useGlobalPkgs		= true;
                        home-manager.useUserPackages		= true;
                        home-manager.users.neto			= import ./home.nix;
                    }
            ];
        };
    };
}
