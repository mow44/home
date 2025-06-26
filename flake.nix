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
        userName: stateVersion: system:
        let
          pkgs = import nixpkgs { inherit system; };

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
                  inherit
                    system
                    wallpapersDir
                    helix
                    slstatus
                    ;
                };

                users.${userName} = {
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
                    username = userName;
                    homeDirectory = "/home/${userName}";
                    stateVersion = stateVersion;
                  };
                };
              };

              environment.systemPackages = [
                home-manager.packages.${system}.home-manager
              ];
            }
          ];
        };
    };
}
