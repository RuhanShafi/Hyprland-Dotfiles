<div align="center">
    <h1>【 Ruhan Shafi's Hyprland dotfiles 】</h1>
    <h3></h3>
</div>


## Nvidia Guide (Credit Goes to Gl00ria):

<details>
<summary>Packages Required</summary>

| Package Name                                                                            | Description                                        | Package Manager |
| :--------------------------------------------------------------------------------------:| :-------------------------------------------------:| :-------------: |
| [nvidia](https://archlinux.org/packages/extra/x86_64/nvidia/)                           | driver                                             | Pacman          |
| [ nvidia-utils ](https://archlinux.org/packages/extra/x86_64/nvidia-utils/)             | drivers Utils                                      | Pacman          |
| [ nvidia-prime ](https://archlinux.org/packages/extra/any/nvidia-prime/)                | nvidia offload                                     | Pacman          |
| [libva-nvidia-driver](https://archlinux.org/packages/extra/x86_64/libva-nvidia-driver/) | VA-API implementation that uses NVDEC as a backend | Pacman          |

  <br>

</details>

<details>
<summary>Configurations to enable Nvidia Support</summary>

    1. Add `nvidia_drm.modeset=1` to `GRUB_CMDLINE_LINUX_DEFAULT=` in `/etc/default/grub`
    2. Run `sudo grub-mkconfig -o /boot/grub/grub.cfg`
    3.  Add `nvidia nvidia_modeset nvidia_uvm nvidia_drm` to `/etc/mkinitcpio.conf` then Generate new image: `sudo mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img`
    4. Add/create the following: `options nvidia-drm modeset=1` in `/etc/modprobe.d/nvidia.conf`
   <br> 
</details>

# TODO
* Configure Matugen
* Quickshell
  - Bar
