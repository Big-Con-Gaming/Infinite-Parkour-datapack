data modify storage infinite_parkour:macro data.jumppack_id set from entity @s Inventory[{Slot:8b}].components."minecraft:written_book_content".title.raw
execute unless data storage infinite_parkour:macro data.jumppack_id run return 0
function infinite_parkour:editor/items/internal3 with storage infinite_parkour:macro data
execute unless score #valid math matches 1 run tellraw @s {"text": "Invalid name", "color": "red"}
execute if score #valid math matches 1 positioned 0.0 0.0 0.0 run function infinite_parkour:editor/items/internal4
data remove storage infinite_parkour:macro data
scoreboard players reset #valid math