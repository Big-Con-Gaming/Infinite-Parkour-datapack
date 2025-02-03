@echo off
rmdir "./data/infinite_parkour/function" /s /q
java -jar ./MinecraftScriptJSON.jar ./src ./data/infinite_parkour/function infinite_parkour 2 .
