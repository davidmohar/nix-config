{ pkgs
, lib
, inputs
, config
, ...
}: {
  programs.ssh = {
    enable = true;
    controlPath = "none";
    extraConfig = ''
    '';
  };
}
