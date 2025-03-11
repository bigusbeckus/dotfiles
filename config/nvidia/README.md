# Nvidia Drivers
#### and how to get them working with Wayland and Optimus without the low FPS issue

> Spoiler alert: They still suck

## Fedora
1. Follow the Fedora docs to install the kmod drivers from the nonfree rpm repository
2. Copy `nvidia.conf` from this directory to `/etc/modprobe.d/nvidia.conf`
3. Copy over the `KWIN_DRM_DEVICES` environment variable from `environment` in this directory to `/etc/environment`
   > You may have to modify the `pci-xxxx\:xx\:xx.x-card` bits with the appropriate values for your device.
   > Run `lspci | egrep VGA` to list installed PCI graphics cards
