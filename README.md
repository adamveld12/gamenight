# Game Night

A bunch of containerized dedicated servers for games I play on the reg.

- Upcoming Games
    - Arma 3 - 233780
    - Dwarf Fortress (not MP but I still love it)
    - Don't Starve Together - 343050
    - Terraria - 105600
    - Stationeers - 600760 
    - Project Zomboid - 223250
    - Killing Floor - 222860


## How to use

You will need docker or some other container runtime capable of running docker images installed.

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

- There is a linux user named after tha specified game (IE for Factorio there is a factorio user)

- All of the configuration files should get mounted into `/data/configs`

- All containers have configs with sane defaults which should allow you to launch them without configuration

- You should be able to simply run the containers, export the proper ports and everything will run without much else required 

- If you don't have access to config files I've included defaults in the images so you can use them as reference

### Arma 3

PORTS 2302/udp 2302/udp 2303/udp 2304/udp 2305/udp 2306/udp

```
SERVER_ARGS= # extra command line arguments you would like to pass to the arma3server executable
```

Multiplayer missions should be added to `/data/mpmissions`. Mods should go to `/data/mods` and must have the `SERVER_ARGS` environment variable setup to load the mods (using the -mod switch) as specified here: [https://community.bistudio.com/wiki/ArmA:_Server_configuration#Linux](https://community.bistudio.com/wiki/ArmA:_Server_configuration#Linux)


### Factorio

PORTS 34197/udp

```
DEFAULT_SAVE_FILE=game_save // the game save file name, this save file is based in /data/saves
```

If the startup script sees a save file with a name matching the env var `DEFAULT_SAVE_FILE` it will tell the server to load it 
instead of generating a new one.

Mods can be copied into `/data/mods/` and the server will pick them up at launch

### Minecraft

PORTS 25565/tcp

```
JVM_MEMORY_SIZE=1024m // the memory allocation for the JVM see:  (https://minecraft.gamepedia.com/Tutorials/Setting_up_a_server#Start_the_Minecraft_server)
```

Create your `server.properties` and mount it in `/data/configs/`

### Rust

PORTS 28015/udp 28016/tcp 28017/tcp

Create a server.cfg  and mount it in `/data/configs`.
You can find a selection of config properties here: [https://developer.valvesoftware.com/wiki/Rust_Dedicated_Server#Server_Commands](https://developer.valvesoftware.com/wiki/Rust_Dedicated_Server#Server_Commands).

Note: do not put the `+` in your server.cfg, see the example below:

```
server.ip 0.0.0.0
server.port 28015
rcon.ip 0.0.0.0
rcon.port 28016
rcon.web 0
server.tickrate 10
server.hostname "Your Server Name"
server.identity "my_server_identity"
server.maxplayers 50
server.worldsize 3000
server.seed 50000
server.saveinterval 600
rcon.password "YourPassword"
```


### SteamCMD

Useful for using as a base image for any game using steam. The entrypoint by default installs the specified APPID with steamcmd and then runs `/data/configs/configure.sh` which can then be used to launch the game or whatever else.

Make sure to make an extra steam account that you uses specifically for dedicated servers, so your account cannot be compromised.

For security reasons the `/home/steam/install.sh` logs out steamcmd after executing if you authenticate with steam guard. If you need to do some steamcmd workflows that don't align with how the `install.sh` works you should use steamcmd directly at `/home/steam/steamcmd/steamcmd.sh`.

```
# the user name/pass used to authenticate with steam, some games require this before you can download the dedicated server executable
STEAMUSER="anonymous" 
STEAMPASS=""
STEAMGUARD=""  # steam guard verification token - I recommend running the install once so the email is sent and then running again with this env var set with the token to get this to work

APPID=<undefined>     # the app to install - see list of dedication server app IDs here: (https://developer.valvesoftware.com/wiki/Dedicated_Servers_List)
```

You can overwrite the `/data/configs/configure.sh` to run custom commands such as installing games or setting up complex things. This should not be necessary in the other images though


## Dwarf Fortress

Easy, just run it. Saves are `/games/df/data/save`.


## License

MIT