{
  lsp.servers = {
    html.enable = true;
    nixd.enable = true;
    rubocop = {
      enable = true;
      packageFallback = true;
    };
    solargraph = {
      enable = true;
      packageFallback = true;
    };
  };
}
