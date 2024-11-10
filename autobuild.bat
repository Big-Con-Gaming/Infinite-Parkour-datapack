@echo off
rmdir "./data/infinite_parkour/function" /s /q
java -jar ./MinecraftScript.jar ./src ./data/infinite_parkour/function infinite_parkour 2 .
