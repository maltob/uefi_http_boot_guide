# uefi_http_boot_guide
Guide and resources for UEFI level HTTP booting

## Quick setup info:
 * Set boot file (Option 67) to the http:// address of the efi binary such as `http://192.168.3.10/boot/boot.efi`
 * Set the vendor class (Option 60) to `HTTPClient`

## Guide:
1. Acquire and setup OS you would like to boot
   [Windows Install Media] - TODO
   [FFU] - TODO
   [Custom Windows] - TODO
   [Debian] - TODO
   [iPXE] - TODO
1. Setup web server
   [Caddy] - TODO
   [Python]
1. Configure DHCP server or proxy
   [Generic Setup Assistance]  - TODO
   [TFTPD64 Setup Guide](pages/TFTPD64.md)
   [Windows Server Setup Guide] - TODO

1. Additional Resources
   [Troubleshooting with Wireshark] - TODO
   [HTTPs] - TODO

