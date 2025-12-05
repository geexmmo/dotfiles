    #!/bin/bash

    # Exit if no argument is given
    if [ -z "$1" ]; then
        exit 1
    fi

    case "$1" in
        Shutdown)
            systemctl poweroff
            ;;
        Reboot)
            systemctl reboot
            ;;
        Suspend)
            systemctl suspend
            ;;
        Logout)
            i3-msg exit
            ;;
        Lock)
            i3lock-fancy # Or your preferred lock screen command
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
