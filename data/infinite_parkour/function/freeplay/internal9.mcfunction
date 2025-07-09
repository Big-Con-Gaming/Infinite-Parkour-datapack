execute if score #value math matches 1 run return 1
execute positioned ~0.11 ~ ~ run data modify entity @n[type=text_display,distance=..0.1] text set value {color:"red",text:"off"}
scoreboard players set #value math 0
return 0