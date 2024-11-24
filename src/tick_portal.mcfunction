# this file is responsible for:
# - portal click detection
# - storing player data and retrieving it when they are out.
# TODO, should probably move out the storing and retrieving part.
# TODO, should probably adapt portal click detection to work with the new gamemodes, like in freeplay.mcfunction

#This runs every tick due to tick.json
#These just detect whenever the player is left or right clicking an interaction entity. it runs a command on the player based on attack or target, then removes the nbt from the interaction entity.
#ParkourReturn is the interaction that is in the overworld, that brings players into the lobby. It teleports them directly to the marker tagged ParkourLobby, which is located at the exact spot I want players to enter the lobby.
#Directly above that ParkourLobby marker, is the tagged ParkourLobbyLeave interaction entity. This one teleports the player back into the overworld. This should be modified to send the player to the teleporter they started at, but currently only teleports to the first one chosen arbitrarily.
execute in infinite_parkour:infinite_parkour as @e[type=interaction,tag=ParkourReturn] run
  execute on attacker run function infinite_parkour:tick_portal/teleport_in
  execute on target run function infinite_parkour:tick_portal/teleport_in
  data remove entity @s attack
  data remove entity @s interaction
execute in infinite_parkour:infinite_parkour as @e[type=interaction,tag=ParkourLobbyLeave] run
  execute on attacker run function infinite_parkour:tick_portal/teleport_out
  execute on target run function infinite_parkour:tick_portal/teleport_out
  data remove entity @s attack
  data remove entity @s interaction
#In the future, make the above save the player inventory before tp into infinite parkour, and restore on the way out.
#Also, store the location of the TP that brought each player in, so that they can target that one on the way out

/fetch
  $data modify storage infinite_parkour:player_data current set from storage infinite_parkour:player_data players[{UUID:$(UUID)}]
  $data remove storage infinite_parkour:player_data players[{UUID:$(UUID)}]

/teleport
  $execute in $(dimension) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)

/teleport_out
  # fetch data
  function infinite_parkour:tick_portal/fetch with entity @s

  # retrieve inventory0
  data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory0

  # unload inventory0
  item replace entity @s container.0 from block 0 0 0 container.0
  item replace entity @s container.1 from block 0 0 0 container.1
  item replace entity @s container.2 from block 0 0 0 container.2
  item replace entity @s container.3 from block 0 0 0 container.3
  item replace entity @s container.4 from block 0 0 0 container.4
  item replace entity @s container.5 from block 0 0 0 container.5
  item replace entity @s container.6 from block 0 0 0 container.6
  item replace entity @s container.7 from block 0 0 0 container.7
  item replace entity @s container.8 from block 0 0 0 container.8
  item replace entity @s container.9 from block 0 0 0 container.9
  item replace entity @s container.10 from block 0 0 0 container.10
  item replace entity @s container.11 from block 0 0 0 container.11
  item replace entity @s container.12 from block 0 0 0 container.12
  item replace entity @s container.13 from block 0 0 0 container.13
  item replace entity @s container.14 from block 0 0 0 container.14
  item replace entity @s container.15 from block 0 0 0 container.15
  item replace entity @s container.16 from block 0 0 0 container.16
  item replace entity @s container.17 from block 0 0 0 container.17
  item replace entity @s container.18 from block 0 0 0 container.18
  item replace entity @s container.19 from block 0 0 0 container.19
  item replace entity @s container.20 from block 0 0 0 container.20
  item replace entity @s container.21 from block 0 0 0 container.21
  item replace entity @s container.22 from block 0 0 0 container.22
  item replace entity @s container.23 from block 0 0 0 container.23
  item replace entity @s container.24 from block 0 0 0 container.24
  item replace entity @s container.25 from block 0 0 0 container.25
  item replace entity @s container.26 from block 0 0 0 container.26

  # retrieve inventory1
  data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.inventory1

  # unload inventory1
  item replace entity @s container.27 from block 0 0 0 container.0
  item replace entity @s container.28 from block 0 0 0 container.1
  item replace entity @s container.29 from block 0 0 0 container.2
  item replace entity @s container.30 from block 0 0 0 container.3
  item replace entity @s container.31 from block 0 0 0 container.4
  item replace entity @s container.32 from block 0 0 0 container.5
  item replace entity @s container.33 from block 0 0 0 container.6
  item replace entity @s container.34 from block 0 0 0 container.7
  item replace entity @s container.35 from block 0 0 0 container.8
  item replace entity @s armor.head from block 0 0 0 container.9
  item replace entity @s armor.chest from block 0 0 0 container.10
  item replace entity @s armor.legs from block 0 0 0 container.11
  item replace entity @s armor.feet from block 0 0 0 container.12
  item replace entity @s weapon.offhand from block 0 0 0 container.13
  item replace entity @s weapon.offhand from block 0 0 0 container.14
  item replace entity @s player.cursor from block 0 0 0 container.15

  # retrieve enderchest
  data modify block 0 0 0 Items set from storage infinite_parkour:player_data current.enderchest

  # unload enderchest
  item replace entity @s enderchest.0 from block 0 0 0 container.0
  item replace entity @s enderchest.1 from block 0 0 0 container.1
  item replace entity @s enderchest.2 from block 0 0 0 container.2
  item replace entity @s enderchest.3 from block 0 0 0 container.3
  item replace entity @s enderchest.4 from block 0 0 0 container.4
  item replace entity @s enderchest.5 from block 0 0 0 container.5
  item replace entity @s enderchest.6 from block 0 0 0 container.6
  item replace entity @s enderchest.7 from block 0 0 0 container.7
  item replace entity @s enderchest.8 from block 0 0 0 container.8
  item replace entity @s enderchest.9 from block 0 0 0 container.9
  item replace entity @s enderchest.10 from block 0 0 0 container.10
  item replace entity @s enderchest.11 from block 0 0 0 container.11
  item replace entity @s enderchest.12 from block 0 0 0 container.12
  item replace entity @s enderchest.13 from block 0 0 0 container.13
  item replace entity @s enderchest.14 from block 0 0 0 container.14
  item replace entity @s enderchest.15 from block 0 0 0 container.15
  item replace entity @s enderchest.16 from block 0 0 0 container.16
  item replace entity @s enderchest.17 from block 0 0 0 container.17
  item replace entity @s enderchest.18 from block 0 0 0 container.18
  item replace entity @s enderchest.19 from block 0 0 0 container.19
  item replace entity @s enderchest.20 from block 0 0 0 container.20
  item replace entity @s enderchest.21 from block 0 0 0 container.21
  item replace entity @s enderchest.22 from block 0 0 0 container.22
  item replace entity @s enderchest.23 from block 0 0 0 container.23
  item replace entity @s enderchest.24 from block 0 0 0 container.24
  item replace entity @s enderchest.25 from block 0 0 0 container.25
  item replace entity @s enderchest.26 from block 0 0 0 container.26

  # clear chest
  data remove block 0 0 0 Items

  # teleport
  function infinite_parkour:tick_portal/teleport with storage infinite_parkour:player_data current.position

  # clean
  data remove storage infinite_parkour:player_data current

