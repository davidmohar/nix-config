{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.neovim = {
    enable = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
