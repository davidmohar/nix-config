{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs; [
        vscode-extensions.eamodio.gitlens
        vscode-extensions.editorconfig.editorconfig
        vscode-extensions.golang.go
        vscode-extensions.bbenoist.nix
        vscode-extensions.rust-lang.rust-analyzer
        vscode-extensions.github.copilot
        vscode-extensions.github.copilot-chat
        vscode-extensions.mhutchie.git-graph
      ];

      userSettings = {
        "editor.formatOnSave" = true;
        "github.copilot.editor.enableAutoCompletions" = true;
        "terminal.integrated.fontFamily" = "Fira Code";
      };
    };
  };
}
