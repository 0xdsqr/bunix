use anyhow::Result;
use std::env;
use std::fs;

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();

    if args.len() != 2 {
        eprintln!("Usage: bunix-parser <path-to-bun.lockb>");
        std::process::exit(1);
    }
    
    let lockfile_path = &args[1];
    println!("lockfile path is {}", lockfile_path);
    let result = parse_lockfile(lockfile_path);
    println!("{}", result.unwrap());

    Ok(())
}

fn parse_lockfile(path: &str) -> Result<String> {
    let data = fs::read(path)?;
    let content = String::from_utf8_lossy(&data);
    
    Ok(content.to_string())
} 