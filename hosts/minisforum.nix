{ config, lib, pkgs, modulesPath, rust-overlay, ... }:

#
# Single-user headless workstation.
# Self-contained: no LDAP/SSSD, no comin, no secrets-in-repo (tailscale is
# authenticated manually post-install via `sudo tailscale up --auth-key=...`).
#
# Filesystem layout — preserved across reinstall; only root-crypt is reformatted:
#
#   /dev/nvme0n1p1  ESP (FAT32)    → /boot
#   /dev/nvme0n1p2  LUKS root-crypt → /      (ext4) ← reformatted on reinstall
#   /dev/nvme0n1p3  (unused)        → /recovery (optional)
#   /dev/nvme1n1p1  LUKS work-crypt → /work  (xfs)
#   /dev/nvme1n1p2  LUKS home-crypt → /home  (xfs) ← DO NOT FORMAT
#

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ../modules/packages.nix
    # ../modules/neovim        # TODO: nixvim schema drift; re-enable after rebase
  ];

  # ──────────────────────────────────────────────────────────────
  # Hardware / platform
  # ──────────────────────────────────────────────────────────────
  nixpkgs.hostPlatform = "x86_64-linux";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ rust-overlay.overlays.default ];

  boot.kernelModules = [ "kvm-amd" ];

  hardware = {
    cpu.amd.updateMicrocode =
      lib.mkDefault config.hardware.enableRedistributableFirmware;
    enableRedistributableFirmware = true;
    # Keep basic graphics — useful even on a headless box for VA-API/compute
    graphics.enable = true;
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";

  # ──────────────────────────────────────────────────────────────
  # Boot
  # ──────────────────────────────────────────────────────────────
  boot.loader = {
    systemd-boot.enable = true;           # simpler than GRUB; headless UI
    systemd-boot.configurationLimit = 10;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.initrd = {
    systemd.enable = true;
    availableKernelModules = [
      "nvme" "xhci_pci" "ahci" "usbhid" "usb_storage" "sd_mod"
    ];

    # LUKS unlocking. Prompted for passphrase at boot (3 prompts, or use a
    # keyfile — see NixOS wiki on `luks.devices.<name>.keyFile`).
    luks.devices = {
      "root-crypt" = {
        device = "/dev/disk/by-uuid/4ed5b875-a800-4b82-9bfe-fd7ce9110394";
        allowDiscards = true;
      };
      "home-crypt" = {
        device = "/dev/disk/by-uuid/8e25df3d-3810-4b4b-9712-01f190d821d4";
        allowDiscards = true;
      };
      "work-crypt" = {
        device = "/dev/disk/by-uuid/0710976c-2faa-4a40-ac7f-0eb0820e8d56";
        allowDiscards = true;
      };
    };
  };

  # ──────────────────────────────────────────────────────────────
  # Filesystems
  #
  # root's inner FS UUID will change after mkfs.ext4 on reinstall —
  # update the UUID here before first boot, or use -L NIXOS_ROOT during
  # mkfs and reference by-label instead.
  # ──────────────────────────────────────────────────────────────
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_ROOT";   # label-first for simplicity
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/EFC4-EBF9";
      fsType = "vfat";
    };
    "/home" = {
      device = "/dev/disk/by-uuid/31d7e10a-b705-49e9-89b9-c7d4f00bbda1";
      fsType = "xfs";
    };
    "/work" = {
      device = "/dev/disk/by-uuid/45ece71f-7493-4543-8463-1376c5779355";
      fsType = "xfs";
    };
  };

  swapDevices = [ ];

  # ──────────────────────────────────────────────────────────────
  # Networking
  # ──────────────────────────────────────────────────────────────
  networking = {
    hostName = "minisforum";
    networkmanager.enable = true;
    # Tailscale is on the tailnet interface; only SSH exposed on the LAN.
    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      # Trust the tailscale interface
      trustedInterfaces = [ "tailscale0" ];
    };
  };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "client";
    # Authenticate post-install:
    #   sudo tailscale up --auth-key=tskey-auth-...
    # Generate a key at https://login.tailscale.com/admin/settings/keys
  };

  # ──────────────────────────────────────────────────────────────
  # SSH (headless box — this is how you get in)
  # ──────────────────────────────────────────────────────────────
  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  # ──────────────────────────────────────────────────────────────
  # Users — single user, like macOS
  # ──────────────────────────────────────────────────────────────
  users.mutableUsers = true;   # allow `passwd` to change the password later

  users.users.edmund = {
    isNormalUser = true;
    description = "Edmund Cape";
    home = "/home/edmund";
    shell = pkgs.nushell;
    extraGroups = [ "wheel" "networkmanager" "docker" "video" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKU5mhYXhZxIraRw6HxApHFRJwzQwvFmUv9M5hkwYGOX edmundsecho-personal@nixos"
    ];
    initialPassword = "changeme";   # run `passwd` on first login
  };

  security.sudo.wheelNeedsPassword = false;   # matches your current setup

  # ──────────────────────────────────────────────────────────────
  # Docker
  # ──────────────────────────────────────────────────────────────
  virtualisation.docker.enable = true;

  # ──────────────────────────────────────────────────────────────
  # Time / locale / nix settings
  # ──────────────────────────────────────────────────────────────
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # ──────────────────────────────────────────────────────────────
  # State version
  # ──────────────────────────────────────────────────────────────
  system.stateVersion = "25.05";
}
