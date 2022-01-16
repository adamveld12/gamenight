# Game Night

[![Games CI](https://github.com/adamveld12/gamenight/actions/workflows/steam-games.yml/badge.svg)](https://github.com/adamveld12/gamenight/actions/workflows/games.yml)
[![Steam Games CI](https://github.com/adamveld12/gamenight/actions/workflows/games.yml/badge.svg)](https://github.com/adamveld12/gamenight/actions/workflows/steam-games.yml)

A bunch of containerized dedicated servers for games I play on the reg.

| Games | Docs | Latest Version |
|-|-|-|
| Don't Starve | [README](./dontstarve/README.md) | gn-wip-latest |
| Dwarf Fortress | [README](./dwarf_fortress/README.md) | gn-wip-latest |
| Factorio | [README](./factorio/README.md) | 1.1.50 |
| Minecraft | [README](./minecraft/README.md) | 1.18.1 |
| Rust | [README](./rust/README.md) | gn-wip-latest |
| Terraria | [README](./terraria/README.md) | 1432 |
| Valheim | [README](./valheim/README.md) | 0.204.4 |



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
