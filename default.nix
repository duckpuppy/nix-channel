# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:

{
  # The `lib`, `modules`, and `overlay` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays

  aws-ssm-tools = pkgs.callPackage ./pkgs/aws-ssm-tools { };
  base16-shell = pkgs.callPackage ./pkgs/base16-shell { };
  ls-colors = pkgs.callPackage ./pkgs/ls-colors { inherit pkgs; };
  _3llo = pkgs.callPackage ./pkgs/3llo { inherit pkgs; };
  vault-aws-creds = pkgs.callPackage ./pkgs/vault-aws-creds { };
  wsl-open = pkgs.callPackage ./pkgs/wsl-open { };
  moar = pkgs.callPackage ./pkgs/moar-pager { };
  null-ls-nvim = pkgs.callPackage ./pkgs/null-ls-nvim { };
  tami5-lspsaga-nvim = pkgs.callPackage ./pkgs/lspsaga-nvim { };
  wordle-cli = pkgs.callPackage ./pkgs/wordle-cli { };
  prettier-nvim = pkgs.callPackage ./pkgs/prettier-nvim { };
  # inherit (pkgs.callPackage ./pkgs/alks { }) alks;
}
