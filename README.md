# nixos-ft2000

This repository contains my NixOS configuration tailored for a home router device based on the FT2000/4 platform, featuring a customized mainline Linux kernel.

For detailed information, please refer to: https://darkyzhou.net/articles/compiling-nixos-for-ft2000

## Kernel Patches

- [**AOSC patches**](https://github.com/AOSC-Dev/aosc-os-abbs/tree/9ac6a143ea533c076ca90c6b3577359dd1682ab2/runtime-kernel/linux-kernel/autobuild/patches): Support for Phytium SoC, Phytium DWMAC, and related components.
- [**Phytium-Linux-Kernel patches**](https://gitee.com/phytium_embedded/phytium-linux-kernel): NOC devfreq, DMU devfreq, p-state driver, etc.
- [**XanMod patches**:](https://gitlab.com/xanmod/linux-patches/-/tree/master/linux-6.14.y-xanmod) BBRv3, fullcone NAT, xt_FLOWOFFLOAD, and more.
