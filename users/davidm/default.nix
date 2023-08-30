{
  pkgs,
  lib,
  inputs,
  config,
  system,
  ...
}:
{
  home.stateVersion = "25.05";
  home.username = "davidm";
  home.homeDirectory = "/Users/davidm";

  accounts.email.accounts.primary = {
    address = "david.mohar@shekaj.si";
    primary = true;
    realName = "David Mohar";
  };
}
