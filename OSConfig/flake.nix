{
  description = "My first flake system.";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs.url = "nixpkgs/nixos-25.11";
  };
  outputs = { self, nixpkgs, ... }:
	let 
		lib = nixpkgs.lib;
	in {
		nixosConfigurations = {
				nixos = lib.nixosSystem {
					system = "x86_64-linux";
					modules = [ ./configuration.nix ];
				};
		};
	};
}
