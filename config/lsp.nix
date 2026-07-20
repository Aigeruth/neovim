{ lib, pkgs, ... }:
{
  lsp = {
    inlayHints.enable = true;
    keymaps = [
      {
        key = "gd";
        lspBufAction = "definition";
      }
      {
        key = "gD";
        lspBufAction = "references";
      }
      {
        key = "gt";
        lspBufAction = "type_definition";
      }
      {
        key = "gi";
        lspBufAction = "implementation";
      }
      {
        key = "K";
        lspBufAction = "hover";
      }
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=-1, float=true }) end";
        key = "<leader>k";
      }
      {
        action = lib.nixvim.mkRaw "function() vim.diagnostic.jump({ count=1, float=true }) end";
        key = "<leader>j";
      }
      {
        action = "<CMD>LspStop<Enter>";
        key = "<leader>lx";
      }
      {
        action = "<CMD>LspStart<Enter>";
        key = "<leader>ls";
      }
      {
        action = "<CMD>LspRestart<Enter>";
        key = "<leader>lr";
      }
      {
        action = lib.nixvim.mkRaw "require('telescope.builtin').lsp_definitions";
        key = "gd";
      }
      {
        key = "K";
        action = "<CMD>Lspsaga hover_doc<Enter>";
      }
    ];
    servers = {
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
  };
  plugins = {
    lsp-format.enable = true;
    lspconfig.enable = true;
    telescope.enable = true;
  };
}
