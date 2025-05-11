{ pkgs, ... }:
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        width = 400;
        height = "0x300";
        origin = "top-right";
        offset = "30x50";

        progress_bar = true;
        progress_bar_height = 10;
        progress_bar_frame_width = 1;
        progress_bar_min_width = 150;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 0;

        icon_corner_radius = 0;

        indicate_hidden = "yes";

        transparency = 10;

        separator_height = 2;
        separator_color = "frame";

        padding = 6;
        horizontal_padding = 6;
        text_icon_padding = 0;

        frame_width = 3;

        frame_color = "#8EC07C";

        sort = "no";

        font = "DroidSansMNerdFontMono 12";

        line_height = 3;

        markup = "full";

        format = "<b>%s</b>\n%b";

        alignment = "center";
        vertical_alignment = "center";

        ellipsize = "middle";

        ignore_newline = "no";

        stack_duplicates = true;

        browser = "${pkgs.xdg-utils}/bin/xdg-open";

        title = "Dunst";
        class = "Dunst";

        corner_radius = 0;

        ignore_dbusclose = false;
      };

      urgency_low = {
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        timeout = 4;
      };

      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        timeout = 6;
        override_pause_level = 30;
      };

      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        timeout = 8;
        override_pause_level = 60;
      };
    };
  };
}
