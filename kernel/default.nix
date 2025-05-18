{
  lib,
  pkgs,
  fetchurl,
  linuxManualConfig,
  ...
}:
let
  version = "6.14.6";
  read-linux-config = pkgs.callPackage ./read-linux-config.nix { };
in
(linuxManualConfig {
  inherit version;
  modDirVersion = "${version}-darkyzhou";

  src = fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${version}.tar.xz";
    sha256 = "sha256-IYF/GZjiIw+B9+T2Bfpv3LBA4U+ifZnCfdsWznSXl6k=";
  };

  extraMakeFlags = [ "V=2" ];

  kernelPatches =
    let
      patchFiles = lib.filesystem.listFilesRecursive ./patches;
      makePatch = file: {
        name = lib.removePrefix (toString ./patches + "/") (toString file);
        patch = file;
      };
    in
    map makePatch patchFiles;

  configfile = ./config;
  config = read-linux-config ./config;
})
