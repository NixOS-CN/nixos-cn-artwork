{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    flake-parts.inputs.nixpkgs-lib.follows = "nixpkgs";

    # flake modules
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;}
    {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];
      imports = [
        inputs.treefmt-nix.flakeModule
      ];
      perSystem = {
        config,
        pkgs,
        lib,
        ...
      }: {
        packages.icons = pkgs.stdenv.mkDerivation {
          name = "nixos-cn-icons";
          src = lib.cleanSource ./.;
          buildInputs = [pkgs.imagemagick];
          makeFlags = ["-C icons" "DESTDIR=$(out)"];
        };
        checks = config.packages;
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
          };
        };
      };
    };
}
