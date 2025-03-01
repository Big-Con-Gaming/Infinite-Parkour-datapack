scoreboard players reset #test ip_data
$scoreboard players set #test ip_data $(remove_display_on_place)
$execute if score #test ip_data matches 1 run data modify storage infinite_parkour:macro slot.contents.model$(editor_pos_in_bundle) set value "$(physical_block)"
$execute unless score #test ip_data matches 1 run data modify storage infinite_parkour:macro slot.contents.model$(editor_pos_in_bundle) set value "$(editor_display_block)"
$data modify storage infinite_parkour:macro slot.contents.name$(editor_pos_in_bundle) set value $(id)
$data modify storage infinite_parkour:macro slot.contents.lore$(editor_pos_in_bundle) set value "\"$(editor_item_desc)\""