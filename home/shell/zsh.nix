{ pkgs
, lib
, inputs
, config
, ...
}:
let
  shellAliases = {
    grep = "grep --color=auto";

    ls = "ls -hF --color=tty";
    ll = "ls -l";
    la = "ls -la";
    cat = "bat";

    # Tools
    k = "kubectl";
    ctx = "kubectx";
    ns = "kubens";
    tf = "terraform";
    tg = "terragrunt";
    ap = "awsprofile";

    # zsh reload
    szsh = "source ~/.zshrc";

    # Nix garbage collection
    garbage = "nix-collect-garbage -d";

    # CyberArk Workaround
    sudo = "sudo --preserve-env=PATH env";
  };
in
{
  programs.zsh = {
    inherit shellAliases;

    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history.extended = true;

    initContent = ''
      export TERM="xterm-256color"
      bindkey -e

      # Add Homebrew packages to PATH
      export PATH=/opt/homebrew/bin:$PATH
    '';
  };
}
