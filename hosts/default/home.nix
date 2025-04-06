{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./../../modules/home-manager/starship/starship.nix
    ./../../modules/home-manager/stylix.nix
    ./../../modules/home-manager/hyprland.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "narayan";
  home.homeDirectory = "/home/narayan";

  home.stateVersion = "24.11"; # Please read the comment before changing.

  programs.git = {
    enable = true;
    userName = "desiirenav";
    userEmail = "desiirenav@hotmail.com";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""

      if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
          exec Hyprland
      end

      starship init fish | source
    '';
  };

  home.packages = [
  ];

  home.file = {
  };

  home.sessionVariables = {
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
