with import <nixpkgs> {};
let
	mypkgs = import (pkgs.fetchFromGitHub {
		owner = "arielherself";
		repo = "mypkgs";
		rev = "b95c5d6";
		hash = "sha256-rFLBZR5SlWrpEzxr4lBWOx48S7yRnaoPeEIpKqng8w0=";
	});
in
(pkgs.buildFHSEnv {
	name = "libtorch_env";
	targetPkgs = pkgs: with pkgs; [
		# cudatoolkit
		libGLU
		libGL
		stdenv.cc
		binutils
		autoconf
		# mypkgs.libtorch-cuda
		lolcat
		bash
	];
	runScript = "bash --init-file /etc/profile";
	profile = ''
		export PATH=/usr/bin:$PATH
		export EXTRA_CCFLAGS="-I/usr/include"

		source $HOME/.bashrc
	'';
}).env
