#!/bin/bash
# Attempt to download a NeoForge installer and run it in server install mode.
# This script tries to scrape the NeoForged download page for an installer .jar link.
set -e
echo "Looking up NeoForge installer link on neoforged.net..."
# Try a few pages where installer links usually live
URLS=( "https://neoforged.net/" "https://neoforged.net/page/2/" )
found=""
for u in "${URLS[@]}"; do
  echo "Checking $u"
  link=$(curl -sL "$u" | grep -oP 'https?://[^"\']+installer\.jar' | head -n1 || true)
  if [ -n "$link" ]; then
    found="$link"
    break
  fi
done

if [ -z "$found" ]; then
  echo "Installer link not found automatically. Please download the NeoForge installer manually from https://neoforged.net and place it here as 'neoforge-installer.jar'."
  exit 1
fi

echo "Found installer: $found"
echo "Downloading..."
curl -L -o neoforge-installer.jar "$found"
chmod +x neoforge-installer.jar

echo "Running installer in server mode (headless)..."
# Many installers support --installServer or similar. If this fails, run without args interactively.
java -jar neoforge-installer.jar --installServer || {
  echo "Automatic server install failed. Try running: java -jar neoforge-installer.jar  and choose Install server / Server starter jar options."
  exit 2
}
echo "Installer finished. If it created a 'run.sh' or 'server.jar', run ./start.sh to start the server."
