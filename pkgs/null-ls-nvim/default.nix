{ pkgs ? import <nixpkgs> { }, lib, buildGoModule, fetchFromGitHub, sources ? import ../../nix/sources.nix }:

let
  null-ls-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    name = "null-ls-nvim";
    src = sources."null-ls.nvim";
  };
in
null-ls-nvim
