function infinite_parkour:player_saver/internal3 with entity @s
execute unless data storage infinite_parkour:player_data current run return 0
data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory0
item replace entity @s container.0 from block 0 0 0 container.0
item replace entity @s container.1 from block 0 0 0 container.1
item replace entity @s container.2 from block 0 0 0 container.2
item replace entity @s container.3 from block 0 0 0 container.3
item replace entity @s container.4 from block 0 0 0 container.4
item replace entity @s container.5 from block 0 0 0 container.5
item replace entity @s container.6 from block 0 0 0 container.6
item replace entity @s container.7 from block 0 0 0 container.7
item replace entity @s container.8 from block 0 0 0 container.8
item replace entity @s container.9 from block 0 0 0 container.9
item replace entity @s container.10 from block 0 0 0 container.10
item replace entity @s container.11 from block 0 0 0 container.11
item replace entity @s container.12 from block 0 0 0 container.12
item replace entity @s container.13 from block 0 0 0 container.13
item replace entity @s container.14 from block 0 0 0 container.14
item replace entity @s container.15 from block 0 0 0 container.15
item replace entity @s container.16 from block 0 0 0 container.16
item replace entity @s container.17 from block 0 0 0 container.17
item replace entity @s container.18 from block 0 0 0 container.18
item replace entity @s container.19 from block 0 0 0 container.19
item replace entity @s container.20 from block 0 0 0 container.20
item replace entity @s container.21 from block 0 0 0 container.21
item replace entity @s container.22 from block 0 0 0 container.22
item replace entity @s container.23 from block 0 0 0 container.23
item replace entity @s container.24 from block 0 0 0 container.24
item replace entity @s container.25 from block 0 0 0 container.25
item replace entity @s container.26 from block 0 0 0 container.26
data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory1
item replace entity @s container.27 from block 0 0 0 container.0
item replace entity @s container.28 from block 0 0 0 container.1
item replace entity @s container.29 from block 0 0 0 container.2
item replace entity @s container.30 from block 0 0 0 container.3
item replace entity @s container.31 from block 0 0 0 container.4
item replace entity @s container.32 from block 0 0 0 container.5
item replace entity @s container.33 from block 0 0 0 container.6
item replace entity @s container.34 from block 0 0 0 container.7
item replace entity @s container.35 from block 0 0 0 container.8
item replace entity @s armor.head from block 0 0 0 container.9
item replace entity @s armor.chest from block 0 0 0 container.10
item replace entity @s armor.legs from block 0 0 0 container.11
item replace entity @s armor.feet from block 0 0 0 container.12
item replace entity @s weapon.offhand from block 0 0 0 container.13
item replace entity @s weapon.offhand from block 0 0 0 container.14
item replace entity @s player.cursor from block 0 0 0 container.15
data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.enderchest
item replace entity @s enderchest.0 from block 0 0 0 container.0
item replace entity @s enderchest.1 from block 0 0 0 container.1
item replace entity @s enderchest.2 from block 0 0 0 container.2
item replace entity @s enderchest.3 from block 0 0 0 container.3
item replace entity @s enderchest.4 from block 0 0 0 container.4
item replace entity @s enderchest.5 from block 0 0 0 container.5
item replace entity @s enderchest.6 from block 0 0 0 container.6
item replace entity @s enderchest.7 from block 0 0 0 container.7
item replace entity @s enderchest.8 from block 0 0 0 container.8
item replace entity @s enderchest.9 from block 0 0 0 container.9
item replace entity @s enderchest.10 from block 0 0 0 container.10
item replace entity @s enderchest.11 from block 0 0 0 container.11
item replace entity @s enderchest.12 from block 0 0 0 container.12
item replace entity @s enderchest.13 from block 0 0 0 container.13
item replace entity @s enderchest.14 from block 0 0 0 container.14
item replace entity @s enderchest.15 from block 0 0 0 container.15
item replace entity @s enderchest.16 from block 0 0 0 container.16
item replace entity @s enderchest.17 from block 0 0 0 container.17
item replace entity @s enderchest.18 from block 0 0 0 container.18
item replace entity @s enderchest.19 from block 0 0 0 container.19
item replace entity @s enderchest.20 from block 0 0 0 container.20
item replace entity @s enderchest.21 from block 0 0 0 container.21
item replace entity @s enderchest.22 from block 0 0 0 container.22
item replace entity @s enderchest.23 from block 0 0 0 container.23
item replace entity @s enderchest.24 from block 0 0 0 container.24
item replace entity @s enderchest.25 from block 0 0 0 container.25
item replace entity @s enderchest.26 from block 0 0 0 container.26
data remove block 0 0 0 Items
function infinite_parkour:player_saver/internal4 with storage infinite_parkour:player_data current.position
execute store result score #mode math run data get storage infinite_parkour:player_data current.gamemode
execute if score #mode math matches 0 run gamemode survival @s
execute if score #mode math matches 1 run gamemode creative @s
execute if score #mode math matches 2 run gamemode adventure @s
execute if score #mode math matches 3 run gamemode spectator @s
scoreboard players reset #mode math
data remove storage infinite_parkour:player_data current