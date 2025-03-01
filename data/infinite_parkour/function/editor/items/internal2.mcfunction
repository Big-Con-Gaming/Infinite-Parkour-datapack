execute unless entity @s[tag=ip_editor] run clear @s
execute unless items entity @s player.cursor item_frame run function infinite_parkour:editor/items/retrieve_items
function infinite_parkour:editor/items/store_items
function infinite_parkour:editor/items/give_bundles
tag @s add ip_editor