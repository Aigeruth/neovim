{
  description = "A Nixvim configuration";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpgks.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixvim.url = "github:nix-community/nixvim/nixos-26.05";
  };

  outputs =
    {
      self,
      flake-parts,
      nixpkgs,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      imports = [
        # Import nixvim's flake-parts module;
        # Adds `flake.nixvimModules` and `perSystem.nixvimConfigurations`
        inputs.nixvim.flakeModules.default
      ];

      nixvim = {
        # Automatically install corresponding packages for each nixvimConfiguration
        # Lets you run `nix run .#<name>`, or simply `nix run` if you have a default
        packages.enable = true;
        # Automatically install checks for each nixvimConfiguration
        # Run `nix flake check` to verify that your config is not broken
        checks.enable = true;
      };

      # You can define your reusable Nixvim modules here
      flake.nixvimModules = {
        default = ./config;
      };

      perSystem =
        {
          system,
          pkgs,
          lib,
          ...
        }:
        {
          # You can define actual Nixvim configurations here
          nixvimConfigurations = {
            default = inputs.nixvim.lib.evalNixvim {
              inherit system;
              modules = with self.nixvimModules; [
                default
              ];
            };
          };
          checks = {
            nixfmt = pkgs.runCommand "check-with-nixfmt-tree" { } ''
              touch $out
              ${lib.getExe pkgs.nixfmt-tree} --ci ${./.}
            '';

            statix = pkgs.runCommand "check-with-statix" { } ''
              touch $out
              ${lib.getExe pkgs.statix} check ${./.}
            '';
          };

          formatter = pkgs.nixfmt-tree;
        };
    };
}
