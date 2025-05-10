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
          ${pkgs.hsetroot}/bin/hsetroot -fill "$(find ~/NixOS-B550/wallpapers/ -type f | shuf -n 1)"
        '';
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
