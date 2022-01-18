# Factorio

Dedicated server for Factorio

If no save file is found, a new one is generated at startup.


## Environment variables

- `SAVE_FILE`: Specify the name of the save file in the `/data` directory. Defaults to `world`
- `PUID`: runs the valheim process and sets the `/data,/configs` volumes permissions with this user id.
- `PGID`: runs the valheim process and sets the `/data,/configs` volumes permission with this group id

## Ports

- `34197/udp`: Game port
- `34198/udp`: RCON

## Volumes

- `/data`: game saves
- `/configs`: https://wiki.factorio.com/Multiplayer
	- `map-gen-settings.json`
	- `map-settings.json`
	- `server-settings.json`
