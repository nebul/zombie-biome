#!/bin/bash

# Check if LÖVE is installed
if ! command -v love &> /dev/null
then
    echo "LÖVE is not installed. Please install it to run this game."
    echo "You can download it from https://love2d.org"
    exit 1
fi

# Run the game
love .

# Check if the game exited with an error
if [ $? -ne 0 ]; then
    echo "The game exited with an error. Press any key to close this window."
    read -n 1 -s -r
fi