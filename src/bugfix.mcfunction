execute as @a[scores={BugFix=1..}] run function #minecraft:tick
scoreboard players set @a BugFix 0
schedule function infinite_parkour:bugfix 5t
