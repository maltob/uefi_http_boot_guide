
# OS Setup
## Get base OS
1. Download a Windows install disk/media you would like to install.
    For home - Microsoft offers the Windows 11 ISO for download at https://www.microsoft.com/en-us/software-download/windows11
    For enterprise customers - your volume license portal can provide this.
2. Mount the ISO by double clicking on it
3. Copy the contents of the virtual disk drive to a folder you would like the clients to download from such as `C:\inetpub\wwwroot\windows` or  `/var/srv/windows`

## Add drivers if needed
1. See [Microsofts guide for adding drivers to an offline image.](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/add-and-remove-drivers-to-an-offline-windows-image?view=windows-11#add-driver-packages-to-an-offline-windows-image) use the "boot.wim" image for adding driver support to the installer wizard portion and "install.wim" for the OS that is installed to disk. Drivers may be needed for both.

# Paramters for DHCP
 - Boot File URL = `efi/boot/bootx64.efi`

# Notes - Files bootx64.efi tries to load:
Right column is whether it was on the ISO I was able to boot from as a reference of what may be needed.

 | file | on disk |
 | -- | -- |
 | /efi/boot/BCD | No |
 | /efi/Microsoft/Boot/BCD | Yes ✅ |
 | /efi/Microsoft/Boot/Policies/SbcpFlightToken.p7b | No |
 | /efi/Microsoft/Boot/SecureBootPolicy.p7b | No |
 | /efi/Microsoft/Boot/SiPolicy.p7b | No |
 | /efi/Microsoft/Boot/SkuSiPolicy.p7b | No |
 | /efi/Microsoft/Boot/WinSiPolicy.p7b | Yes ✅ |
 | /efi/Microsoft/Boot/ATPSiPolicy.p7b | No |
 | /efi/boot/en-US/bootx64.efi.MUI | No |
 | /sources/boot.wim | Yes ✅ |
 | /boot/boot.sdi | Yes ✅ |
 | /efi/Microsoft/Boot/Fonts/wgl4_boot.ttf | Yes ✅ |