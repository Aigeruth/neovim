{ lib, pkgs, ... }:
{
  lsp.servers = {
    # CSS
    tailwindcss = {
      enable = true;
      packageFallback = true;
    };
    html.enable = true;
    # Nix
    nixd = {
      enable = true;
      config.settings.nixd.formatting.command = [ "${lib.getExe pkgs.nixfmt}" ];
    };
    # OpenSCAD
    openscad_lsp = {
      enable = true;
    };
    # Python
    ruff = {
      enable = true;
      packageFallback = true;
    };
    ty = {
      enable = true;
      packageFallback = true;
    };
    # Ruby
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
