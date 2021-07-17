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
 - On a shell `chmod +x path/to/the/repo/saveconf.sh`
 ### Step 4 : 
 - Add the job to cron (via the GUI or via CLI) :
    * Command : `path/to/the/repo/saveconf.sh`
    * Every : you can choose anything you want, every days, every month or even every minutes ! Config backup won't be kept if no changes are detected...

## Notes :
You **must** have a backup/send folder along with saveconf.sh for it to work. If you just clone the repo without changing anything, it should work flawlessly :).
