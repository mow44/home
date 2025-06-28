{
  pkgs,
  system,
  wallpapers,
  slstatus,
  scripts,
  ...
}:
{
  systemd.user = {
    startServices = true;

    services.set-wallpaper = {
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "oneshot";
        # ExecStart = ''
        #   ${pkgs.runtimeShell} -c '${pkgs.hsetroot}/bin/hsetroot -fill "$(${pkgs.busybox}/bin/find ${wallpapers} \( -type f -o -type l \) | ${pkgs.busybox}/bin/shuf -n 1)"'
        # '';
        ExecStart = ''
          ${scripts}/bin/set-wallpaper
        '';
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };

    services.start-slstatus = {
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = ''
          ${slstatus.packages.${system}.default}/bin/slstatus
        '';
        Restart = "always";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
