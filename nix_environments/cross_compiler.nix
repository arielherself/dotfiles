{ pkgs ? import <nixpkgs> {} }:

let
  crossPkgs = import <nixpkgs> {
	crossSystem = { config = "armv7a-linux-gnueabihf"; };
  };
in
pkgs.mkShell {
	packages = with pkgs; [
		crossPkgs.buildPackages.gcc
		crossPkgs.glibc.static
		pkg-config
		llvmPackages_18.clang
		flex
		bison
	];
}
