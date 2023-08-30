{ pkgs
, lib
, inputs
, config
, ...
}: {
  fonts = {
    packages = with pkgs; [
      fira
      fira-code
    ];
  };
}
