#!/bin/bash

# Kill any existing instances of xidlehook
killall xidlehook

# Start a new instance of xidlehook with your desired configuration
exec xidlehook \
  --not-when-fullscreen \
  --not-when-audio \
  --timer 160 'exec xset dpms force off' 'exec xset dpms force on' \
  --timer 300 'exec xsecurelock' ''
