with import <nixpkgs> {};
(pkgs.buildFHSEnv {
    name = "azule-runtime";
    targetPkgs = pkgs: with pkgs; [
        libplist
        xmlstarlet
        libxml2
        jq
    ];
    runScript = "bash";
}).env
