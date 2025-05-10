{ pkgs, ... }:
{
  systemd.user = {
    startServices = true;

    services.set-wallpaper = {
      Unit = {
        After = [ "graphical-session.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        ExecStart = ''
          ${pkgs.hsetroot}/bin/hsetroot -fill "$(${pkgs.busybox}/bin/find ~/NixOS-B550/wallpapers/ -type f | ${pkgs.busybox}/bin/shuf -n 1)"
        '';
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
