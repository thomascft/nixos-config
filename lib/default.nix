{ self, ... }:
let
  resolveModule = base: name:
  let
    basePath = self.outPath + "/${base}/modules/${name}";
    nixPath = basePath + ".nix";
  in
    if builtins.pathExists basePath then basePath
    else if builtins.pathExists nixPath then nixPath
    else throw "resolveModule: Could not locate module \"${name}\" at \"<flake-root>/${base}/modules\"";
in {
  resolveHomeModule = resolveModule "home";
  resolveHomeModules = builtins.map (name: resolveModule "home" name);
  resolveSystemModule = resolveModule "system";
  resolveSystemModules = builtins.map (name: resolveModule "system" name);
}
