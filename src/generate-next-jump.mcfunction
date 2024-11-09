#This command runs whenever a player has made a jump. This is ran by the player.
#First we increment Blocks (scoreboard for tracking how many jumps have been made), and we kill off the previous ParkourNextJump marker (might be changed to keep this marker, and just change the tag to a different one, so that this position will be saved.)
#Then, we run spawn-180-rotations.mcfunction to create a ton of randomly rotated markers. These are created at the 2nd next jump (tagged ParkourGeneratedJump) and have the tag ParkourDecision. These aren't actually 180 markers anymore, check that code's comments to see what's up.
#We convert ParkourGeneratedJump into ParkourNextJump, since this jump is becoming the player's very next jump.
#Then, we choose one of the random ParkourDecision markers to then create the next ParkourGeneratedJump marker, at a random distance from itself. This function will also kill off all ParkourDecision markers.
#We create the next block display for ParkourGeneratedJump here, then place the gold block for the very next jump (ParkourNextJump) and remove its display entity. This is a placeholder block, eventually I'll have a function choose what the next block will be based on areas/zones
#Finally, we run generate-decorations.mcfunction to place in block displays, particles, entities, etc. at random.
scoreboard players add @s Blocks 1
kill @n[type=marker,tag=ParkourNextJump]
execute as @n[type=marker,tag=ParkourGeneratedJump] at @s align xyz
  function infinite-parkour:spawn-180-rotations
  tag @s add ParkourNextJump
  tag @s remove ParkourGeneratedJump
execute at @n[type=marker,tag=ParkourDecision] as @e[type=marker,tag=ParkourDecision,limit=1,sort=random,distance=..1] at @s run function infinite-parkour:place-generated-jump-marker
execute at @n[type=marker,tag=ParkourGeneratedJump] align xyz run summon block_display ~ ~ ~ {Tags:["ParkourGeneratedDisplay"],block_state:{Name:"minecraft:gold_block"},transformation:{scale:[0.5f,0.5f,0.5f],left_rotation:[0.0f,0.0f,0.0f,1.0f],right_rotation:[0.0f,0.0f,0.0f,1.0f],translation:[0.25f,0.25f,0.25f]}}
execute at @n[type=marker,tag=ParkourNextJump]
  setblock ~ ~ ~ gold_block
  kill @n[type=block_display,tag=ParkourGeneratedDisplay]
function infinite-parkour:generate-decorations