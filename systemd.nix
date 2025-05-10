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
        ExecStart = "${pkgs.hsetroot}/bin/hsetroot -fill /home/a/NixOS-B550/wallpapers/1.jpg";
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
