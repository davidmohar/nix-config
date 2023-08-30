{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.kitty = {
    enable = true;
    font = {
      package = pkgs.fira-code;
      name = "Fira Code";
      size = 12;
    };
    shellIntegration.enableZshIntegration = true;
    settings = {
      window_padding_width = "4";
      tab_bar_min_tabs = 0;
      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
    theme = "Catppuccin-Mocha";
  };
}
