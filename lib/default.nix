{ pkgs }:

{
  buildBunPackage = { src, ... }@args:
    pkgs.stdenv.mkDerivation {
      name = "bunix";
      inherit src;
      
      buildInputs = [ pkgs.bun ];
      
      buildPhase = ''
        echo "Hello from bunix Nix library!"
        echo "Building with Bun..."
        mkdir -p dist
        echo "console.log('Hello from Bunix!');" > dist/index.js
      '';
      
      installPhase = ''
        mkdir -p $out
        cp -r dist/* $out/
      '';
    };
}