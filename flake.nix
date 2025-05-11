{
  description = "home-manager";

  outputs =
    {
      self,
    }:
    {
      makeHomeModule =
        inputs: username: stateVersion:
        let
          pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
          wallpapersDir = pkgs.linkFarm "wallpapers" (
            pkgs.lib.mapAttrsToList (name: _: {
              inherit name;
              path = ./wallpapers/${name};
            }) (builtins.readDir ./wallpapers)
          );
        in
        {
          imports = [
            inputs.home-manager.nixosModules.home-manager

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = {
                  inherit inputs wallpapersDir;
                };

                users.${username} = {
                  imports = [
                    ./home.nix
                    ./git.nix
                    ./lf.nix
                    ./bash.nix
                    ./helix.nix
                    ./kitty.nix
                    ./systemd.nix
                    ./dunst.nix
                  ];
                  home = {
                    username = username;
                    homeDirectory = "/home/${username}";
                    stateVersion = stateVersion;
                  };
                };
              };
            }
          ];
        };
    };
}
