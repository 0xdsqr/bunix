use anyhow::Result;
use std::env;

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() != 2 {
        eprintln!("Usage: bunix-parser <path-to-bun.lockb>");
        std::process::exit(1);
    }
    
    let lockfile_path = &args[1];
    println!("lockfile path is {}", lockfile_path);

    Ok(())
}
