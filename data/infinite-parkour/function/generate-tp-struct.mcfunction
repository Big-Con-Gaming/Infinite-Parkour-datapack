execute align xyz run summon interaction ~0.5 ~1.5 ~0.5 {Tags:["ParkourReturn"],width:1.5}
execute align xyz run summon text_display ~0.5 ~2 ~0.5 {billboard:"center",alignment:"center",Tags:["ParkourLabel"],text:'[{"color":"yellow","text":"Click to Play"},{"bold":true,"color":"#FFBB00","text":" Infinite Parkour"}]'}
execute in infinite-parkour:infinite-parkour positioned 0 0 0 unless entity @n[type=marker,tag=ParkourLobby,limit=1] run function infinite-parkour:generate-lobby
kill @s