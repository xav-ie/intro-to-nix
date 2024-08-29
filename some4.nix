{
  pkgs ? import <nixpkgs> { },
}:
let
  x = 2;
  y = 4;
in
{
  z = x + y + y;
  myHello = pkgs.hello;
}
