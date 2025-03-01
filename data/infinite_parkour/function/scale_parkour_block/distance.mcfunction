$data modify entity @s transformation set value [$(dx)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,$(dz)f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,1.0f]
execute store result score d1 math run data get entity @s transformation.scale[0] 100
kill @s