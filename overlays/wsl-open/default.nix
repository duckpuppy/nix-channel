{ pkgs, ... }:
self: (
  super: {
    wsl-open = pkgs.callPackage ../../pkgs/wsl-open { };
  }
)
