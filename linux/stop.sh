#!/bin/bash
# Skywall stop script
# Stops the Skywall Flask server

pkill -f "Skywall" 2>/dev/null && echo "Skywall stopped." || echo "Skywall is not running."
