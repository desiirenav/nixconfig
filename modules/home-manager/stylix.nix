{
  pkgs,
  lib,
  ...
}: {
  stylix = {
    targets.hyprland.enable = false;
    targets.starship.enable = false;
    autoEnable = true;
    enable = true;
  };
}

