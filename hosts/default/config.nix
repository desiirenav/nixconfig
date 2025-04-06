{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./nvidia.nix
    ./../../modules/nixos/stylix.nix
    ./../../modules/nixos/nvf.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

  # Networking
  networking.networkmanager.enable = true;

  # Time zone.
  time.timeZone = "America/Toronto";

  # Internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_CA.UTF-8";
    LC_IDENTIFICATION = "en_CA.UTF-8";
    LC_MEASUREMENT = "en_CA.UTF-8";
    LC_MONETARY = "en_CA.UTF-8";
    LC_NAME = "en_CA.UTF-8";
    LC_NUMERIC = "en_CA.UTF-8";
    LC_PAPER = "en_CA.UTF-8";
    LC_TELEPHONE = "en_CA.UTF-8";
    LC_TIME = "en_CA.UTF-8";
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # User
  users.users.narayan = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "Narayan";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKyl/I9MXx08Djz75tGfTf+Jo7RxxfQzmMtUBgfzxFXf narayan@nixos"
    ];
    packages = with pkgs; [];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs;};
    users = {
      "narayan" = import ./home.nix;
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Fish
  programs.fish.enable = true;

  # NTFS
  boot.supportedFilesystems = ["ntfs"];

  # Hyprland
  programs.hyprland.enable = true;

  # Packages
  environment.systemPackages = with pkgs; [
    librewolf
    typst
    zathura
    fastfetch
    nitch
    yazi
    brightnessctl
    inputs.zen-browser.packages."${system}".default
    grim
    slurp
    wl-clipboard
  ];

  # OpenSSH daemon.
  services.openssh.enable = true;
  # Autoclean
  nix = {
    settings.auto-optimise-store = true;
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # System version
  system.stateVersion = "24.11"; # Did you read the comment?
}
