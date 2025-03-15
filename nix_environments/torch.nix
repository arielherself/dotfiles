with import <nixpkgs> {};
(pkgs.buildFHSEnv {
	name = "torch_env";
	targetPkgs = pkgs: with pkgs; [
		cudatoolkit
		libGLU
		libGL
		stdenv.cc
		binutils
		autoconf
		(python3.withPackages(ps: with ps; [
			torch-bin
			# torchWithCuda
			torchvision-bin
		]))
		lolcat
		bash
	];
	runScript = "bash --init-file /etc/profile";
	profile = ''
		alias python="nixGL /usr/bin/python"  # You should install nixGL first
		export PATH=/usr/bin:$PATH
		export CUDA_PATH=${pkgs.cudatoolkit}
		export EXTRA_CCFLAGS="-I/usr/include"

		source $HOME/.bashrc
	'';
}).env
