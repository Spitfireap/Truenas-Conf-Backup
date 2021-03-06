# Truenas-Conf-Backup
 This is a small script to backup a configuration of a Truenas server
 
 ## Features:
 
- Save backup of your Truenas config by CLI.
- Be able to restore it through the GUI
- Automaticly send you the backup archive when changes are detected

## Instructions :

 ### Step 1 :
 - Configure emails through the GUI (System --> Email)
 ### Step 2 :
 - Clone this repository in the folder of your choice
 ### Step 3 :
 - Edit the file saveconf.sh to specify FROM address, and TO address. You can also change the subject and/or the body. Additionally, if you want to keep older backup, you can simple change SAVE="NO" to SAVE="YES" and your backups will be save in /path/to/the/script/backup/send/. 
 ### Step 4 :
 - On a shell `chmod +x path/to/the/repo/saveconf.sh`
 ### Step 5 : 
 - Add the job to cron (via the GUI or via CLI) :
    * Command : `path/to/the/repo/saveconf.sh`
    * Every : you can choose anything you want, every days, every month or even every minutes ! Config backup won't be kept if no changes are detected...

## Notes :
You **must** have a backup/send folder along with saveconf.sh for it to work. If you just clone the repo without changing anything, it should work flawlessly :).
Please also note that backup are send unencrypted, this can cause a security issue. I encourage you to encrypt your emails before sending them, see [zeyple](https://github.com/infertux/zeyple).
