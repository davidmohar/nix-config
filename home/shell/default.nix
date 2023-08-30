{ pkgs
, lib
, inputs
, config
, ...
}: {
  imports = [
    ./bat.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./neovim.nix
    ./ssh.nix
    ./starship.nix
    ./zellij.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # Misc
    yq
    jq
    tcptraceroute
    httpie
  ];

  programs.autojump.enable = true;
  programs.tmux.enable = true;
}
