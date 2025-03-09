{ pkgs, lib, config, ... }:
{
    options = {
        latex.enable = lib.mkEnableOption "enables Home-Manager Latex module";
    };

    config = lib.mkIf config.latex.enable {

        home.packages = [
            pkgs.pandoc
                pkgs.texliveFull
                pkgs.biber
                pkgs.lyx
                pkgs.pdflatex
                pkgs.xelatex
        ];

        programs.texlive = {
            enable = true;
        };
    };
}
