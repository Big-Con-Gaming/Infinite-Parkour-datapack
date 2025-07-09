$data modify entity @n[type=text_display,distance=..0.1] text set value {color:"blue",text:"$(jumppack_id)"}
$scoreboard objectives add iph_$(jumppack_id) dummy
$scoreboard players operation @a[nbt={UUID:$(player)},distance=0..] ip_highscore = @a[nbt={UUID:$(player)},distance=0..] iph_$(jumppack_id)