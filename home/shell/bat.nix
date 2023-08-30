{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.bat = {
    enable = true;
    config = { theme = "Nord"; };
  };
}
