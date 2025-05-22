{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helix = {
      url = "github:helix-editor/helix/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    slstatus = {
      url = "github:mow44/slstatus/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      helix,
      slstatus,
    }:
    {
      makeHomeModule =
        username: stateVersion:
        let
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          wallpapersDir = pkgs.linkFarm "wallpapers" (
            pkgs.lib.mapAttrsToList (name: _: {
              inherit name;
              path = ./wallpapers/${name};
            }) (builtins.readDir ./wallpapers)
          );
        in
        {
          imports = [
            home-manager.nixosModules.home-manager

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = {
                  inherit wallpapersDir helix slstatus;
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
                    ./qutebrowser.nix
                    ./syncthing.nix
                  ];
                  home = {
                    username = username;
                    homeDirectory = "/home/${username}";
                    stateVersion = stateVersion;
                  };
                };
              };

              environment.systemPackages = [
                home-manager.packages.x86_64-linux.home-manager
              ];
            }
          ];
        };
    };
}
