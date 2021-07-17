#!/bin/bash
#Small script to save Truenas config (tested on 12.2.U3) and send it to a specified email address
#Created by Spitap

#NOTE : You must have set email option on your GUI
#NOTE : This script must be in the same directory as backup/ and backup should contain a send/ folder

#------------------SETUP------------------
FROM="from@emailaddress.com"
TO="to@emailaddress.com"
SUBJECT="Last Truenas backup"
BODY="Hi, this is last backup of Truenas config file.
Backup date is: $(date)"
#If you want to keep backup in the send folder, change SAVE="NO" to SAVE="YES"
SAVE="NO"

#-----------------SCRIPT------------------
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

send_backup () {
        cd $SCRIPT_DIR/backup/send
        BOUND="SJAAWB7A0HWGP0KBJ99W7"
        (
        echo "From:"$FROM;
        echo "To:"$TO;
        echo "Subject:"$SUBJECT;
        echo "MIME-Version: 1.0";
        echo "Content-Type:multipart/mixed; boundary=\"$BOUND\"";

        echo "--$BOUND";
        echo "Content-Type: text/html; charset=\"UTF-8\"";
        echo "Content-Transfer-Encoding: 7bit";
        echo "Content-Disposition: inline";
        echo "";
        echo "$BODY";

        echo "--$BOUND";
        echo "Content-Type: application/x-tar";
        echo "Content-Transfer-Encoding: base64";
        echo "Content-Disposition: attachment; filename=\"$FILE_NAME\"";
        base64 "$FILE_NAME"

        echo "--$BOUND";
        ) | sendmail -t
        if [ "$SAVE" = "NO" ];then
                rm *
        fi
}


cd /data
tar -cvf $SCRIPT_DIR/backup/lastback.tar freenas-v1.db pwenc_secret

cd $SCRIPT_DIR/backup

LAST_HASH=$(sha256 backup.tar | awk '{print $4}')
NEW_HASH=$(sha256 lastback.tar | awk '{print $4}')

echo "Previous backup hash is $LAST_HASH"
echo "New backup hash is $NEW_HASH"

if [ "$LAST_HASH" = "$NEW_HASH" ];then
        echo "No changes since last time"
        echo "Deleting new backup and exiting"
        rm lastback.tar
else
        echo "Changes detected !"
        echo "Replacing old backup by the new one"
        mv lastback.tar backup.tar
        FILE_NAME="freenas-$(cat /etc/version | awk '{print $1}')-$(date +%Y%m%d%H%M)00.tar"
        echo "Copying new backup to send folder"
        cp backup.tar send/"$FILE_NAME"
        echo "Sending new backup to $TO"
        send_backup
        sleep 5
        echo "Sent!"
fi
