{
  description = "edmund's headless NixOS workstation (minisforum)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # nixvim = {
    #   url = "github:nix-community/nixvim/nixos-25.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }: {
    nixosConfigurations.minisforum = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit rust-overlay; };
      modules = [
        # nixvim.nixosModules.nixvim    # TODO: re-enable
        ./hosts/minisforum.nix
      ];
    };
  };
}
