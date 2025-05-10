{
  description = "home-manager";

  outputs =
    {
      self,
    }:
    {
      makeHomeModule = inputs: username: stateVersion: {
        imports = [
          inputs.home-manager.nixosModules.home-manager

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit inputs;
              };

              users.${username} = {
                imports = [
                  ./home.nix
                  ./git.nix
                  ./lf.nix
                  ./bash.nix
                  ./helix.nix
                  ./kitty.nix
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
