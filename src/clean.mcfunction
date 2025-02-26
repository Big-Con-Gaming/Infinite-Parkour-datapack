# this function deletes anything the datapack made

function infinite_parkour:lane/free_all
%FILE%/dim
%FILE%/score
%FILE%/team
%FILE%/data

/dim
  #Teleports the players out of the dimension
  execute as @a run function infinite_parkour:player_saver/retrieve
/score
  #This deletes all scoreboards defined in infinite_parkour:load
  scoreboard objectives remove ip_score
  scoreboard objectives remove ip_highscore
  scoreboard objectives remove math
  scoreboard objectives remove const
  scoreboard objectives remove ipe_index
  scoreboard objectives remove ip_data
  scoreboard objectives remove ip_last_online
  scoreboard objectives remove ip_lane
  scoreboard objectives remove ip_flight_cooldown
  scoreboard objectives remove ip_anim

  #TO DO: Add a system to go through all iph_INSERTPACKID scoreboards and remove them.

  #Old scores
  scoreboard objectives remove Blocks
  scoreboard objectives remove HighScore
  scoreboard objectives remove RandomNum
  scoreboard objectives remove BlockCheckpoint
  scoreboard objectives remove BlockDifficulty
/team
  #This deletes all teams defined in infinite_parkour:load
  team remove Highscore
  team remove ParkourPlayers
/data
  data remove storage infinite_parkour:player_data players