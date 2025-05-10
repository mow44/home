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
        # ExecStart = ''
        #   ${pkgs.hsetroot}/bin/hsetroot -fill "$(${pkgs.busybox}/bin/find /home/a/NixOS-B550/wallpapers/ -type f | ${pkgs.busybox}/bin/shuf -n 1)"
        # '';
        ExecStart = ''
          ${pkgs.hsetroot}/bin/hsetroot -fill /home/a/NixOS-B550/wallpapers/2.jpg"
        '';
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
