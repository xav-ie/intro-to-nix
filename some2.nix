{
  pkgs ? import <nixpkgs> { },
}:
let
  x = 2;
  y = 3;
in
{
  z = x + y;
  myHello = pkgs.hello;
}
