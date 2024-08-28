{ ... }:
{
  cachix.enable = false;

  languages.javascript = {
    enable = true;
    pnpm.enable = true;
  };
}
