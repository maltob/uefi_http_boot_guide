## Install
1. Install python [https://www.python.org/downloads/](https://www.python.org/downloads/) if needed
2. Open a terminal/command prompt window
3. Use "cd" to change directory to the serve root/where the files the machines will download are.
   
    Ex: `cd C:\Debian\13\` or `cd /var/srv/debian/13/`
4. Run the python webserver module with `python -m http.server 80`.

   You can change the "80" to a different port number above 1024 if you want to run the webserver as non-admin. If you do so you'll need to remember the port number for later.
5. Verify you can access it at http://HOSTNAMEORIP such as "http://192.168.0.1".

## Notes
This will show directory listing of the files in the directory and allow downloading of all files.

This server is very basic - boot from GRUB for linux distros will not work with it.
