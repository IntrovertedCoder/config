{ flake-checker, ... }:

final: prev:
{
  inherit (flake-checker.packages.${prev.stdenv.hostPlatform.system}) flake-checker;
}
