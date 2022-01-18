# Terraria

Dedicated server for Terraria


## Environment variables

- `T_WORLD_NAME "MobyWorld"`: Sets the name of the world when using autocreate
- `T_MAX_PLAYERS 8`: Sets the max number of players allowed on a server. Value must be between 1 and 255
- `T_PASSWORD ""`: Set the server password
- `T_MOTD "Save the whales!"`: Set the message of the day
- `T_WORLD_SIZE 2`: Creates a new world if none is found. World size is specified by: 1(small), 2(medium), and 3(large).
- `T_DIFFICULTY 0`: Sets world difficulty when using -autocreate. Options: 0(normal), 1(expert)
- `T_SECURE 1`: Adds additional cheat protection.
- `T_LANG "en/US"`: Sets the server language from its language code.  en/US = English de/DE = German it/IT = Italian fr/FR = French es/ES = Spanish ru/RU = Russian zh/Hans = Chinese pt/BR = Portuguese pl/PL = Polish

## Ports

- `7777/tcp`: Game port

## Volumes

- `/data/saves`: game saves
- `/configs/serverconfig.txt`: https://terraria.fandom.com/wiki/Server#Server_config_file
