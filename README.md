# nushell-config

Nushell shell configuration. Clone directly into `~/.config/nushell/`, same
pattern as NeoVim's config in `~/.config/nvim/`.

## Setup

```bash
# Install dependencies
brew install nushell starship

# Clone into place
git clone <this-repo> ~/.config/nushell
```

That's it. Nushell reads `~/.config/nushell/` by default — `env.nu`, `config.nu`,
and `login.nu` are all picked up automatically. The `starship.toml` is colocated
here too; `env.nu` sets `STARSHIP_CONFIG` to point at it.

## Running Nushell

The safest way to start using Nushell is to set your terminal emulator's shell
command to `/opt/homebrew/bin/nu` rather than changing your login shell with
`chsh`. This keeps `/bin/zsh` as the system login shell so Homebrew and macOS
system scripts keep working.

If you do want `chsh`:
1. Add `/opt/homebrew/bin/nu` to `/etc/shells`
2. `chsh -s /opt/homebrew/bin/nu`
3. Keep a backup terminal session open until you've verified everything works

## Repo layout

```
env.nu          # Environment variables, PATH, starship init
config.nu       # Shell behavior, keybindings, aliases, completions
login.nu        # Login-shell-only setup (Homebrew env vars)
starship.toml   # Prompt config (replaces powerlevel10k)
```

## Migration from ZSH

| ZSH (old)                     | Nushell (new)                                    |
|-------------------------------|--------------------------------------------------|
| oh-my-zsh + antigen           | Not needed — built-in completions                |
| powerlevel10k                 | Starship (`starship.toml` in this repo)          |
| zsh-syntax-highlighting       | Built into Nushell                               |
| fzf keybindings               | Built-in fuzzy completions; fzf usable in pipes  |
| git plugin aliases            | Explicit aliases in `config.nu`                  |
| `.zprofile` / `brew shellenv` | `login.nu`                                       |
| `export VAR=val`              | `$env.VAR = "val"` in `env.nu`                   |
| `source ~/.fzf.zsh`           | Not needed                                       |

## ZSH cleanup

Once you're settled, these can be removed from `$HOME`:

- `~/.antigen/` and `~/.antigen.zsh`
- `~/.oh-my-zsh/`
- `~/.zsh-config/`
- `~/.fzf.zsh`, `~/.fzf.bash`
- `~/.zcompdump`

Keep `~/.zshrc` and `~/.zprofile` around as a fallback until you're confident.

## Optional tools

```bash
brew install fzf bat eza fd ripgrep
```

Uncomment the corresponding aliases in `config.nu` after installing.
