execute as @a[scores={BugFix=1..}] at @s run reload
scoreboard players set @a BugFix 0
schedule function infinite_parkour:bugfix 5t