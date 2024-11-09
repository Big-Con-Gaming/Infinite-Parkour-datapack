function infinite-parkour:player-fall-detection
execute if entity @s[team=ParkourPlayers,tag=!ParkourFalling] if entity @n[type=marker,tag=ParkourNextJump,distance=..2] run function infinite-parkour:generate-next-jump
execute align xyz positioned ~-10 ~-10 ~-1 unless entity @e[type=marker,tag=ParkourEndLobby,dx=20,dy=20,dz=20] if dimension infinite-parkour:infinite-parkour run fill ~50 ~50 ~-1 ~-50 ~-50 ~-1 air
execute align xyz positioned ~-70 ~-50 ~-1 if dimension infinite-parkour:infinite-parkour run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]