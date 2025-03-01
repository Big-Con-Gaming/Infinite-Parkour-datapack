execute if function infinite_parkour:player_saver/test run return 0
data modify storage infinite_parkour:player_data current.UUID set from entity @s UUID
item replace block 0 0 0 container.0 from entity @s container.0
item replace block 0 0 0 container.1 from entity @s container.1
item replace block 0 0 0 container.2 from entity @s container.2
item replace block 0 0 0 container.3 from entity @s container.3
item replace block 0 0 0 container.4 from entity @s container.4
item replace block 0 0 0 container.5 from entity @s container.5
item replace block 0 0 0 container.6 from entity @s container.6
item replace block 0 0 0 container.7 from entity @s container.7
item replace block 0 0 0 container.8 from entity @s container.8
item replace block 0 0 0 container.9 from entity @s container.9
item replace block 0 0 0 container.10 from entity @s container.10
item replace block 0 0 0 container.11 from entity @s container.11
item replace block 0 0 0 container.12 from entity @s container.12
item replace block 0 0 0 container.13 from entity @s container.13
item replace block 0 0 0 container.14 from entity @s container.14
item replace block 0 0 0 container.15 from entity @s container.15
item replace block 0 0 0 container.16 from entity @s container.16
item replace block 0 0 0 container.17 from entity @s container.17
item replace block 0 0 0 container.18 from entity @s container.18
item replace block 0 0 0 container.19 from entity @s container.19
item replace block 0 0 0 container.20 from entity @s container.20
item replace block 0 0 0 container.21 from entity @s container.21
item replace block 0 0 0 container.22 from entity @s container.22
item replace block 0 0 0 container.23 from entity @s container.23
item replace block 0 0 0 container.24 from entity @s container.24
item replace block 0 0 0 container.25 from entity @s container.25
item replace block 0 0 0 container.26 from entity @s container.26
data modify storage infinite_parkour:player_data current.inventory0 set from block 0 0 0 Items
data remove block 0 0 0 Items
item replace block 0 0 0 container.0 from entity @s container.27
item replace block 0 0 0 container.1 from entity @s container.28
item replace block 0 0 0 container.2 from entity @s container.29
item replace block 0 0 0 container.3 from entity @s container.30
item replace block 0 0 0 container.4 from entity @s container.31
item replace block 0 0 0 container.5 from entity @s container.32
item replace block 0 0 0 container.6 from entity @s container.33
item replace block 0 0 0 container.7 from entity @s container.34
item replace block 0 0 0 container.8 from entity @s container.35
item replace block 0 0 0 container.9 from entity @s armor.head
item replace block 0 0 0 container.10 from entity @s armor.chest
item replace block 0 0 0 container.11 from entity @s armor.legs
item replace block 0 0 0 container.12 from entity @s armor.feet
item replace block 0 0 0 container.13 from entity @s weapon.offhand
item replace block 0 0 0 container.14 from entity @s weapon.offhand
item replace block 0 0 0 container.15 from entity @s player.cursor
data modify storage infinite_parkour:player_data current.inventory1 set from block 0 0 0 Items
data remove block 0 0 0 Items
item replace block 0 0 0 container.0 from entity @s enderchest.0
item replace block 0 0 0 container.1 from entity @s enderchest.1
item replace block 0 0 0 container.2 from entity @s enderchest.2
item replace block 0 0 0 container.3 from entity @s enderchest.3
item replace block 0 0 0 container.4 from entity @s enderchest.4
item replace block 0 0 0 container.5 from entity @s enderchest.5
item replace block 0 0 0 container.6 from entity @s enderchest.6
item replace block 0 0 0 container.7 from entity @s enderchest.7
item replace block 0 0 0 container.8 from entity @s enderchest.8
item replace block 0 0 0 container.9 from entity @s enderchest.9
item replace block 0 0 0 container.10 from entity @s enderchest.10
item replace block 0 0 0 container.11 from entity @s enderchest.11
item replace block 0 0 0 container.12 from entity @s enderchest.12
item replace block 0 0 0 container.13 from entity @s enderchest.13
item replace block 0 0 0 container.14 from entity @s enderchest.14
item replace block 0 0 0 container.15 from entity @s enderchest.15
item replace block 0 0 0 container.16 from entity @s enderchest.16
item replace block 0 0 0 container.17 from entity @s enderchest.17
item replace block 0 0 0 container.18 from entity @s enderchest.18
item replace block 0 0 0 container.19 from entity @s enderchest.19
item replace block 0 0 0 container.20 from entity @s enderchest.20
item replace block 0 0 0 container.21 from entity @s enderchest.21
item replace block 0 0 0 container.22 from entity @s enderchest.22
item replace block 0 0 0 container.23 from entity @s enderchest.23
item replace block 0 0 0 container.24 from entity @s enderchest.24
item replace block 0 0 0 container.25 from entity @s enderchest.25
item replace block 0 0 0 container.26 from entity @s enderchest.26
data modify storage infinite_parkour:player_data current.enderchest set from block 0 0 0 Items
data remove block 0 0 0 Items
data modify storage infinite_parkour:player_data current.position.dimension set from entity @s Dimension
data modify storage infinite_parkour:player_data current.position.x set from entity @s Pos[0]
data modify storage infinite_parkour:player_data current.position.y set from entity @s Pos[1]
data modify storage infinite_parkour:player_data current.position.z set from entity @s Pos[2]
data modify storage infinite_parkour:player_data current.position.yaw set from entity @s Rotation[0]
data modify storage infinite_parkour:player_data current.position.pitch set from entity @s Rotation[1]
data modify storage infinite_parkour:player_data current.gamemode set from entity @s playerGameType
data modify storage infinite_parkour:player_data players append from storage infinite_parkour:player_data current
data remove storage infinite_parkour:player_data current