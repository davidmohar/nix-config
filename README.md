# Nix System and Home Configuration

My personal Nix configuration for Apple Silicon devices with `nix-darwin` and `home-manager` for managing dotfiles and tooling.

## Installation

Nix should be the only needed dependency for this repository. You can install it by using the official multi-user installation script:

```bash
sh <(curl -L https://nixos.org/nix/install)
```

You can also consult with the [installation manual](https://nixos.org/manual/nix/stable/installation/installing-binary#macos-installation) on details what the script does or how to install the binaries manually. Verify your installation afterwards by running `nix --version`. If everything looks good:

- Clone this repository to your local machine
  ```bash
  git clone git@gitlab.sportradar.ag:d.mohar/nix-config
  cd nix-config
  ```
- Start your development shell (only needed for first run)
  ```bash
  nix develop --extra-experimental-features nix-command --extra-experimental-features flakes
  ```
- Build the system configuration and apply both system & home
  ```bash
  nix build .#darwinConfigurations.macbook-aarch64.system
  ./result/sw/bin/darwin-rebuild switch --flake .#macbook-aarch64
  home-manager switch --flake .
  ```
- **Enjoy!**

## Switching

After first run, you can apply changes directly through your terminal since Nix already configured and bootstrapped your environment.

- Apply changes to your home configuration with

  ```bash
  home-manager switch --flake .
  ```

- Apply changes to your system configuration with
  ```bash
  darwin-rebuild switch --flake .#macbook-aarch64
  ```
  _**Note:** switching system configuration will require administrative privileges on your machine._
