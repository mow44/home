{
  description = "home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    scripts = {
      url = "github:mow44/scripts/main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs =
    {
      home-manager,
      helix,
      slstatus,
      scripts,
      ...
    }:
    {
      makeHomeModule = userName: stateVersion: system: {
        imports = [
          home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit
                  system
                  helix
                  slstatus
                  scripts
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
