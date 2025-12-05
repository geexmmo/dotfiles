#!/bin/bash

# Define the rclone mount command
RCLONE_COMMAND="/usr/bin/rclone mount gdrive: /home/geexmmo/googledrive --dir-cache-time 24h --poll-interval 15s --vfs-cache-mode full --vfs-cache-max-age 3d --vfs-cache-max-size 1G --buffer-size 64M --daemon --log-file /home/geexmmo/rclone.log --log-level INFO"

# Check if the rclone process for this specific mount is running
# pgrep -f searches the full command line for the mount path.
if pgrep -f "rclone" > /dev/null
then
    echo "rclone mount is already running."
else
    echo "rclone mount not running. Starting it now..."
    # Execute the rclone command
    eval "$RCLONE_COMMAND"

    if [ $? -eq 0 ]; then
        echo "rclone mount started successfully."
    else
        echo "Error starting rclone mount."
    fi
fi
