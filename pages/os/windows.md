
# OS Setup
## Get base OS
1. Download a Windows install disk/media you would like to install.
    For home - Microsoft offers the Windows 11 ISO for download at https://www.microsoft.com/en-us/software-download/windows11
    For enterprise customers - your volume license portal can provide this.
2. Mount the ISO by double clicking on it
3. Copy the ISO to a folder you would like the clients to download from such as `C:\inetpub\wwwroot\windows` or  `/var/srv/windows`

## Add drivers if needed
1. TODO

# Paramters for DHCP
 - Boot File URL = `efi/boot/bootx64.efi`