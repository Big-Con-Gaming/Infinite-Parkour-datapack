execute if entity @s[tag=ip_portal_freeplay] run function infinite_parkour:portal/internal3
data remove entity @s attack
data remove entity @s interaction
execute unless function infinite_parkour:portal/test_structure run kill @e[tag=ip_portal,distance=..1,limit=3]