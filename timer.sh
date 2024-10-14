#!/bin/bash

# Accept minutes as input
minutes=$1

# Calculate total time in seconds
total_seconds=$((minutes * 60))

# Countdown loop
for ((i=total_seconds; i>=0; i--)); do
    # Calculate the minutes and seconds remaining
    min=$((i / 60))
    sec=$((i % 60))
    
    # Display the time in m:ss format
    printf "\r%02d:%02d" $min $sec
    
    # Sleep for 1 second
    sleep 1
done

# After countdown, display "Time's up!" and play a sound
echo -e "\nTime's up!"
afplay /System/Library/Sounds/Glass.aiff

# Show a modal dialog that requires user interaction
osascript -e 'tell application "System Events" to display dialog "Time is up! You had set a timer for '"$minutes"' minute(s)." buttons {"OK"} default button 1 with title "Timer Finished!" giving up after 3600 with icon caution'


