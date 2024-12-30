{
  description = "Personal Darwin system flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew}:
  let
    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;
      security.pam.enableSudoTouchIdAuth = true;
      nix.extraOptions = ''
        extra-platforms = x86_64-darwin aarch64-darwin
      '';

      # System packages
      environment.systemPackages = with pkgs; [
        mkalias
        neovim
        git
        tmux
        obsidian
        ripgrep
        tree
        starship
        bat
        nodejs  # Includes npm
        go      # Go language support
        dotnet-sdk_8
        spotify
        rustup
        gradle
        jankyborders 
        yabai
        skhd
        jq
        lua54Packages.lua
        sketchybar
        vlc-bin-universal
        jetbrains.idea-ultimate
        jetbrains.rider
        jetbrains.clion
        discord
        teams
        yazi
        web-ext
        audacity
        postgresql
        docker-compose
        protonmail-desktop
	stow
	texliveFull
	zathura
        ];


      homebrew = {
        enable = true;
        brews = [ "mas" "lua-language-server" "gopls" "dbus" "fzf" "pyright"];
        casks = [ "zen-browser" "fork" "raycast" "wireshark" "keymapp" "qbittorrent" "mathpix-snipping-tool" "obs" "bfxr" "krita" "blender" "unity-hub" "steam" "docker" "pgadmin4" "ghostty"];
        onActivation.cleanup = "zap";
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = ["JetBrainsMono" "Hack" ]; })
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
        dock.orientation = "right";
        finder.AppleShowAllExtensions = true;
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        loginwindow.LoginwindowText = "Personal";
        screencapture.location = "~/Pictures/screenshots";
        screensaver.askForPasswordDelay = 10;
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
        trackpad.Clicking = true;
      };

      services.jankyborders = {
        enable = true;
        package = pkgs.jankyborders;
        width = 5.0;
        active_color = "gradient(top_left=0xffDDB6F2,bottom_right=0xff96CDFB)";
        inactive_color = "gradient(top_right=0x9992B3F5,bottom_left=0x9992B3F5)";
        hidpi = true;
        ax_focus = true;
      };
      services.skhd = {
        enable = true;
        package = pkgs.skhd;
      };
      services.sketchybar = {
        enable = true;
        package = pkgs.sketchybar;
        extraPackages = [
          pkgs.jq
        ];
      };
      services.yabai = {
        enable = true;
        enableScriptingAddition = true;
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
