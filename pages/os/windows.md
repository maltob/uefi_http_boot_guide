
# OS Setup
## Get base OS
1. Download a Windows install disk/media you would like to install.
    For home - Microsoft offers the Windows 11 ISO for download at https://www.microsoft.com/en-us/software-download/windows11
    For enterprise customers - your volume license portal can provide this.
2. Mount the ISO by double clicking on it
3. Copy the contents of the virtual disk drive to a folder you would like the clients to download from such as `C:\inetpub\wwwroot\windows` or  `/var/srv/windows`

# Optional
## Add drivers if needed
1. See [Microsofts guide for adding drivers to an offline image.](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/add-and-remove-drivers-to-an-offline-windows-image?view=windows-11#add-driver-packages-to-an-offline-windows-image) use the "boot.wim" image for adding driver support to the installer wizard portion and "install.wim" for the OS that is installed to disk. Drivers may be needed for both.

## Enable boot menu
The below will need a windows machine. This will allow running the Microsoft memory diagnostic or booting multiple WIMs.
1. Open command prompt as admin
1. `cd` to the `efi\microsoft\boot` directory in the folder you copied the files to
1. Run the below command, you should see a "The operation completed successfully." message.
`bcdedit /set "{bootmgr}" displaybootmenu yes /store bcd`

### Adding another entry
1. Copy over another Windows PE WIM to the ISO folder you copied. For this example we'll call it boot_tools.wim and place it in the "sources" folder.

1. Open a command prompt as admin and `cd` to the `efi\microsoft\boot` directory

1. 


# Paramters for DHCP
 - Boot File URL = `efi/boot/bootx64.efi`

# Notes - Files bootx64.efi tries to load:
Right column is whether it was on the ISO I was able to boot from as a reference of what may be needed. The items with a 🔵 exist on the reference ISO but are not required to boot.

Without the fonts you will not be able to see the boot.wim filename as it loads.

 | file | on disk |
 | -- | -- |
 | /efi/boot/BCD | No |
 | /efi/Microsoft/Boot/BCD | Yes ✅ |
 | /efi/Microsoft/Boot/Policies/SbcpFlightToken.p7b | No |
 | /efi/Microsoft/Boot/SecureBootPolicy.p7b | No |
 | /efi/Microsoft/Boot/SiPolicy.p7b | No |
 | /efi/Microsoft/Boot/SkuSiPolicy.p7b | No |
 | /efi/Microsoft/Boot/WinSiPolicy.p7b | Yes 🔵|
 | /efi/Microsoft/Boot/ATPSiPolicy.p7b | No |
 | /efi/boot/en-US/bootx64.efi.MUI | No |
 | /sources/boot.wim | Yes ✅ |
 | /boot/boot.sdi | Yes ✅ |
 | /efi/Microsoft/Boot/Fonts/wgl4_boot.ttf | Yes 🔵 |
| /efi/Microsoft/Boot/fonts/segoe_slboot.ttf | Yes 🔵 |
| /efi/Microsoft/Boot/fonts/segmono_boot.ttf | Yes 🔵 |
| /efi/Microsoft/Boot/resources/bootres.dll | Yes 🔵 |