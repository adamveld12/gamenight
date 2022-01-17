# Game Night

[![Master Build Releases](https://github.com/adamveld12/gamenight/actions/workflows/master_build_release.yml/badge.svg)](https://github.com/adamveld12/gamenight/actions/workflows/master_build_release.yml)

A bunch of containerized dedicated servers for games I play on the reg.


| Games | Docs | Dockerhub |
|-|-|-|
| Don't Starve | [README](./dontstarve/README.md) | [![dontstarve](https://img.shields.io/docker/v/gamenight/dontstarve?label=gamenight%2Fdontstarve&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/dontstarve) |
| Dwarf Fortress | [README](./dwarf_fortress/README.md) | [![dwarf fortress](https://img.shields.io/docker/v/gamenight/dwarf_fortress?label=gamenight%2Fdwarf_fortress&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/dwarf_fortress) |
| Rust | [README](./rust/README.md) | [![rust](https://img.shields.io/docker/v/gamenight/rust?label=gamenight%2Frust&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/rust) |
| Valheim | [README](./valheim/README.md) | [![valheim](https://img.shields.io/docker/v/gamenight/valheim?label=gamenight%2Fvalheim&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/valheim) |
| Factorio | [README](./factorio/README.md) | [![factorio](https://img.shields.io/docker/v/gamenight/factorio?label=gamenight%2Ffactorio&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/factorio) |
| Minecraft | [README](./minecraft/README.md) | [![minecraft](https://img.shields.io/docker/v/gamenight/minecraft?label=gamenight%2Fminecraft&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/minecraft) |
| Terraria | [README](./terraria/README.md) | [![terraria](https://img.shields.io/docker/v/gamenight/terraria?label=gamenight%2Fterraria&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/terraria) |
| SteamCMD | [README](./steamcmd/README.md) | [![steamcmd](https://img.shields.io/docker/v/gamenight/steamcmd?label=gamenight%2Fsteamcmd&sort=date&style=for-the-badge)](https://hub.docker.com/r/gamenight/steamcmd) |

- Upcoming Games
    - Arma 3 - 233780
    - Don't Starve Together - 343050
    - Stationeers - 600760
    - Project Zomboid - 223250
    - Killing Floor - 222860
    - Insurgency

## How to use

For the most part all of these follow some a similar pattern:

```
/data
    |__configs/ <- server configs go here
    |__logs/    <- log files should appear here where necessary, otherwise logs will appear in stdout
    |__mods/    <- if the game supports mods, they would go here
    |__saves/   <- game saves are made here
/games
    |__<game_name>/ <- executables and game install lives here
```

- There is a linux user and group named after the specified game (IE for Factorio there is a factorio user)
- All of the configuration files should get mounted into `/data/configs`

- All containers have configs with sane defaults which should allow you to launch them without configuration

- You should be able to simply run the containers, export the proper ports and everything will run without much else required

- If you don't have access to config files I've included defaults in the images so you can use them as reference



## License

MIT
