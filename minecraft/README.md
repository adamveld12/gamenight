# Minecraft

Dedicated server for Minecraft



## Environment variables

- `JVM_MEMORY_SIZE=1024m` the memory allocation for the JVM

## Ports

- `25565/tcp`: Game port
- `25575/tcp`: RCON

## Volumes

- `/data/configs/server.properties`: Server properties file, see: https://minecraft.gamepedia.com/Tutorials/Setting_up_a_server#Start_the_Minecraft_server
