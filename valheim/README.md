# Valheim

Dedicated server for Valheim




## Environment variables

- `VH_SERVER_NAME`: Sets the name that will be visible in the server list
- `VH_SERVER_PASSWORD`: The server password
- `VH_WORLD`: creates or loads a world with the specified name.
- `VH_PUBLIC`: Visibility of the server, if set to `1` the server will be visible in the server browser
- `PUID`: runs the valheim process and sets the `/data` volume permissions with this user id.
- `PGID`: runs the valheim process and sets the `/data` volume permission with this group id

## Ports

- `2456/udp`: Valheim game port
- `2457/udp`: Steam query port

## Volumes

- `/data`: game save data will be stored here

Special Files. Add Steam IDs (one per line) to set the desired roles:

- `/data/adminlist.txt`
- `/data/bannedlist.txt`
- `/data/permittedlist.txt`
    > NOTE: Adding a person to the permitted list will auto-ban anyone who tries to join that is not added to the permitted list
