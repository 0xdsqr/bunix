# bunix

A Nix library for packaging Bun projects with pure, reproducible builds.

## What it is

bunix provides a `buildBunPackage` function that you can use in your Nix flakes to package Bun applications.

## What it will be

- Parse `bun.lockb` files automatically
- Download dependencies to the Nix store
- Create reproducible builds without network access during build time
- Support for monorepos and complex dependency trees

## Usage

```nix
{
  inputs.bunix.url = "github:your-username/bunix";
  
  outputs = { bunix, ... }: {
    packages.default = bunix.lib.buildBunPackage {
      src = ./.;
    };
  };
}
```

> [!IMPORTANT]  
> This project is under active development for learning purposes. Check back for updates as features are implemented!

## Development

```bash
nix develop
cd parser && cargo run  # Test Rust parser
nix eval .#lib          # Test Nix library
```