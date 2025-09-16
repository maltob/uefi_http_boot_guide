# uefi_http_boot_guide
Guide and resources for UEFI level HTTP booting

## Quick setup info:
 * Set boot file (Option 67) to the http:// address of the efi binary such as `http://192.168.3.10/boot/boot.efi`
 * Set the vendor class (Option 60) to `HTTPClient`


Below are quick reference for the boot files, the full guides have more information.

| OS | File |
| -- | -- |
| Windows | efi/boot/bootx64.efi |
| | |

# Guide:
1. Acquire and setup OS you would like to boot

   [Windows Install Media](pages/os/windows.md)


1. Setup web server

   [Caddy](pages/web/caddy.md) - Preferred

   [Python](pages/web/python.md)
1. Configure DHCP server or proxy

   [Generic Setup Assistance]  - TODO

   [TFTPD64 Setup Guide](pages/TFTPD64.md)

   [Windows Server Setup Guide] - TODO

1. Additional Resources

   [Troubleshooting with Wireshark] - TODO

   [HTTPs] - TODO

