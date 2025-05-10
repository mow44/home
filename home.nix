{
  pkgs,
  ...
}:
{
  programs.home-manager.enable = true;

  home = {
    packages = with pkgs; [
      alsa-utils

      bat
      bashmount
      bottom
      bluetuith

      clinfo
      corefonts
      cmus

      drawio

      eza

      ffmpeg_7-full
      fselect
      feh

      htop
      hsetroot

      keepassxc

      lm_sensors
      librewolf
      libreoffice-qt

      maim

      nix-output-monitor

      obs-studio

      pavucontrol
      polkit

      qalculate-gtk
      qbittorrent

      telegram-desktop

      v2raya
      vlc
      vistafonts
      vesktop

      walk

      xclip

      hunspell
      hunspellDicts.en_US
      hunspellDicts.ru_RU

      steam
      steam-tui
      steam-run
      steamcmd

      krita
    ];
  };
}
