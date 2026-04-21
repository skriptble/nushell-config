# config.nu - Nushell shell configuration
# Controls interactive behavior: prompt, keybindings, completions, history.

# ──────────────────────────────────────────────
# Core settings
# ──────────────────────────────────────────────

$env.config = {
    show_banner: false

    # History
    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "sqlite"
        isolation: false
    }

    # Completions
    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        use_ls_colors: true
    }

    # Editing
    edit_mode: emacs
    use_kitty_protocol: true
    highlight_resolved_externals: true

    # Table display
    table: {
        mode: rounded
        index_mode: auto
        show_empty: true
        padding: { left: 1, right: 1 }
        trim: {
            methodology: wrapping
            wrapping_try_keep_words: true
        }
        header_on_separator: false
    }

    # Error display
    error_style: "fancy"

    # rm → trash by default (safer)
    # rm: {
    #     always_trash: true
    # }

    # Hooks
    hooks: {
        pre_prompt: []
        pre_execution: []
        env_change: {}
        display_output: "if (term size).columns >= 100 { table -e } else { table }"
        command_not_found: {||
            null
        }
    }

    keybindings: [
        {
            name: menu_down
            modifier: control
            keycode: char_j
            mode: [emacs, vi_insert, vi_normal]
            event: { send: MenuDown }
        }
        {
            name: menu_up
            modifier: control
            keycode: char_k
            mode: [emacs, vi_insert, vi_normal]
            event: { send: MenuUp }
        }
        {
            name: accept_hint_word
            modifier: control
            keycode: char_l
            mode: [emacs, vi_insert, vi_normal]
            event: { send: HistoryHintWordComplete }
        }
    ]
}

# ──────────────────────────────────────────────
# Starship prompt
# STARSHIP_CONFIG is set in env.nu to point at this repo's starship.toml.
# The init script is cached at ~/.cache/starship/init.nu by env.nu.
# ──────────────────────────────────────────────

let starship_init = ($env.HOME | path join ".cache" "starship" "init.nu")
if ($starship_init | path exists) {
    source ~/.cache/starship/init.nu
}

# ──────────────────────────────────────────────
# Aliases
# ──────────────────────────────────────────────

# Git shortcuts (replaces oh-my-zsh git plugin essentials)
alias ga = git add
alias gaa = git add --all
alias gc = git commit
alias gcm = git commit -m
alias gco = git checkout
alias gd = git diff
alias gds = git diff --staged
alias gf = git fetch
alias gl = git log --oneline --graph --decorate
alias gp = git push
alias gpl = git pull
alias gs = git status
alias gsw = git switch
alias gsc = git switch -c
alias grb = git rebase
alias grbi = git rebase -i

# Editor
alias e = nvim
alias vi = nvim
alias vim = nvim

# Modern replacements (uncomment as you install them)
# alias cat = bat
# alias find = fd
# alias ls = eza

# ──────────────────────────────────────────────
# Custom commands
# ──────────────────────────────────────────────

# Quick directory shortcuts
def --env cdg [] { cd $env.GOPATH }
def --env cdc [] { cd ($env.HOME | path join ".config") }
def --env cdn [] { cd ($env.HOME | path join ".config" "nushell") }

# Show PATH entries, one per line
def path-list [] { $env.PATH | each {|p| $p } }

# ──────────────────────────────────────────────
# fzf integration
# ──────────────────────────────────────────────
# Nushell has built-in fuzzy completions (configured above),
# but fzf is still useful for file picking and history search.
# You can invoke fzf directly in pipelines:
#
#   ls | get name | to text | fzf | str trim
