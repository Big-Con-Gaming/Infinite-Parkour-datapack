#This command runs every tick for all players directly in the game, on team: ParkourPlayers
#Below is a command that runs the fall detection function on the player. We do this first so that if the player gets the tag ParkourFalling, we can prevent generation of the next jump since that player is exiting the game.
function infinite-parkour:player-fall-detection
execute if entity @s[team=ParkourPlayers,tag=!ParkourFalling,nbt={OnGround:1b}] if entity @n[type=marker,tag=ParkourNextJump,distance=..2] run function infinite-parkour:generate-next-jump
#Below cleans up all blocks and decorations behind the players. The fill command could be removed if we save the location of the most previous jump, to then delete that block and its marker at once.
execute align xyz positioned ~-10 ~-10 ~-1 unless entity @e[type=marker,tag=ParkourEndLobby,dx=20,dy=20,dz=20] if dimension infinite-parkour:infinite-parkour run fill ~50 ~50 ~-1 ~-50 ~-50 ~-1 air
execute align xyz positioned ~-70 ~-50 ~-1 if dimension infinite-parkour:infinite-parkour run kill @e[tag=ParkourDeco,dx=140,dy=100,dz=1]