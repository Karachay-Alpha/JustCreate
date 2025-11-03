#!/bin/bash
# Start script for the Minecraft NeoForge server.
# Place this in the server root (same folder as 'mods', 'config', etc.).
set -e
RUNDIR="$(dirname "$0")"
cd "$RUNDIR"

# Prefer server.jar (ServerStarterJar) if present
if [ -f server.jar ]; then
  exec java -Xmx6G -Xms2G -jar server.jar nogui
fi

# If there's a run.sh provided by NeoForge installer, use it
if [ -f run.sh ]; then
  chmod +x run.sh
  exec ./run.sh
fi

# Fallback: try to run a known launcher jar
if [ -f neoforge-installer.jar ]; then
  echo "No server.jar or run.sh found. Try running the installer first: java -jar neoforge-installer.jar --installServer"
  exit 1
fi

echo "No server.jar or run.sh found. Use the included download-server.sh to fetch and install the server."
exit 2
