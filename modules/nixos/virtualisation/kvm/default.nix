{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.plusultra; let
  cfg = config.plusultra.virtualisation.kvm;
  user = config.plusultra.user;
in {
  options.plusultra.virtualisation.kvm = with types; {
    enable = mkBoolOpt false "Whether or not to enable KVM virtualisation.";
    vfioIds =
      mkOpt (listOf str) []
      "The hardware IDs to pass through to a virtual machine.";
    platform =
      mkOpt (enum ["amd" "intel"]) "amd"
      "Which CPU platform the machine is using.";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelModules = [
        # "kvm-${cfg.platform}"
        "vfio_virqfd"
        "vfio_pci"
        "vfio_iommu_type1"
        "vfio"
      ];
      kernelParams = [
        "${cfg.platform}_iommu=on"
        # "${cfg.platform}_iommu=pt"
        "kvm.ignore_msrs=1"
        "vfio-pci.ids=${concatStringsSep "," cfg.vfioIds}"
      ];
      extraModprobeConfig =
        optionalString (length cfg.vfioIds > 0)
        ''
          softdep amdgpu pre: vfio vfio-pci
          options vfio-pci ids=${concatStringsSep "," cfg.vfioIds}
        '';
    };

    # systemd.tmpfiles.rules = [
      # "f /dev/shm/looking-glass 0660 ${user.name} qemu-libvirtd -"
      # "f /dev/shm/scream 0660 ${user.name} qemu-libvirtd -"
    # ];

    environment.systemPackages = with pkgs; [
      virt-manager
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        extraConfig = ''
          user="${user.name}"
        '';

        onBoot = "ignore";
        onShutdown = "shutdown";

        qemu = {
          package = pkgs.qemu_kvm;
          ovmf = enabled;
          swtpm = enabled;
          verbatimConfig = ''
            namespaces = []
            user = "+${builtins.toString config.users.users.${user.name}.uid}"
          '';
        };
      };
    };

    plusultra = {
      user = {extraGroups = ["qemu-libvirtd" "libvirtd" "disk"];};

      # apps = {looking-glass-client = enabled;};
    };
  };
}
