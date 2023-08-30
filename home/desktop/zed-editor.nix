{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "rust"
      "terraform"
      "toml"
    ];
    extraPackages = with pkgs; [
      # Nix
      nixpkgs-fmt
      nixd
      # Rust
      rust-analyzer
      # Terraform
      terraform-lsp
    ];
    userSettings = {
      buffer_font_size = 12;
      features = {
        copilot = true;
      };
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = true;
    };
  };
}
