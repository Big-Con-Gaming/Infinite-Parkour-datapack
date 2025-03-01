summon marker 0 0 0 {Tags:["IP_Temp"]}
$data modify entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags append value "$(target_slot)"
$data modify entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags append value "$(editor_pos_in_bundle)"
execute store result score #test ip_data if data entity @n[type=marker,x=0,y=0,z=0,tag=IP_Temp,distance=0..] Tags[]
execute if score #test ip_data matches 2 run function infinite_parkour:editor/items/internal12 with storage infinite_parkour:macro search
kill @n[type=marker,tag=IP_Temp,x=0,y=0,z=0,distance=0..]