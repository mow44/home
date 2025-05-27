{ pkgs, ... }:
let
  bgDefault = "#222222";
  bgSelected = "#666666";

  fgDefault = "#eeeeee";
  fgSelected = "#D65D0E";
in
{
  programs.qutebrowser = {
    enable = true;

    keyBindings = {
      normal = {
        "<Ctrl-m>" = "hint links spawn ${pkgs.mpv}/bin/mpv -volume=30 {hint-url}";
        "<Ctrl-Shift-m>" = "spawn ${pkgs.mpv}/bin/mpv -volume=30 {url}";
      };
    };

    settings = {
      # https://github.com/qutebrowser/qutebrowser/issues/5378
      # https://wiki.archlinux.org/title/Chromium#Force_GPU_acceleration
      qt.args = [
        # "disable-gpu" # causes crashes on chatgpt website
        "disable-software-rasterizer"
        "disable-accelerated-video-decode"
        "disable-accelerated-video-encode"
        "disable-accelerated-2d-canvas"
        "disable-gpu-compositing"
      ];

      content = {
        autoplay = false;
        pdfjs = true;
        notifications.presenter = "libnotify";
        blocking = {
          enabled = true;
          method = "both";
          adblock.lists = [
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt"
            "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"
          ];
        };
      };
      hints = {
        border = "0px solid #E3BE23";
      };
      colors = {
        tabs = {
          bar.bg = bgDefault;
          even = {
            bg = bgDefault;
            fg = fgDefault;
          };
          odd = {
            bg = bgDefault;
            fg = fgDefault;
          };
          selected.even = {
            bg = bgSelected;
            fg = fgDefault;
          };
          selected.odd = {
            bg = bgSelected;
            fg = fgDefault;
          };
        };
        hints = {
          bg = bgDefault;
          fg = fgDefault;
          match.fg = fgSelected;
        };
        completion = {
          fg = fgDefault;
          match.fg = fgSelected;
          category = {
            bg = bgDefault;
            fg = fgDefault;
            border = {
              top = bgDefault;
              bottom = bgDefault;
            };
          };
          even.bg = bgDefault;
          odd.bg = bgDefault;
          item = {
            selected = {
              bg = bgSelected;
              fg = fgDefault;
              match.fg = fgSelected;
              border = {
                top = bgSelected;
                bottom = bgSelected;
              };
            };
          };
        };
        statusbar = {
          caret = {
            bg = bgDefault;
            fg = fgDefault;

            selection = {
              bg = bgDefault;
              fg = fgSelected;
            };
          };
          command = {
            bg = bgDefault;
            fg = fgSelected;

            private = {
              bg = bgDefault;
              fg = fgSelected;
            };
          };

          insert = {
            bg = bgDefault;
            fg = fgSelected;
          };

          normal = {
            bg = bgDefault;
            fg = fgSelected;
          };

          passthrough = {
            bg = bgDefault;
            fg = fgSelected;
          };

          private = {
            bg = bgDefault;
            fg = fgSelected;
          };

          progress.bg = bgDefault;

          url = {
            error.fg = "red"; # TODO
            fg = fgDefault;
            hover.fg = fgSelected;

            # TODO
            success = {
              http.fg = fgDefault;
              https.fg = fgDefault;
            };

            # TODO
            warn.fg = fgDefault;
          };
        };
      };
      fonts = {
        default_size = "12pt";
        default_family = "AtkynsonMono Nerd Font Mono";

        contextmenu = "default_size default_family";
      };
    };

    greasemonkey = [
      (pkgs.writeText "youtube-adb.js" ''
        // ==UserScript==
        // @name         Auto Skip YouTube Ads
        // @version      1.1.0
        // @description  Speed up and skip YouTube ads automatically
        // @author       jso8910 and others
        // @match        *://*.youtube.com/*
        // ==/UserScript==

        document.addEventListener('load', () => {
            const btn = document.querySelector('.videoAdUiSkipButton,.ytp-ad-skip-button-modern')
            if (btn) {
                btn.click()
            }
            const ad = [...document.querySelectorAll('.ad-showing')][0];
            if (ad) {
                document.querySelector('video').currentTime = 9999999999;
            }
        }, true);
      '')
    ];

    extraConfig = ''
      c.tabs.padding = { "top": 4, "bottom": 4, "left": 5, "right": 5 }
    '';
  };
}
