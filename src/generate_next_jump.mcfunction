#This command runs whenever a player has made a jump. This is ran by the player.
#First we increment Blocks (scoreboard for tracking how many jumps have been made), and we kill off the previous ParkourNextJump marker (might be changed to keep this marker, and just change the tag to a different one, so that this position will be saved.)
#Then, we run spawn-180-rotations.mcfunction to create a ton of randomly rotated markers. These are created at the 2nd next jump (tagged ParkourGeneratedJump) and have the tag TempRotation. These aren't actually 180 markers anymore, check that code's comments to see what's up.
#We convert ParkourGeneratedJump into ParkourNextJump, since this jump is becoming the player's very next jump.
#Then, we choose one of the random TempRotation markers to then create the next ParkourGeneratedJump marker, at a random distance from itself. This function will also kill off all TempRotation markers.
#We create the next block display for ParkourGeneratedJump here, then place the gold block for the very next jump (ParkourNextJump) and remove its display entity. This is a placeholder block, eventually I'll have a function choose what the next block will be based on areas/zones
#Finally, we run generate_decorations.mcfunction to place in block displays, particles, entities, etc. at random.
scoreboard players add @s Blocks 1
kill @n[type=marker,tag=ParkourNextJump]
execute as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz
  function infinite_parkour:generate_next_jump/rotation
  tag @s add ParkourNextJump
  tag @s remove ParkourGeneratedJump
execute at @e[tag=TempRotation,limit=1,sort=random] run function infinite_parkour:generate_next_jump/pick
kill @e[tag=TempRotation]
execute at @n[type=marker,tag=ParkourGeneratedJump] align xyz run summon block_display ~ ~ ~ {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.25f,0.25f,0.25f]}}
execute at @n[type=marker,tag=ParkourNextJump]
  setblock ~ ~ ~ gold_block
  kill @n[type=block_display,tag=ParkourGeneratedDisplay]
function infinite_parkour:generate_decorations

/rotation
  #This command places all of the rotated markers that get randomly selected to place the next block while parkouring. Ran by infinite_parkour:geberate-next-jump.mcfunction
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[0f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[10f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[20f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[40f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[50f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[70f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[75f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-10f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-20f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-40f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-50f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-70f,0f]}
  summon marker ~0.5 ~ ~0.5 {Tags:["TempRotation"],Rotation:[-75f,0f]}

/pick
  #This function handles the physical block placing that the game as to do. This is ran by generate_next_jump.mcfunction by a random marker with tag TempRotation, they have random directions and are located on ParkourNextJump's marker.
  #First, we randomize a number in RandomNum based on the player's difficulty, 0 means it's really easy and blocks that are only 2-3 away and at max 3 over 1 up or 2 over 1 down are chosen.
  #1 difficulty means all jumps are in the pool, except 4 block jumps.
  #2 difficulty just includes 4 block jumps.
  #Then, based on the randomly chosen number, we summon the ParkourGeneratedJump marker using carat notation to indicate directional cordinates, to be placed based on the direction of the marker.
  #They're mainly determined by the third parameter, which indicates the forward direction. They're all one more than expected (2 block jump is 3), with an added 0.35 so that rounding on the weird angles prefers the closer blocks than the further ones.
  #At the end, I align the ParkourGeneratedJump marker to the middle of their block and kill off all of the random facing markers. A limit of 13 is used because that's how many summon right now, if more are added this number will have to be adjusted. 
  execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=0}] store result score @s RandomNum run random value 1..4
  execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=1}] store result score @s RandomNum run random value 1..10
  execute as @p[team=ParkourPlayers] if entity @s[scores={BlockDifficulty=2}] store result score @s RandomNum run random value 1..11
  execute if score @p[team=ParkourPlayers] RandomNum matches 1 run summon marker ^ ^1 ^3.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 2 run summon marker ^ ^ ^3.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 3 run summon marker ^ ^ ^4.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 4 run summon marker ^ ^-1 ^4.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 5 run summon marker ^ ^1 ^2.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 6 run summon marker ^ ^ ^2.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 7 run summon marker ^ ^-1 ^2.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  #Commented out are blocks that were 2 blocks down: execute if score @p[team=ParkourPlayers] RandomNum matches 8 run summon marker ^ ^-2 ^2.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 8 run summon marker ^ ^-1 ^3.25 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  #execute if score @p[team=ParkourPlayers] RandomNum matches 10 run summon marker ^ ^-2 ^3.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 9 run summon marker ^ ^1 ^4.25 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  #execute if score @p[team=ParkourPlayers] RandomNum matches 12 run summon marker ^ ^-2 ^4.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 10 run summon marker ^ ^-1 ^5.25 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  #execute if score @p[team=ParkourPlayers] RandomNum matches 14 run summon marker ^ ^-2 ^5.35 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute if score @p[team=ParkourPlayers] RandomNum matches 11 run summon marker ^ ^ ^5.25 {Tags:["ParkourGeneratedJump","ParkourBlock"]}
  execute as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz run tp @s ~0.5 ~0.5 ~0.5