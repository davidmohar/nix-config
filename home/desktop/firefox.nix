{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  programs.firefox = {
    enable = true;

    profiles.default = {
      id = 0;
      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          vimium
          proton-pass
        ];
      };
    };
  };
}
