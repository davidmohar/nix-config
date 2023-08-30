{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  programs.zellij = {
    enable = false;
    enableZshIntegration = true;
    #attachExistingSession = true;
    settings = {
      pane_frames = false;
      default_layout = "compact";
      show_startup_tips = false;
      show_release_notes = false;
      theme = "catppuccin-latte";
      welcome_screen = true;
    };
  };
}
