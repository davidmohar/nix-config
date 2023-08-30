{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:
{
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = (_: true);

  imports = [
    ./develop.nix
  ];

  # Custom activation script for Darwin so that Home Manager Apps (GUI) are discoverable via Spotlight
  # https://github.com/nix-community/home-manager/issues/1341#issuecomment-1716147796
  disabledModules = [ "targets/darwin/linkapps.nix" ];
  home.activation = lib.mkIf pkgs.stdenv.isDarwin {
    copyApplications =
      let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        toDir="$HOME/Applications/Home Manager Apps"
        fromDir="${apps}/Applications"
        rm -rf "$toDir"
        mkdir -p "$toDir"
        (
          cd "$fromDir"
          for app in *.app; do
            /usr/bin/osacompile -o "$toDir/$app" -e "do shell script \"open '$fromDir/$app'\""
            icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
            if [[ $icon != *".icns" ]]; then
              icon="$icon.icns"
            fi
            mkdir -p "$toDir/$app/Contents/Resources"
            cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"
          done
        )
      '';
  };
}
