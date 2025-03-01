execute if score #direction math matches 1 run data modify entity @s Motion[1] set value 0.7d
execute if score #direction math matches 0 run data modify entity @s Motion[1] set value 0.0d
execute if score #direction math matches -1 run data modify entity @s Motion[1] set value -0.7d
execute store result score #on_ground math run data get entity @s OnGround
execute unless block ~-0.29 ~1.79 ~-0.29 air align y run tp @s ~ ~0.2 ~
execute unless block ~-0.29 ~1.79 ~0.29 air align y run tp @s ~ ~0.2 ~
execute unless block ~0.29 ~1.79 ~-0.29 air align y run tp @s ~ ~0.2 ~
execute unless block ~0.29 ~1.79 ~0.29 air align y run tp @s ~ ~0.2 ~