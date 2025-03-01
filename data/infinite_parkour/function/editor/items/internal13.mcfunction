$scoreboard players set #increment ip_data $(increment)
$execute if score #increment ip_data matches 0..9 run data modify storage infinite_parkour:macro slot.contents set value {model$(increment):"minecraft:air",name$(increment):"$(increment)",lore$(increment):""}
execute if score #increment ip_data matches 10 run data modify storage infinite_parkour:macro slot.contents set value {modela:"minecraft:air",namea:"a",lorea:""}
execute if score #increment ip_data matches 11 run data modify storage infinite_parkour:macro slot.contents set value {modelb:"minecraft:air",nameb:"b",loreb:""}