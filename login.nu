# login.nu - Sourced only when Nushell is a login shell.
# Runs after env.nu and config.nu.
#
# Use this for setup that should only happen once per login session,
# such as system-specific environment overrides.

# Homebrew shellenv (macOS ARM)
# When launching nu from a POSIX login shell, these are inherited.
# When nu IS the login shell, we set them explicitly.
if ("/opt/homebrew/bin/brew" | path exists) {
    $env.HOMEBREW_PREFIX = "/opt/homebrew"
    $env.HOMEBREW_CELLAR = "/opt/homebrew/Cellar"
    $env.HOMEBREW_REPOSITORY = "/opt/homebrew"
    $env.MANPATH = $"/opt/homebrew/share/man:(if ('MANPATH' in $env) { $env.MANPATH } else { '' })"
    $env.INFOPATH = $"/opt/homebrew/share/info:(if ('INFOPATH' in $env) { $env.INFOPATH } else { '' })"
}
