# Minecraft

Dedicated server for Minecraft

Drop your `server.properties` file into `/configs`.

```
docker run -it \
    -e PUID=1000 \
    -e PGID=1000 \
    -v $PWD/data:/data \
    -p 25565:25565 \
    gamenight/minecraft:1.18.1
```


## Environment variables

- `JVM_MEMORY_SIZE=1024m` the memory allocation for the JVM
- `PUID`: runs the minecraft process and sets the `/data` volume permissions with this user id.
- `PGID`: runs the minecraft process and sets the `/data` volume permission with this group id

## Ports

- `25565/tcp`: Game port
- `25575/tcp`: RCON

## Volume

- `/configs/server.properties`: Server properties file, see: https://minecraft.gamepedia.com/Tutorials/Setting_up_a_server#Start_the_Minecraft_server. This file gets copied to `/data/server.properties` at startup
- `/data`: Game saves, logs, plugins etc
