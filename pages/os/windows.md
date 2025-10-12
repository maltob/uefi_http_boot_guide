# Parameters for DHCP
 - Boot File URL = `efi/boot/bootx64.efi`

# OS Setup
## Get base OS
1. Download a Windows install disk/media you would like to install.

    For home - Microsoft offers the Windows 11 ISO for download at https://www.microsoft.com/en-us/software-download/windows11

    For enterprise customers - your volume license portal can provide this.
2. Mount the ISO by double clicking on it
3. Copy the contents of the virtual disk drive to a folder you would like the clients to download from such as `C:\inetpub\wwwroot\windows` or  `/var/srv/windows`. I'll refer to this as the serve root in the guide.
4. Add a way to have Windows PE download the image - I've made [https://github.com/maltob/http_imager_ui](https://github.com/maltob/http_imager_ui) for this purpose. With the default tooling Windows will think it is missing a driver.

# Optional
## Add drivers if needed
1. See [Microsofts guide for adding drivers to an offline image.](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/add-and-remove-drivers-to-an-offline-windows-image?view=windows-11#add-driver-packages-to-an-offline-windows-image) use the "boot.wim" image for adding driver support to the installer wizard portion and "install.wim" for the OS that is installed to disk. Drivers may be needed for both.



## Enable boot menu
The below will need a windows machine. This will allow running the Microsoft memory diagnostic or booting multiple WIMs.
1. Open command prompt as admin
1. `cd` to the `efi\microsoft\boot` directory in the serve root.
1. Run the below command, you should see a "The operation completed successfully." message.
`bcdedit /set "{bootmgr}" displaybootmenu yes /store bcd`

### Adding another entry/bootable WIM
1. Copy over another Windows PE WIM to the serve root. For this example I'll call the file "boot_tools.wim" and place it in the "sources" folder.

1. Open a command prompt as admin and `cd` to the `efi\microsoft\boot` directory

1. Run the below run copy the default entry to make a new entry. This will automatically append to the bottom of the boot menu. 

    `bcdedit /copy "{default}" /store bcd /d "Tools"`

    You should see something like the below with a GUID. This is the entry GUID for the new entry.
    `The entry was successfully copied to {73e78789-91c4-11f0-968d-c80a9a5f9703}.`

1. Get the RAM Disk entry by running the below and getting the "identifier" GUID with the { } around it where it says "ramdisksdipath"

    `bcdedit /enum ALL /store bcd`

    Example from test media - ID would be {7619dcc8-fafe-11d9-b411-000476eba25f}

>    Device options
>
> \------------
>
>   identifier              {7619dcc8-fafe-11d9-b411-000476eba25f}
>
>    ramdisksdidevice        boot
>
>    ramdisksdipath          \boot\boot.sdi
    
1. Edit the entry to point to a new file with the below two commands. Replace the boot_tools.wim with your WIM path and the first GUID with the new entry GUID. The last GUID should remain the RAM disk one.

    `bcdedit /set "{73e78789-91c4-11f0-968d-c80a9a5f9703}" device "ramdisk=[boot]\sources\boot_tools.wim,{7619dcc9-fafe-11d9-b411-000476eba25f}" /store bcd`

    `bcdedit /set "{73e78789-91c4-11f0-968d-c80a9a5f9703}" osdevice "ramdisk=[boot]\sources\boot_tools.wim,{7619dcc9-fafe-11d9-b411-000476eba25f}" /store bcd`




## Booting over Wifi
Some systems support UEFI boot over Wifi. You'll need to add Wifi to the boot.wim to enable downloading over wifi. 

We'll follow [this guide](https://knowledge.broadcom.com/external/article/268140/support-for-wifi-network-adapters-in-win.html) to use the WinRE wim to add wifi. Bootmgr supports using the UEFI network out of the box for networking.

1. Create the wifi profile for your wifi, on a Windows PC you can export this with the below command, switching SSIDHERE with the wireless you want to connect to. It should be WPA2 Personal or Open.

`netsh wlan export profile SSIDHERE folder=. key=clear` 

 Alternatively you can use a generator like [Wi-Fi Profile Generator](https://daduckmsft.github.io/WiFiProfileGenerator/android.html#) and save it as a .xml file

2. Copy over the WinRE.wim from C:\Windows\system32\Recovery\winre.wim to your sources folder in your serve root.
3. Open terminal as admin and mount the WinRE.wim so we can add the drivers. Below is an example
```
cd C:\inetpub\wwwroot\windows\
mkdir winre
Mount-WindowsImage -Path winre -ImagePath winre.wim -Index 1
```
4. Copy over additional netsh dll's from your system - we'll need dmcmnutils.dll, mdmpostprocessevaluator.dll and mdmregistration.dll.

```
Copy-Item C:\Windows\system32\dmcmnutils.dll winre\windows\system32\ -Force
Copy-Item C:\Windows\system32\mdmpostprocessevaluator.dll winre\windows\system32\ -Force
Copy-Item C:\Windows\system32\mdmregistration.dll winre\windows\system32\ -Force
```
5. Delete / overwrite the winre\windows\system32\winpeshl.ini file so it doesn't launch recovery
5. Add wifi drivers for the needed wifi cards following [Microsofts guide](https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/add-and-remove-drivers-to-an-offline-windows-image?view=windows-11#add-driver-packages-to-an-offline-windows-image). Example below where I've saved several drivers to 'C:\temp\drivers'
`dism /Image:winre /Add-Driver /Driver:C:\Temp\drivers /Recurse`
5. Copy your wifi profile XML to the WinRE mount. I save it as wifi.xml in the root
`copy wifi.xml winre/wifi.xml`
5. Add a custom startup script that connects to the wifi. 
You can replace startnet.cmd with a modified version of the [sample one](windows/sample_network_wait.bat). Replace "SSIDHERE" with your wifi network name.
`copy startnet_wifi.cmd winre\Windows\system32\startnet.cmd`
5. Unmount the WIM and save
`Dismount-WindowsImage -Path winre -Save`
5. Copy it to your serve directory and either add it to the BCD as an additional option or overwrite your previous WIM. Please note this will be larger than the base WIM.

# Notes - Files bootx64.efi tries to load:
Right column is whether it was on the ISO I was able to boot from as a reference of what may be needed. The items with a ✅ are needed to boot. The items with a 🔵 exist on the reference ISO but are not required to boot.

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