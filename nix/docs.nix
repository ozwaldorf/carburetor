pkgs:
let
  gitHubDeclaration = user: repo: branch: subpath: {
    url = "https://github.com/${user}/${repo}/blob/${branch}/${subpath}";
    name = "<${repo}/${subpath}>";
  };
  prefixPath = toString ./..;
  transformOptions =
    opt:
    opt
    // {
      declarations = map (
        decl:
        if pkgs.lib.hasPrefix prefixPath (toString decl) then
          gitHubDeclaration "ozwaldorf" "carburetor" "main" (
            pkgs.lib.removePrefix "/" (pkgs.lib.removePrefix prefixPath (toString decl))
          )
        else if decl == "lib/modules.nix" then
          gitHubDeclaration "NixOS" "nixpkgs" "master" decl
        else
          decl
      ) opt.declarations;
    };

  eval = pkgs.lib.evalModules {
    modules = [
      ./home
      { _module.check = false; }
    ];
  };
  optionsDoc = pkgs.nixosOptionsDoc {
    inherit transformOptions;
    options = builtins.removeAttrs eval.options [ "_module" ];
  };
in
optionsDoc.optionsCommonMark
