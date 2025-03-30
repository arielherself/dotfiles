with import <nixpkgs> {};
(pkgs.buildFHSEnv {
	name = "fudan_compiler";
	targetPkgs = pkgs: with pkgs; [
		gcc
		gnumake
		cmake
		ninja
		pkg-config
		flex
		bison
		bash
	];
	runScript = "bash";
 }).env
