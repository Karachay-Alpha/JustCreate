# Deploying this modpack as a server on a VPS

This archive looks like a Minecraft modpack server folder (mods, config, server.properties).
Before starting the server on the VPS you typically need:

1. NeoForge server files (server.jar / run.sh). The modpack archive doesn't include the NeoForge server starter.
2. A working Java (Java 17 or Java 21 depending on NeoForge and mods). Install OpenJDK on the VPS.
3. Adequate RAM and swap configured for Minecraft server (e.g. 6GB+ for modded).
4. eula.txt with `eula=true` (present here).
5. start.sh — included. Make it executable: `chmod +x start.sh`.
6. Optionally: a systemd unit (provided as template) and backups.

Quick steps to deploy on the VPS (once you `scp` the archive and extract it):

```bash
# as the server user (not root ideally)
tar xf JustCreate_with_extras.tar
cd "Just Create" || cd JustCreate
chmod +x start.sh download-server.sh
# If NeoForge server files are missing, run:
./download-server.sh
# Then accept EULA (already set to true here), and start:
./start.sh
```

If the automatic installer download fails, download the NeoForge installer manually from https://neoforged.net and place it in the server folder as `neoforge-installer.jar`, then run the installer on the VPS and choose "Install server" + "Server starter jar".

Notes:
- The download script attempts to scrape neoforged.net for an installer link. If that fails, download manually.
- Adjust Java memory flags in `start.sh` according to your VPS RAM.
- Consider running the server under `screen` or `tmux` or via systemd for resilience.
