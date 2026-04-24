{ pkgs, ... }:
#
# System-wide packages + shell setup — lifted from ~/.hewnix-ext/user-config.nix
# and adapted for a single-user headless workstation.
#
{
  environment.systemPackages = with pkgs; [
    # Shell & terminal
    nushell
    tmux
    starship
    zoxide
    eza
    trash-cli
    carapace
    tree

    # Python + tools
    uv
    basedpyright
    ruff

    # Formatters
    stylua
    taplo
    prettierd
    jq

    # Dev
    git
    ripgrep
    nodejs_20

    # Rust (stable toolchain from rust-overlay; falls back to nixpkgs rustc
    # if the overlay isn't present)
    rust-bin.stable.latest.default
    cargo-watch

    # Virtualization
    docker-compose
  ];

  environment.shells = with pkgs; [ nushell ];
  programs.starship.enable = true;

  # nix-ld lets non-Nix binaries find common libs (useful for rust-analyzer
  # from editors, or prebuilt tools you download).
  programs.nix-ld.enable = true;

  # Small QoL: no nano (we have nvim)
  programs.nano.enable = false;
}
