# Minecraft

Dedicated server for Minecraft.
Uses [Paper MC](https://docs.papermc.io/paper/) and some custom flags for performance

Drop your `server.properties` file into `/configs`.

```
docker run -it \
    -v $PWD/data:/data \
    -p 25565:25565 \
    gamenight/minecraft:1.18.1
```


## Environment variables

- `JVM_MEMORY_SIZE=1024m` the memory allocation for the JVM

## Ports

- `25565/tcp`: Game port
- `25575/tcp`: RCON

## Volume

- `/data`: Game saves, logs, plugins etc
- `/configs`: This get copied to the correct place on boot. View the complete docs for paper configs @ https://docs.papermc.io/paper/reference/configuration/.
    - `server.properties`
    - `paper-global.yml`
    - `paper-world-defaults.yml`
    - `spigot.yml`
