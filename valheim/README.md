# Valheim

Dedicated server for Valheim

Environment variables

- `VH_SERVER_NAME`: Sets the name that will be visible in the server list
- `VH_WORLD`: creates or loads a world with the specified name.
- `VH_PASSWORD`: The server password
- `VH_PUBLIC`: Visibility of the server, if set the server will be visible in the server browser

Ports

- `2456/tcp+udp`: Valheim game port
- `2457/tcp+udp`: Steam query port

Volume

- `/data`: game save data will be stored here

Special Files. Add Steam IDs (one per line) to set the desired roles:

- `/data/adminlist.txt`
- `/data/bannedlist.txt`
- `/data/permittedlist.txt`
    > NOTE: Adding a person to the permitted list will ban everyone else in the server
