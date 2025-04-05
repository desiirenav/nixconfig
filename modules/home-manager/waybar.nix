{...}: {
  programs.waybar = {
    enable = true;
    style = builtins.readFile ../waybar/style.css;
    settings = [
    ];
  };
}
