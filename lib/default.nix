{ pkgs }:

{
  buildBunPackage = { 
    src,
    workspace ? null, # if provided i am treating as a monorepo otherwise a ployrepo
    pname ? null,
    version ? "0.1.0",
    ... 
  }@args:
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