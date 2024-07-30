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

  targets.genericLinux.enable = true;
  xdg.mime.enable = true;

  xdg.desktopEntries = {
    # Don't forget to change its permissions.
    cider = {
      name = "Cider";
      genericName = "Apple Music Player";
      type = "Application";
      exec = "${pkgs.appimage-run}/bin/appimage-run ${config.home.homeDirectory}/Dropbox/arch/cider/Cider-linux-appimage-x64.AppImage";
      terminal = false;
      categories = [ "AudioVideo" "Audio" ];
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
    pkgs.tmux
    pkgs.kitty
    pkgs.alacritty

    # Networking
    # pkgs.clash-verge-rev

    # Editor
    unstable.neovim
    pkgs.lua-language-server
    pkgs.cmake-language-server
    pkgs.nil  # Nix language server
    pkgs.nodePackages.prettier
    pkgs.helix
    pkgs.zed-editor

    # Tools
    pkgs.pkg-config
    pkgs.appimage-run
    pkgs.gnumake
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

    # Python
    (pkgs.python312.withPackages (ps: with ps; [
    ]))
    pkgs.pyright
    pkgs.pipx

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

    # Multimedia
    pkgs.kdePackages.gwenview
    pkgs.vlc
    pkgs.playerctl

    # Streaming
    pkgs.obs-studio

    # Telegram
    pkgs.telegram-desktop

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

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
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
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "tmux"
      ];
    };
    plugins = [
      {
        name = "p10k-config";
        src = "${config.home.homeDirectory}/.config/p10k";
        file = "p10k.zsh";
      }
    ];
    initExtraFirst = ''
      ZSH_TMUX_AUTOSTART=true
      ZSH_TMUX_AUTOCONNECT=false
    '';
    initExtra = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
  };

  programs.git = {
    enable = true;
    userName = "arielherself";
    userEmail = "arielherself@duck.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg."ssh".program = "${unstable._1password-gui}/bin/op-ssh-sign";
      push.autoSetupRemote = true;
      core.editor = "nvim";
    };
  };

  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";
  };

  # programs.tmux = {
  #   enable = true;
  #   sensibleOnTop = false;
  #   shell = "${pkgs.zsh}/bin/zsh";
  #   extraConfig = ''
  #     # set-option -g default-shell "${pkgs.zsh}/bin/zsh"
  #     # set -g default-command "${pkgs.zsh}/bin/zsh"
  #     # setw -g mode-keys vi
  #     # set -g @plugin 'tmux-plugins/tpm'
  #     # set -g @plugin 'tmux-plugins/tmux-sensible'
  #     # set -g @plugin 'erikw/tmux-powerline'
  #     # run '~/.tmux/plugins/tpm/tpm'
  #   '';
  # };

  services.mpris-proxy.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager = {
    enable = true;
  };
}

