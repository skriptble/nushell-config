# env.nu - Environment configuration for Nushell
# Evaluated before config.nu; set environment variables here.

# ──────────────────────────────────────────────
# Editor
# ──────────────────────────────────────────────

$env.EDITOR = (if ("/opt/homebrew/bin/nvim" | path exists) {
    "/opt/homebrew/bin/nvim"
} else {
    (which nvim | get 0?.path? | default "vi")
})
$env.VISUAL = $env.EDITOR

# ──────────────────────────────────────────────
# GPG
# ──────────────────────────────────────────────

$env.GPG_TTY = (tty)

# ──────────────────────────────────────────────
# Go
# ──────────────────────────────────────────────

$env.GOPATH = $env.HOME

# ──────────────────────────────────────────────
# Rust
# ──────────────────────────────────────────────

$env.RUST_SRC_PATH = ($env.HOME | path join "sandbox" "rust-src" "src")

# ──────────────────────────────────────────────
# Bun
# ──────────────────────────────────────────────

$env.BUN_INSTALL = ($env.HOME | path join ".bun")

# ──────────────────────────────────────────────
# Terminal / color
# ──────────────────────────────────────────────

$env.COLORTERM = "truecolor"

# ──────────────────────────────────────────────
# Prompt — Starship
# ──────────────────────────────────────────────
# starship.toml lives in this repo alongside the nushell config,
# so point STARSHIP_CONFIG here instead of the default ~/.config/starship.toml.

$env.STARSHIP_CONFIG = ($nu.default-config-dir | path join "starship.toml")

if (which starship | is-not-empty) {
    mkdir ($env.HOME | path join ".cache" "starship")
    starship init nu | save -f ($env.HOME | path join ".cache" "starship" "init.nu")
}

# ──────────────────────────────────────────────
# PATH
# ──────────────────────────────────────────────

use std/util "path add"

# Homebrew (macOS ARM)
if ("/opt/homebrew/bin" | path exists) {
    path add "/opt/homebrew/bin"
    path add "/opt/homebrew/sbin"
}

# Personal bin
path add ($env.HOME | path join "bin")

# Composer bin
path add ($env.HOME | path join ".config/composer/vendor/bin")

# GNU coreutils (if installed via Homebrew)
let gnubin = "/usr/local/opt/coreutils/libexec/gnubin"
if ($gnubin | path exists) { path add $gnubin }

# Homebrew curl override
let brewcurl = "/usr/local/opt/curl/bin"
if ($brewcurl | path exists) { path add $brewcurl }

# Cargo / Rust
path add ($env.HOME | path join ".cargo" "bin")

# Go binaries (GOPATH/bin)
path add ($env.GOPATH | path join "bin")

# Bun
path add ($env.BUN_INSTALL | path join "bin")

# LM Studio CLI
path add ($env.HOME | path join ".lmstudio" "bin")
