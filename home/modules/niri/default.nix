{ config, lib, ... }:{

  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink ./config;
    recursive = true;
  };
}
