#!/bin/bash

NOTIFICATION_TIMEOUT_MS=1500
# --- Function to get human-readable description using pactl ---
get_sink_description_pactl() {
    local sink_name=$1
    # Use pactl list sinks and awk to find the section for the specific sink name
    # and extract the "Description" field.
    pactl list sinks | awk '/Name: '"$sink_name"'/{flag=1;next}/^$/{flag=0}flag' | 
    grep "Description:" | 
    awk '{$1=""; print $0}' | # Remove the "Description:" label
    sed 's/^[ \t]*//;s/[ \t]*$//' # Trim leading/trailing whitespace
}

# --- Main Toggle Logic ---

# Get a list of all sinks (names only)
sinks=$(pactl list short sinks | cut -f2)
current_default=$(pactl info | grep 'Default Sink' | cut -d' ' -f3)
next_sink=""

# Determine the next sink name in the list
while IFS= read -r name; do
  if [ "$name" = "$current_default" ]; then
    next_sink=$(echo "$sinks" | grep -A1 --no-group-separator "$name" | tail -n1)
    if [ -z "$next_sink" ] || [ "$next_sink" = "$name" ]; then
      next_sink=$(echo "$sinks" | head -n1)
    fi
    break
  fi
done <<< "$sinks"

# If a next sink was found, switch to it and notify
if [ -n "$next_sink" ]; then
  pactl set-default-sink "$next_sink"
  
  # Move all existing audio streams to the new default sink
  for input in $(pactl list short sink-inputs | cut -f1); do
    pactl move-sink-input "$input" "$next_sink"
  done
  
  # Get the descriptive name of the *new* default sink
  # The system may need a moment to register the change
  sleep 0.1 
  description=$(get_sink_description_pactl "$next_sink")
  
  # Send the Dunst notification with the correct description
  notify-send -t "$NOTIFICATION_TIMEOUT_MS" -i audio-card "Audio Output Switched To:" "$description"
fi
