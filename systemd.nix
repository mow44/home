{
  system,
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
        ExecStart = ''
          ${scripts.packages.${system}.default}/bin/set-wallpaper
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