/teleport_in
  # store UUID
  data modify storage infinite_parkour:player_data current.UUID set from entity @s UUID

  # load inventory0
  item replace block 0 0 0 container.0 from entity @s container.0
  item replace block 0 0 0 container.1 from entity @s container.1
  item replace block 0 0 0 container.2 from entity @s container.2
  item replace block 0 0 0 container.3 from entity @s container.3
  item replace block 0 0 0 container.4 from entity @s container.4
  item replace block 0 0 0 container.5 from entity @s container.5
  item replace block 0 0 0 container.6 from entity @s container.6
  item replace block 0 0 0 container.7 from entity @s container.7
  item replace block 0 0 0 container.8 from entity @s container.8
  item replace block 0 0 0 container.9 from entity @s container.9
  item replace block 0 0 0 container.10 from entity @s container.10
  item replace block 0 0 0 container.11 from entity @s container.11
  item replace block 0 0 0 container.12 from entity @s container.12
  item replace block 0 0 0 container.13 from entity @s container.13
  item replace block 0 0 0 container.14 from entity @s container.14
  item replace block 0 0 0 container.15 from entity @s container.15
  item replace block 0 0 0 container.16 from entity @s container.16
  item replace block 0 0 0 container.17 from entity @s container.17
  item replace block 0 0 0 container.18 from entity @s container.18
  item replace block 0 0 0 container.19 from entity @s container.19
  item replace block 0 0 0 container.20 from entity @s container.20
  item replace block 0 0 0 container.21 from entity @s container.21
  item replace block 0 0 0 container.22 from entity @s container.22
  item replace block 0 0 0 container.23 from entity @s container.23
  item replace block 0 0 0 container.24 from entity @s container.24
  item replace block 0 0 0 container.25 from entity @s container.25
  item replace block 0 0 0 container.26 from entity @s container.26

  # store inventory0
  data modify storage infinite_parkour:player_data current.inventory0 set from block 0 0 0 Items
  data remove block 0 0 0 Items

  # load inventory1
  item replace block 0 0 0 container.0 from entity @s container.27
  item replace block 0 0 0 container.1 from entity @s container.28
  item replace block 0 0 0 container.2 from entity @s container.29
  item replace block 0 0 0 container.3 from entity @s container.30
  item replace block 0 0 0 container.4 from entity @s container.31
  item replace block 0 0 0 container.5 from entity @s container.32
  item replace block 0 0 0 container.6 from entity @s container.33
  item replace block 0 0 0 container.7 from entity @s container.34
  item replace block 0 0 0 container.8 from entity @s container.35
  item replace block 0 0 0 container.9 from entity @s armor.head
  item replace block 0 0 0 container.10 from entity @s armor.chest
  item replace block 0 0 0 container.11 from entity @s armor.legs
  item replace block 0 0 0 container.12 from entity @s armor.feet
  item replace block 0 0 0 container.13 from entity @s weapon.offhand
  item replace block 0 0 0 container.14 from entity @s weapon.offhand
  item replace block 0 0 0 container.15 from entity @s player.cursor

  # store inventory1
  data modify storage infinite_parkour:player_data current.inventory1 set from block 0 0 0 Items
  data remove block 0 0 0 Items

  # load enderchest
  item replace block 0 0 0 container.0 from entity @s enderchest.0
  item replace block 0 0 0 container.1 from entity @s enderchest.1
  item replace block 0 0 0 container.2 from entity @s enderchest.2
  item replace block 0 0 0 container.3 from entity @s enderchest.3
  item replace block 0 0 0 container.4 from entity @s enderchest.4
  item replace block 0 0 0 container.5 from entity @s enderchest.5
  item replace block 0 0 0 container.6 from entity @s enderchest.6
  item replace block 0 0 0 container.7 from entity @s enderchest.7
  item replace block 0 0 0 container.8 from entity @s enderchest.8
  item replace block 0 0 0 container.9 from entity @s enderchest.9
  item replace block 0 0 0 container.10 from entity @s enderchest.10
  item replace block 0 0 0 container.11 from entity @s enderchest.11
  item replace block 0 0 0 container.12 from entity @s enderchest.12
  item replace block 0 0 0 container.13 from entity @s enderchest.13
  item replace block 0 0 0 container.14 from entity @s enderchest.14
  item replace block 0 0 0 container.15 from entity @s enderchest.15
  item replace block 0 0 0 container.16 from entity @s enderchest.16
  item replace block 0 0 0 container.17 from entity @s enderchest.17
  item replace block 0 0 0 container.18 from entity @s enderchest.18
  item replace block 0 0 0 container.19 from entity @s enderchest.19
  item replace block 0 0 0 container.20 from entity @s enderchest.20
  item replace block 0 0 0 container.21 from entity @s enderchest.21
  item replace block 0 0 0 container.22 from entity @s enderchest.22
  item replace block 0 0 0 container.23 from entity @s enderchest.23
  item replace block 0 0 0 container.24 from entity @s enderchest.24
  item replace block 0 0 0 container.25 from entity @s enderchest.25
  item replace block 0 0 0 container.26 from entity @s enderchest.26

  # store enderchest
  data modify storage infinite_parkour:player_data current.enderchest set from block 0 0 0 Items
  data remove block 0 0 0 Items

  # clear inventory
  clear @s

  # clear enderchest
  item replace entity @s enderchest.0 with air
  item replace entity @s enderchest.1 with air
  item replace entity @s enderchest.2 with air
  item replace entity @s enderchest.3 with air
  item replace entity @s enderchest.4 with air
  item replace entity @s enderchest.5 with air
  item replace entity @s enderchest.6 with air
  item replace entity @s enderchest.7 with air
  item replace entity @s enderchest.8 with air
  item replace entity @s enderchest.9 with air
  item replace entity @s enderchest.10 with air
  item replace entity @s enderchest.11 with air
  item replace entity @s enderchest.12 with air
  item replace entity @s enderchest.13 with air
  item replace entity @s enderchest.14 with air
  item replace entity @s enderchest.15 with air
  item replace entity @s enderchest.16 with air
  item replace entity @s enderchest.17 with air
  item replace entity @s enderchest.18 with air
  item replace entity @s enderchest.19 with air
  item replace entity @s enderchest.20 with air
  item replace entity @s enderchest.21 with air
  item replace entity @s enderchest.22 with air
  item replace entity @s enderchest.23 with air
  item replace entity @s enderchest.24 with air
  item replace entity @s enderchest.25 with air
  item replace entity @s enderchest.26 with air

  # store position
  data modify storage infinite_parkour:player_data current.position.dimension set from entity @s Dimension
  data modify storage infinite_parkour:player_data current.position.x set from entity @s Pos[0]
  data modify storage infinite_parkour:player_data current.position.y set from entity @s Pos[1]
  data modify storage infinite_parkour:player_data current.position.z set from entity @s Pos[2]
  data modify storage infinite_parkour:player_data current.position.yaw set from entity @s Rotation[0]
  data modify storage infinite_parkour:player_data current.position.pitch set from entity @s Rotation[1]

  # append to players
  data modify storage infinite_parkour:player_data players append from storage infinite_parkour:player_data current
  data remove storage infinite_parkour:player_data current

  # teleport in
  tp @s 0 100 0