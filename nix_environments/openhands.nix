with import <nixpkgs> {};
pkgs.mkShell {
	packages = with pkgs; [
		dbus
		gcc-unwrapped
		libgcc
		python312
		pkg-config
		poetry
		nodejs_22
		netcat-gnu
	];
	shellHook = ''
		export LD_LIBRARY_PATH="${pkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH";
	'';
}
