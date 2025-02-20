with import <nixpkgs> {};
(pkgs.buildFHSEnv {
  name = "open-webui-env";
  targetPkgs = pkgs: with pkgs; [
    (python311.withPackages (python-pkgs: with python-pkgs; [
      pip
    ]))
    libgcc
  ];
  profile = ''
    mkdir -p $HOME/.nix-envs/open-webui-env
    ${python311}/bin/python -m venv $HOME/.nix-envs/open-webui-env
    source $HOME/.nix-envs/open-webui-env/bin/activate
    $HOME/.nix-envs/open-webui-env/bin/pip install open-webui onnxruntime
  '';
}).env
