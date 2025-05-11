{ pkgs, wallpapersDir, ... }:
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
          ${pkgs.runtimeShell} -c '${pkgs.hsetroot}/bin/hsetroot -fill "$(${pkgs.busybox}/bin/find /home/a/NixOS-home/wallpapers -type f | ${pkgs.busybox}/bin/shuf -n 1)"'
        '';
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
