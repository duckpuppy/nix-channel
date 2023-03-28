{ pkgs, ... }:
{
  # Add your overlays here
  #
  # my-overlay = import ./my-overlay;
  wsl = import ./wsl-open { inherit pkgs; };
}
