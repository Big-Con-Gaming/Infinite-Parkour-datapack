execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=0}] store result score @s RandomNum run random value 1..4
execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=1}] store result score @s RandomNum run random value 1..10
execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=2}] store result score @s RandomNum run random value 1..11
execute if score @p[team=ParkourPlayers] RandomNum matches 1 run summon marker ^ ^1 ^3.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 2 run summon marker ^ ^ ^3.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 3 run summon marker ^ ^ ^4.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 4 run summon marker ^ ^-1 ^4.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 5 run summon marker ^ ^1 ^2.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 6 run summon marker ^ ^ ^2.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 7 run summon marker ^ ^-1 ^2.35 {Tags:["ParkourGeneratedJump"]}
#Commented out are blocks that were 2 blocks down: execute if score @p[team=ParkourPlayers] RandomNum matches 8 run summon marker ^ ^-2 ^2.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 8 run summon marker ^ ^-1 ^3.25 {Tags:["ParkourGeneratedJump"]}
#execute if score @p[team=ParkourPlayers] RandomNum matches 10 run summon marker ^ ^-2 ^3.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 9 run summon marker ^ ^1 ^4.25 {Tags:["ParkourGeneratedJump"]}
#execute if score @p[team=ParkourPlayers] RandomNum matches 12 run summon marker ^ ^-2 ^4.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 10 run summon marker ^ ^-1 ^5.25 {Tags:["ParkourGeneratedJump"]}
#execute if score @p[team=ParkourPlayers] RandomNum matches 14 run summon marker ^ ^-2 ^5.35 {Tags:["ParkourGeneratedJump"]}
execute if score @p[team=ParkourPlayers] RandomNum matches 11 run summon marker ^ ^ ^5.25 {Tags:["ParkourGeneratedJump"]}
execute as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz run tp @s ~0.5 ~0.5 ~0.5
execute as @e[type=marker,tag=ParkourDecision,sort=nearest,limit=13] run kill @s