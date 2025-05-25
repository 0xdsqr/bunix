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
      in {
        devShells.default = nixpkgs-stable.mkShell {
            buildInputs = with pkgs-stable; [
                # For Nix development
                nixfmt
                nix-linter
                
                # For Rust development
                cargo
                rustc
            ];

        shellHook = ''
            echo "🟪 Bun development environment ready"
          '';
        }
});
}