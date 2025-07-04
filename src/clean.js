import { freeAll } from "./lane.js";
import mcf from "./mcf.js"


const folder = mcf.clean;
const { dim, score, team, data } = folder;

folder`
${freeAll}
${dim}
${score}
${team}
${data}
`

dim`
  #Teleports the players out of the dimension
  execute as @a run function infinite_parkour:player_saver/retrieve
`
const scoreboards = [
  'ip_score',
  'ip_highscore',
  'math',
  'const',
  'ipe_index',
  'ip_data',
  'ip_last_online',
  'ip_lane',
  'ip_flight_cooldown',
  'ip_anim',
	// old scores
  'Blocks',
  'HighScore',
  'RandomNum',
  'BlockCheckpoint',
  'BlockDifficulty',
]
score`
	${scoreboards.map(sb => `scoreboard objectives remove ${sb}`).join('\n')}
`
team`
  #This deletes all teams defined in infinite_parkour:load
  team remove Highscore
  team remove ParkourPlayers
`
data`
  data remove storage infinite_parkour:player_data players
`