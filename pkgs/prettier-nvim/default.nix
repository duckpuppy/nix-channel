{ pkgs ? import <nixpkgs> { }, lib, buildGoModule, fetchFromGitHub, sources ? import ../../nix/sources.nix }:

let
  prettier-nvim = pkgs.vimUtils.buildVimPluginFrom2Nix rec {
    name = "prettier-nvim";
    src = sources."prettier.nvim";
  };
in
prettier-nvim
