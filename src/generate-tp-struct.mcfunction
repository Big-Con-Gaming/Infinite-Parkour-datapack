#This command places the interaction entity and the text display needed for teleporting the player into the lobby. It also checks if the lobby has been created, and if not, does so. This could be moved into load.mcfunction.
#This is ran by the diamond thrown into the fire, so it is killed at the end.
execute align xyz run summon interaction ~0.5 ~1.5 ~0.5 {Tags:["ParkourReturn"],width:1.5}
execute align xyz run summon text_display ~0.5 ~2 ~0.5 {billboard:"center",alignment:"center",Tags:["ParkourLabel"],text:'[{"color":"yellow","text":"Click to Play"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}
execute in infinite-parkour:infinite-parkour positioned 0 0 0 unless entity @n[type=marker,tag=ParkourLobby,limit=1] run function infinite-parkour:generate-lobby
kill @s