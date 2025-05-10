{ pkgs, ... }:
{
  systemd.user = {
    startServices = true;

    services.set-wallpaper = {
      script = ''
        	${pkgs.hsetroot}/bin/hsetroot -fill /home/a/NixOS-B550/wallpapers/1.jpg
      '';

      wantedBy = [ "graphical-session.target" ];
      partOf = [ "graphical-session.target" ];
    };
  };
}
