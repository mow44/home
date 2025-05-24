{
  pkgs,
  wallpapersDir,
  slstatus,
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
        ExecStart = ''
          ${pkgs.runtimeShell} -c '${pkgs.hsetroot}/bin/hsetroot -fill "$(${pkgs.busybox}/bin/find ${wallpapersDir} \( -type f -o -type l \) | ${pkgs.busybox}/bin/shuf -n 1)"'
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
          ${slstatus.defaultPackage.x86_64-linux}/bin/slstatus
        '';
        Restart = "always";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
