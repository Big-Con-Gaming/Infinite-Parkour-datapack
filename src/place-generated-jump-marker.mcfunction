#This function handles the physical block placing that the game as to do. This is ran by generate-next-jump.mcfunction by a random marker with tag ParkourDecision, they have random directions and are located on ParkourNextJump's marker.
#First, we randomize a number in RandomNum based on the player's difficulty, 0 means it's really easy and blocks that are only 2-3 away and at max 3 over 1 up or 2 over 1 down are chosen.
#1 difficulty means all jumps are in the pool, except 4 block jumps.
#2 difficulty just includes 4 block jumps.
#Then, based on the randomly chosen number, we summon the ParkourGeneratedJump marker using carat notation to indicate directional cordinates, to be placed based on the direction of the marker.
#They're mainly determined by the third parameter, which indicates the forward direction. They're all one more than expected (2 block jump is 3), with an added 0.35 so that rounding on the weird angles prefers the closer blocks than the further ones.
#At the end, I align the ParkourGeneratedJump marker to the middle of their block and kill off all of the random facing markers. A limit of 13 is used because that's how many summon right now, if more are added this number will have to be adjusted. 
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