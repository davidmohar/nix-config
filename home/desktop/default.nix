{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./firefox.nix
    ./alacritty.nix
    ./vscode.nix
    ./zed-editor.nix
  ];

  home.packages = lib.optionals pkgs.stdenv.isDarwin (
    with pkgs;
    [
      gimp
      rectangle
      stats
    ]
  );
}
