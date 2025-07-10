{
  programs.kitty = {
    enable = true;
    themeFile = "gruvbox-dark";
    font = {
      # name = "DroidSansMNerdFontMono";
      # name = "AtkynsonMono Nerd Font Mono";
      name = "JetBrains Mono"; # FIXME
      size = 12;
    };
    settings = {
      confirm_os_window_close = 0;
    };
  };
}
