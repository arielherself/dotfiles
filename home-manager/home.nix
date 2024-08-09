# vim: set expandtab tabstop=2 softtabstop=2 shiftwidth=2:

{ config, pkgs, ... }:

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
in {
  nixpkgs.config.allowUnfree = true;
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "user";
  home.homeDirectory = "/home/user";
  xdg.enable = true;

  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".profile" = {
      source = ../.profile;
    };
    ".gitconfig" = {
      text = ''
        [user]
          email = arielherself@duck.com
          name = arielherself
        [gpg "ssh"]
          program = ${pkgs._1password-gui}/bin/op-ssh-sign
      '';
    };
  };

  xdg.configFile = {
    "tmux/plugins/tpm" = {
      source = builtins.fetchGit {
        url = "https://github.com/tmux-plugins/tpm.git";
        ref = "master";
      };
      recursive = true;
    };
    "contour/contour.yml" = {
      source = ../contour.yml;
      recursive = true;
    };
    "awesome/rc.lua" = {
      source = ../awesome.rc.lua;
      recursive = true;
    };
    "lf" = {
      source = ../lf;
      recursive = true;
    };
    "xournalpp" = {
      source = ../xournalpp;
      recursive = true;
    };
    "nvim" = {
      source = ../nvim;
      recursive = true;
    };
    "p10k/p10k.zsh" = {
      source = ../p10k.zsh;
      recursive = true;
    };
  };

  xdg.desktopEntries = {
    # Don't forget to change its permissions.
    cider = {
      name = "Cider";
      comment = "Apple Music Player";
      type = "Application";
      exec = "${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/Dropbox/arch/cider/Cider-linux-appimage-x64.AppImage";
      terminal = false;
      categories = [ "AudioVideo" "Audio" ];
    };
    thorium = {
      name = "Thorium";
      comment = "Access the Internet";
      type = "Application";
      exec = "${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/Dropbox/arch/thorium/Thorium.AppImage";
      terminal = false;
    };
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Terminal
    # pkgs.contour
    # pkgs.tmux
    pkgs.kitty
    pkgs.alacritty

    # Networking
    pkgs.wireshark
    # pkgs.clash-verge-rev

    # Editor
    unstable.neovim
    pkgs.fzf
    pkgs.ripgrep
    pkgs.clang-tools
    pkgs.lua-language-server
    pkgs.cmake-language-server
    pkgs.nil  # Nix language server
    pkgs.nodePackages.typescript-language-server
    pkgs.nodePackages.vls  # Vue language server
    pkgs.nodePackages.prettier
    unstable.markdown-oxide
    pkgs.helix
    pkgs.zed-editor

    # Tools
    pkgs.zip
    pkgs.unzip
    pkgs.pkg-config
    pkgs.appimage-run
    pkgs.gnumake
    pkgs.go
    pkgs.gcc
    pkgs.autoconf
    pkgs.automake
    pkgs.btop
    pkgs.fx
    pkgs.mtr
    pkgs.htop
    pkgs.gdb
    pkgs.dropbox
    pkgs.brightnessctl
    pkgs.psmisc
    pkgs.xclip  # Clipboard support
    pkgs.vulkan-tools
    pkgs.lshw
    unstable._1password
    unstable._1password-gui
    pkgs.nix-index

    # Pwn
    pkgs.nmap
    pkgs.inetutils
    pkgs.samba

    # Python
    (pkgs.python312.withPackages (ps: with ps; [
    ]))
    pkgs.pyright
    # pkgs.pipx

    # Node
    pkgs.nodejs_22

    # Waybar
    # pkgs.waybar
    # pkgs.waybar-mpris

    # Desktop management
    pkgs.xfce.thunar
    pkgs.baobab
    pkgs.i3lock
    pkgs.flameshot

    # Note & Documents
    pkgs.obsidian
    pkgs.xournalpp
    pkgs.sioyek

    # Multimedia
    pkgs.kdePackages.gwenview
    pkgs.vlc
    pkgs.playerctl
    pkgs.ffmpeg
    pkgs.spotify
    unstable.spotify-player

    # Streaming
    pkgs.obs-studio

    # Communication
    pkgs.telegram-desktop
    pkgs.discord

    # Misc
    pkgs.fastfetch
    pkgs.onefetch
    pkgs.lf                                    # Terminal file manager
    # pkgs.smassh                                # Typing test
    pkgs.you-get                               # YouTube video downloader
    pkgs.asciinema                             # Record terminal sessions
    pkgs.ulauncher                             # application launcher
    pkgs.networkmanagerapplet                  # Network manager tray icon
    pkgs.cbatticon                             # Battery tray icon
    pkgs.pavucontrol                           # Volume control
      pkgs.pasystray                           # Volume tray icon
    pkgs.yaru-theme
    unstable.adwaita-icon-theme
    pkgs.adwaita-qt
    pkgs.adwaita-qt6
    pkgs.firefox-devedition
    pkgs.wiki-tui

    # My version of BerkeleyMono NF is incomplete. Should add some fallback fonts.
    (pkgs.nerdfonts.override { fonts = [
      "JetBrainsMono"
      "FiraCode"
    ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.file = {
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/user/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.zsh = {
    enable = true;
    # dotDir = "${config.home.homeDirectory}/.config/zsh";
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      upgrade = "nix-channel --update && sudo nixos-rebuild switch && home-manager switch";
      commit = "git commit -S -m";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "tmux"
      ];
    };
    # plugins = [
    #   {
    #     name = "p10k-config";
    #     src = "${config.xdg.configHome}/p10k";
    #     file = "p10k.zsh";
    #   }
    # ];
    initExtraFirst = ''
      ZSH_TMUX_AUTOSTART=true
      ZSH_TMUX_AUTOCONNECT=false
    '';
    initExtra = ''
      me() { mkdir -p "$1" && cd "$1" }
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      source ${pkgs.nix-index}/etc/profile.d/command-not-found.sh
      source ${config.xdg.configHome}/p10k/p10k.zsh
    '';
  };

  programs.git = {
    enable = true;
    userName = "arielherself";
    userEmail = "arielherself@duck.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      # This may not apply. Also try `git config --global gpg.ssh.program "/home/user/.nix-profile/bin/op-ssh-sign"`
      gpg."ssh".program = "${unstable._1password-gui}/bin/op-ssh-sign";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    terminal = "tmux-256color";
    shell = "${pkgs.zsh}/bin/zsh";
    extraConfig = ''
      # Fix font variants and undercurl but optional.
      # set -ga terminal-overrides ",xterm-256color:Tc"
      # set-option -sa terminal-features ',xterm-256color:RGB'
      # set-option -g default-terminal "tmux-256color"
      # set-option -ga terminal-features ",xterm-256color:usstyle"
      # set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
      # set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      set-option -g default-shell "${pkgs.zsh}/bin/zsh"
      set -g default-command "${pkgs.zsh}/bin/zsh"
      setw -g mode-keys vi
      set-option -g status-position top
      set -sg escape-time 0
      set -g @plugin 'tmux-plugins/tpm'
      # This plugin seems to break terminfo when default shell of a terminal emulator is set to zsh.
      # set -g @plugin 'tmux-plugins/tmux-sensible'
      set -g @plugin 'erikw/tmux-powerline'
      run '${config.xdg.configHome}/tmux/plugins/tpm/tpm'
    '';
  };

  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;
    extraConfig = ''
      local config = wezterm.config_builder()

      config.default_prog = {"${pkgs.zsh}/bin/zsh"}
      config.font = wezterm.font_with_fallback {
        "BerkeleyMono Nerd Font",
        "JetBrainsMono Nerd Font",
      }
      -- https://wezfurlong.org/wezterm/config/lua/config/term.html
      config.term = "wezterm"

      return config
    '';
  };

  programs.nushell = {
    enable = true;
  };

  services.mpris-proxy.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}

