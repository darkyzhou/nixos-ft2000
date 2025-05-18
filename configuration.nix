{ pkgs }:
{
  system.stateVersion = "25.05";

  # Some FT-2000/4 boards are said to have quirks that might
  # lead to hardware failure when writing EFI variables.
  # Therefore we set the bootloader like this:
  boot.loader = {
    grub = {
      enable = true;
      efiSupport = true;
      efiInstallAsRemovable = true;
      device = "nodev";
    };
    efi.canTouchEfiVariables = false;
  };

  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.callPackage ./kernel { });

  boot.kernel.sysctl = {
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_notsent_lowat" = 131072;
  };

  hardware.enableRedistributableFirmware = true;

  time.timeZone = "Asia/Shanghai";

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    hostName = "raven";
    timeServers = [
      "cn.pool.ntp.org"
      "ntp.ntsc.ac.cn"
      "ntp.tencent.com"
    ];
  };

  users.users.root.initialPassword = "114514";

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    nano
    htop
    fastfetch
  ];

}
