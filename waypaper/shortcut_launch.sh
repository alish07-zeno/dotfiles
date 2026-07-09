#!/bin/bash

# Check if waypaper is running
if pgrep -x "waypaper" > /dev/null; then
    # If running, kill it
    pkill -x "waypaper"
else
    # If not running, launch it
    waypaper
fi
