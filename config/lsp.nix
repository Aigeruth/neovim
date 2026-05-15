{ lib, pkgs, ... }:
{
  lsp.servers = {
    html.enable = true;
    nixd = {
      enable = true;
      config.settings.nixd.formatting.command = [ "${lib.getExe pkgs.nixfmt}" ];
    };
    rubocop = {
      enable = true;
      packageFallback = true;
    };
    solargraph = {
      enable = true;
      packageFallback = true;
    };
  };
  plugins = {
    lsp-format.enable = true;
    lspconfig.enable = true;
  };
}
