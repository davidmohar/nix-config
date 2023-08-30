{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.git = {
    enable = true;
    aliases = {
      co = "checkout";
      cob = "checkout -b";
      cm = "commit -m";
      ca = "commit --amend";
      pr = "pull --rebase";
    };

    ignores = [
      ".DS_Store"
      ".vscode"
    ];

    delta = {
      enable = true;
      options = {
        line-numbers = true;
      };
    };

    extraConfig = {
      branch.sort = "-committerdate";
      column.ui = "auto";
      commit.verbose = true;

      core = {
        editor = "vim";
        whitespace = "trailing-space";
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      fetch = {
        prune = true;
        pruneTags = true;
        all = true;
      };

      help.autocorrect = "prompt";
      init.defaultBranch = "main";

      pull = {
        ff = "only";
        rebase = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
        followTags = true;
      };

      rerere = {
        enabled = true;
        autoupdate = true;
      };

      tag.sort = "version:refname";
    };
  } // (
    with config.accounts.email.accounts.primary; {
      userEmail = address;
      userName = realName;
    }
  );
}
