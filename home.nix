{
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  home = {
    file.".config/uxn/theme".text = ''
      0Z1Y2X
    '';

    packages = with pkgs; [
      alsa-utils
      bashmount
      bat
      bluetuith
      bottom
      btop
      chatterino2
      clinfo
      cmus
      corefonts
      drawio
      eza
      feh
      ffmpeg_7-full
      fselect
      hsetroot
      htop
      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU
      keepassxc
      krita
      libreoffice-qt
      lm_sensors
      maim
      nix-output-monitor
      obs-studio
      pavucontrol
      polkit
      python312Packages.adblock # qutebrowser adblock
      qalculate-gtk
      qbittorrent
      steam
      steam-run
      steam-tui
      steamcmd
      telegram-desktop
      v2raya
      vesktop
      vistafonts
      vlc
      walk
      wireguard-tools
      xclip
    ];
  };
}
