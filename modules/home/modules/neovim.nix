{ inputs, pkgs, lib, config, ... }: {
    options.neovim.enable =
        lib.mkEnableOption "enables Home-Manager NeoVim module";

    config = lib.mkIf config.neovim.enable {
        programs = {
            neovim = {
                enable = true;
                package = pkgs.neovim;
            };
        };

        home.packages = with pkgs; [
            go
            nixd
            bear
            marksman
            cppcheck
            tree-sitter
            nixfmt-classic
        ];
    };
}
