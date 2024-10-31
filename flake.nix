{
  description = "Personal Darwin system flake";

  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      security.pam.enableSudoTouchIdAuth = true;
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      # System packages
      environment.systemPackages = [
        pkgs.mkalias
        pkgs.neovim
        pkgs.git
        pkgs.tmux
        pkgs.alacritty
        pkgs.obsidian
      ];

      homebrew = {
        enable = true;
        brews = [ "mas" ];
        casks = [ "zen-browser" "fork" "raycast" "wireshark" ];
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = ["JetBrainsMono"]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
          echo "setting up /Applications..." >&2
          rm -rf /Applications/Nix\ Apps
          mkdir -p /Applications/Nix\ Apps
          find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
          while read src; do
            app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
          done
        '';

      system.defaults = {
        dock.autohide = true;
        dock.persistent-apps = [
          "${pkgs.alacritty}/Applications/Alacritty.app"
          "/Applications/Zen Browser.app"
          "${pkgs.obsidian}/Applications/Obsidian.app"
          "/System/Applications/Mail.app"
          "/System/Applications/Calendar.app"
        ];
        dock.mru-spaces = false;
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        loginwindow.LoginwindowText = "Personal";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        NSGlobalDomain._HIHideMenuBar = true;
        trackpad.Clicking = true;
      };

      services.nix-daemon.enable = true;
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    darwinConfigurations."personal" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            enable = true;
            enableRosetta = true;
            user = "joachimhorshauge";
          };
        }
      ];
    };

    darwinPackages = self.darwinConfigurations."personal".pkgs;
  };
}
