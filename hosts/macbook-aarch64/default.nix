{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  security.pam.services.sudo_local.touchIdAuth = true;
  system.stateVersion = 6;
  system.primaryUser = "davidm";
}
