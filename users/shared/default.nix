{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  imports = [
    ./fonts.nix
  ];

  nix = {
    enable = true;
    extraOptions =
      lib.optionalString pkgs.stdenv.isDarwin ''
        system = aarch64-darwin
        extra-platforms = aarch64-darwin x86_64-darwin
      ''
      + ''
        experimental-features = nix-command flakes
        build-users-group = nixbld
      '';

    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };

    settings = {
      trusted-substituters = [
        "https://nix-serve.sportradar.ag"
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [
        "davidm"
      ];
    };
  };

  ids.gids.nixbld = 30000;

  environment.shells = with pkgs; [ zsh ];
  environment.systemPackages = with pkgs; [
    gnupg
  ];

  programs.gnupg.agent.enable = true;
}
