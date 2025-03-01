scoreboard players set #direction math 0
execute if predicate {"condition":"entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","input":{"jump":true}}}} run scoreboard players add #direction math 1
execute if predicate {"condition":"entity_properties","entity":"this","predicate":{"type_specific":{"type":"player","input":{"sneak":true}}}} run scoreboard players remove #direction math 1
execute if entity @s[tag=ipe_flying] run function infinite_parkour:editor/flight/flying_tick
execute if score #direction math matches 1 run function infinite_parkour:editor/flight/internal1
scoreboard players reset #direction math