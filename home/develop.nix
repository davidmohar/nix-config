{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.go.enable = true;

  home.packages = with pkgs; [
    # Tools
    devenv
    # Rust
    cargo
    rustc
    rustfmt
    rust-analyzer
    # Node
    nodejs
    yarn
    # Nix
    nixfmt
  ];
}
