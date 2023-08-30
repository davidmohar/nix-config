{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
