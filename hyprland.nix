{ config, ... }:
{
  nixpkgs.config.allowUnfree = true;
  services.displayManager.sddm.enable = true;

  # Select display manager as well for login shell
  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
  };

  hardware = {
	  opengl = {
		  enable = true;
		  driSupport = true;
		  driSupport32Bit = true;
	  };

	  nvidia = {
		  modesetting.enable = true;
		  open = true;
		  nvidiaSettings = true;
		  package = config.boot.kernelPackages.nvidiaPackages.stable;
	  };
  };

  programs.hyprland = {
     enable 		= true;
     xwayland.enable 	= true;
  };
}
