use std::env;
use std::fs;
use std::path::Path;
use anyhow::{Context, Result};
use serde_json::Value;

fn print_workspaces(parsed: &Value) {
    if let Some(workspaces) = parsed.get("workspaces").and_then(|w| w.as_object()) {
        for (key, workspace) in workspaces {
            println!("Workspace key: {}", key);
            if let Some(name) = workspace.get("name").and_then(|n| n.as_str()) {
                println!("  Name: {}", name);
            } else {
                println!("  No 'name' field found");
            }
        }
    } else {
        println!("No 'workspaces' section found or it is not an object");
    }
}

fn main() -> Result<()> {
    let args: Vec<String> = env::args().collect();
    if args.len() != 2 {
        anyhow::bail!("Usage: bunix-parser <project-root>");
    }

    let root = &args[1];
    let lockfile_path = Path::new(root).join("bun.lock");

    if !lockfile_path.exists() {
        anyhow::bail!("bun.lock not found");
    }

    let content = fs::read_to_string(&lockfile_path)
        .with_context(|| format!("Failed to read bun.lock at {}", lockfile_path.display()))?;

å    let parsed: Value = json5::from_str(&content)
        .context("Failed to parse bun.lock as JSON5")?;

    print_workspaces(&parsed);

    Ok(())
}
