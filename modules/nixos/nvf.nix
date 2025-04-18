{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nvf.nixosModules.default];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        statusline.lualine.theme = lib.mkForce "auto";
        theme = lib.mkForce {
          enable = true;
          name = "rose-pine";
          style = "main";
        };
        statusline.lualine.enable = true;
        telescope.enable = true;
        autocomplete.nvim-cmp.enable = true;
        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;
          nix.enable = true;
          typst = {
            enable = true;
            extensions.typst-preview-nvim.enable = true;
          };
        };
      };
    };
  };
}
