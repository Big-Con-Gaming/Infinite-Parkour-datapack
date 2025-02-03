execute as @a[scores={BugFix=1..}] in infinite_parkour:editor run tp @s 31.67 32.00 -9.34 0.90 0.30
execute as @a[scores={BugFix=1..}] run reload
scoreboard players set @a BugFix 0
schedule function infinite_parkour:bugfix 5t