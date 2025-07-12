from python import *

# === Helper functions ===

def add_objectives(objs):
    for name, title in objs:
        c(f'scoreboard objectives add {name} dummy {{text:"{title}"}}')

def set_constants(vals):
    for val in vals:
        c(f"scoreboard players set {val} const {val}")

def add_teams(team_defs):
    for name, text, color in team_defs:
        display = f' {{text:"{text}"}}' if text else ''
        c(f"team add {name}{display}")
        c(f"team modify {name} color {color}")

def set_collision_rules(team_names):
    for name in team_names:
        c(f"team modify {name} collisionRule never")

def batch(commands):
    for cmd in commands:
        c(cmd)

# === Execution ===

add_objectives([
    ("ip_score", "Infinite Parkour - Distance (M)"),
    ("ip_highscore", "Infinite Parkour - High Score"),
    ("const", "Constant values"),
    ("ipe_index", "Index"),
    ("ip_data", "Data"),
    ("ip_last_online", "Last Online"),
    ("ip_lane", "Lane"),
    ("ip_flight_cooldown", "Flight Cooldown"),
    ("ip_anim", "Animation Frame Counter for Entities"),
])

set_constants([-1, 1, 2, 4, 5, 31, 64, 100, 128, 180, 200, 1024, 8000, 10000, 16000])

batch([
    "gamerule commandModificationBlockLimit 999999999",
    "gamerule doMobLoot false",
    "gamerule fallDamage false",
])

add_teams([
    ("Highscore",        "InLobby",     "gold"),
    ("ParkourPlayers",   "InParkour",   "yellow"),
    ("infpar_yellow",    None,          "yellow"),
    ("infpar_green",     None,          "green"),
    ("infpar_dark_green",None,          "dark_green"),
    ("infpar_editor",    "InEditor",    "white"),
])

set_collision_rules(["Highscore", "ParkourPlayers", "infpar_editor"])

c("execute unless data storage infinite_parkour:player_data players run data modify storage infinite_parkour:player_data players set value []")

player_dim_logic = [
    ("infinite_parkour:lane", "tp @s 0 0 0", "function infinite_parkour:freeplay"),
    ("infinite_parkour:editor", "tp @s 0 0 0", "function infinite_parkour:editor"),
]
for dim, tp_cmd, func_cmd in player_dim_logic:
    base = f"execute as @a at @s if dimension {dim} in minecraft:overworld run"
    c(f"{base} {tp_cmd}")
    c(f"{base} {func_cmd}")

batch([
    "execute in infinite_parkour:lane run forceload add 0 0 0 0",
    "execute in infinite_parkour:lane run setblock 0 0 0 minecraft:barrel",
])
import src.load_base_packs
src.load_base_packs.main()
#c("say §aFinished loading!")