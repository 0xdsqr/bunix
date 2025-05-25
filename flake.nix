{
  description = "🟪 bunix 🟪";
  
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/release-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  
  outputs = { self, nixpkgs-unstable, nixpkgs-stable, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs-unstable = import nixpkgs-unstable { inherit system; };
        pkgs-stable = import nixpkgs-stable { inherit system; };

        # import the library
        bunixLib = import ./lib { pkgs = pkgs-stable; };
      in {
        # export the library
        lib = bunixLib;
        
        devShells.default = pkgs-stable.mkShell {
          buildInputs = with pkgs-stable; [
            nixfmt
            cargo
            rustc
          ];
          
          shellHook = ''
            echo "🟪 bunix development environment ready"
          '';
        };
      });
}