{
  pkgs,
  system,
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

      # TODO call script from scripts-flake. and make flake for wallpapers so it will be accessable from scripts-flake
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
        # FIXME
        ExecStart = ''
          ${slstatus.defaultPackage.${system}}/bin/slstatus
        '';
        Restart = "always";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
