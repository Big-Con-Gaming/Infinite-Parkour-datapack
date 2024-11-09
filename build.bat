@echo off
rmdir "./data/infinite-parkour/function" /s /q
java -jar ./MinecraftScript.jar ./src ./data/infinite-parkour/function infinite-parkour 2
echo Zipping...
tar -acf "Infinite Parkour.zip" data pack.mcmeta