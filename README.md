# nixos-minisforum

Headless NixOS workstation config for my Minisforum mini PC. Single user,
no LDAP/SSSD, no GitOps — just a `nixos-rebuild switch` when you want to
change something.

## Layout

```
flake.nix                    3 inputs: nixpkgs, nixvim, rust-overlay
hosts/minisforum.nix         boot / LUKS / fs / user / ssh / tailscale / docker
modules/
  packages.nix               systemPackages, shells, starship, nix-ld
  neovim/                    lifted from ~/.hewnix-ext, self-contained
```

## Disk layout (preserved across reinstall)

```
nvme0n1 (system drive)
  ├─ p1 EFI           → /boot         (FAT32)
  ├─ p2 LUKS → root-crypt → /         (ext4)  ← REFORMATTED on reinstall
  └─ p3 recovery      → /recovery     (FAT32)

nvme1n1 (data drive)
  ├─ p1 LUKS → work-crypt → /work     (xfs)   ← preserved
  └─ p2 LUKS → home-crypt → /home     (xfs)   ← preserved
```

LUKS UUIDs are hardcoded in `hosts/minisforum.nix`. The inner FS UUID of
`/` will change after reformat; reference is by label `NIXOS_ROOT` so just
remember to `mkfs.ext4 -L NIXOS_ROOT /dev/mapper/root-crypt` during install.

## Installing

### Prerequisites

- NixOS 25.05 installer USB ([download](https://nixos.org/download/))
- LUKS passphrases for `home-crypt` and `work-crypt` (don't lose these)
- Tailscale auth key — generate at https://login.tailscale.com/admin/settings/keys

### Steps

1. Boot from installer USB.

2. In the installer shell:

   ```bash
   # Unlock home and work without formatting (verify passphrases work before
   # touching root)
   cryptsetup open /dev/nvme1n1p1 work-crypt   # passphrase
   cryptsetup open /dev/nvme1n1p2 home-crypt   # passphrase

   # Format ROOT ONLY
   cryptsetup luksFormat /dev/nvme0n1p2        # new passphrase
   cryptsetup open /dev/nvme0n1p2 root-crypt
   mkfs.ext4 -L NIXOS_ROOT /dev/mapper/root-crypt

   # Mount
   mount /dev/mapper/root-crypt /mnt
   mkdir -p /mnt/boot /mnt/home /mnt/work
   mount /dev/nvme0n1p1  /mnt/boot
   mount /dev/mapper/home-crypt /mnt/home
   mount /dev/mapper/work-crypt /mnt/work
   ```

3. If `/dev/nvme0n1p2` got a new UUID from `luksFormat`, update the
   `root-crypt.device` line in `hosts/minisforum.nix` before installing.
   Check with `blkid /dev/nvme0n1p2`.

4. Install:

   ```bash
   nixos-install --flake github:EdmundsEcho/nixos-minisforum#minisforum
   # or, if offline, from a local clone:
   # nixos-install --flake /mnt/home/edmund/nixos-minisforum#minisforum
   ```

5. Reboot. First boot prompts for LUKS passphrases (3 of them — root, home,
   work). Then log in as `edmund` / `changeme`, immediately `passwd`.

6. Bring the box back onto Tailscale:

   ```bash
   sudo tailscale up --auth-key=tskey-auth-...
   ```

## Rebuilding after edits

```bash
cd ~/nixos-minisforum            # or wherever you cloned it
sudo nixos-rebuild switch --flake .#minisforum
```

## What's deliberately missing (compared to hewnix)

- No `comin` / GitOps auto-deploy — manual rebuilds
- No SSSD / LDAP — single local user
- No `agenix` — tailscale auth done manually
- No `lanzaboote` — plain systemd-boot
- No `disko` — `fileSystems.*` references existing UUIDs directly
- No `code-server` / `rport` / `aws-mfa` — not needed on a personal headless box

Add any of them back if you miss them; easier than carrying the whole
stack from day one.
