execute store result score @s DistX run data get entity @s Pos[0] 100
execute store result score @s DistZ run data get entity @s Pos[2] 100
execute store result score @p[team=ParkourPlayers] DistX run data get entity @p[team=ParkourPlayers] Pos[0] 100
execute store result score @p[team=ParkourPlayers] DistZ run data get entity @p[team=ParkourPlayers] Pos[2] 100
scoreboard players operation @s DistX -= @p[team=ParkourPlayers] DistX
scoreboard players operation @s DistZ -= @p[team=ParkourPlayers] DistZ
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath -1
execute if score @s DistX matches ..-0 run scoreboard players operation @s DistX *= GeneratedBlockDisplayDistStoreNum BlocksMath
execute if score @s DistZ matches ..-0 run scoreboard players operation @s DistZ *= GeneratedBlockDisplayDistStoreNum BlocksMath
scoreboard players operation @s DistX += @s DistZ
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath 10
scoreboard players operation @s DistX /= GeneratedBlockDisplayDistStoreNum BlocksMath
scoreboard players set @s DistZ 100
scoreboard players operation @s DistZ -= @s DistX
scoreboard players set GeneratedBlockDisplayDistStoreNum BlocksMath 2
scoreboard players operation @s DistX /= GeneratedBlockDisplayDistStoreNum BlocksMath
execute store result storage infinite-parkour:dist-calc display.DistX float 0.01 run scoreboard players get @s DistX
execute store result storage infinite-parkour:dist-calc display.DistZ float 0.01 run scoreboard players get @s DistZ
function infinite-parkour:next-block-display-scale with storage infinite-parkour:dist-calc display