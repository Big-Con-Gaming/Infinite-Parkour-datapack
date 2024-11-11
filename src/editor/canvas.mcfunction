execute as @a at @s if dimension infinite_parkour:editor
  return 0

execute as @e[tag=InfParCanvas] at @s positioned ~31 31 ~31
  execute if block ~ ~ ~ air
    setblock ~ ~-1 ~ bedrock
    execute as @n[type=shulker,distance=..1] run function infinite_parkour:utils/silent_kill
    execute unless entity @n[type=minecraft:text_display,distance=..1] run summon minecraft:text_display ~0.5 ~0.5 ~0.5 {text:'"Place starting block"',billboard:"center"}
  execute unless block ~ ~ ~ air
    execute if block ~ ~-1 ~ minecraft:bedrock run setblock ~ ~-1 ~ air
    execute unless entity @n[type=shulker,distance=..1] run summon minecraft:shulker ~ ~0.001 ~ {NoAI:1b,Glowing:1b,Invulnerable:1b,active_effects:[{id:invisibility,duration:-1,show_particles:0b}],attributes:[{id:"minecraft:scale",base:0.998d}]}
    kill @n[type=minecraft:text_display,distance=..1]


/create
  execute align xyz run summon marker ~ ~ ~ {Tags:["InfParCanvas"],data:{name:"Canvas"}}
  fill ~ -1 ~ ~63 -1 ~63 black_concrete
  fill ~-1 0 ~-1 ~64 63 ~-1 white_concrete
  fill ~-1 0 ~-1 ~-1 63 ~64 white_concrete
  fill ~64 0 ~64 ~64 63 ~-1 white_concrete
  fill ~64 0 ~64 ~-1 63 ~64 white_concrete
  fill ~-1 64 ~-1 ~64 64 ~64 light_blue_concrete
  setblock ~31 31 ~31 stone
/delete
  execute as @n[tag=InfParCanvas] at @s
    fill ~-1 -1 ~-1 ~64 -1 ~64 light_gray_concrete
    fill ~-1 0 ~-1 ~64 64 ~64 air
    kill @s
    execute positioned ~31 31 ~31 as @n[type=shulker,distance=..1] run function infinite_parkour:utils/silent_kill
    execute positioned ~31 31 ~31 run kill @n[type=minecraft:text_display,distance=..1]
