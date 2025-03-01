setblock ~ ~-1 ~ bedrock
execute unless entity @n[type=text_display,distance=..0.1] run summon text_display ~ ~ ~ {text:'"Place starting block"',billboard:"center"}