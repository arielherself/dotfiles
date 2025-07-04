{
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
	};

	outputs = { self, nixpkgs } : let
		system = "x86_64-linux";
		pkgs = import nixpkgs { inherit system; };
		crossPkgs = import nixpkgs {
			inherit system;
			crossSystem = { config = "aarch64-linux-gnu"; };
		};

		buildDependencies = with pkgs; [
			pkg-config
			llvmPackages_18.clang-tools
			llvmPackages_18.clang
			cmake
			ninja
			flex
			bison
		];

		testDependencies = with pkgs; [
			pkg-config
			crossPkgs.buildPackages.gcc
			crossPkgs.glibc.static
			python311
			qemu
		];
	in {
		packages.x86_64-linux.default = pkgs.stdenv.mkDerivation {
			name = "compiler";
			src = ./.;

			nativeBuildInputs = buildDependencies;

			doCheck = true;
			nativeCheckInputs = testDependencies;
			checkPhase = ''
				mkdir -p $out
				cp -r $src/test ./test
				cp $src/tools/test.py ./test.py
				substituteInPlace ./test.py --replace "build/tools/compiler" "$PWD/tools/compiler"
				substituteInPlace ./test.py --replace "vendor/libsysy" "$src/vendor/libsysy"
				${pkgs.python311}/bin/python3 ./test.py | tee $out/test_result.txt
			'';

			installPhase = ''
				mkdir -p $out/bin
				mv tools/compiler $out/bin/compiler
			'';
		};

		devShells.x86_64-linux.default = pkgs.mkShell {
			packages = buildDependencies ++ testDependencies;
		};
	};
}
