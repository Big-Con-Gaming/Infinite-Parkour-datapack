tellraw @s {"text":"Welcome to the infinite parkour editor!","bold":true,"color":"dark_green"}
tellraw @s [{"text":"Disclaimer:","bold":true,"color":"gold"},{"text":" This editor is not done yet, Expect bugs.","bold":false,"color":"yellow"}]
scoreboard players reset @s ip_lane
function infinite_parkour:player_saver/store
gamemode creative @s
execute in infinite_parkour:editor positioned 0.0 0.0 0.0 run function infinite_parkour:editor/internal0
team join infpar_editor @s