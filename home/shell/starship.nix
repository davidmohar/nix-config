{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
