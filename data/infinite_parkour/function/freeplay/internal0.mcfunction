place template infinite_parkour:freeplay_top ~-15 ~-11 ~-15
place template infinite_parkour:freeplay_bottom ~-15 ~-42 ~-15
function infinite_parkour:freeplay/setup_first_jump
summon text_display ~-6.49 3.2 0.5 {text:{color:"yellow",text:"Settings"},transformation:{translation:[0,0,0],scale:[2,2,2],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon text_display ~-6.49 2.5 0.5 {text:{color:"white",text:"Decorations"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon text_display ~-6.49 2.2 0.5 {text:{color:"green",text:"on"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon interaction ~-6.6 2.2 0.5 {width:0.4,height:0.25}
summon text_display ~-6.49 1.6 0.5 {text:{color:"white",text:"JumpPack"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon text_display ~-6.49 1.3 0.5 {text:{color:"blue",text:"loading..."},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon text_display ~-6.49 1.3 2.0 {text:{color:"green",text:"\u2190"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon text_display ~-6.49 1.3 -1.0 {text:{color:"green",text:"\u2192"},transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:{angle:1.57079,axis:[0,1,0]}}}
summon interaction ~-6.6 1.3 2.0 {width:0.4,height:0.25}
summon interaction ~-6.6 1.3 -1.0 {width:0.4,height:0.25}
summon text_display ~13.0 1.6 0.5 {billboard:"vertical",text:[{color:"aqua",text:"Teleport to the "},{color:"dark_aqua",text:"Editor"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}}
summon interaction ~13.0 0.0 0.5 {width:2,height:2}
summon text_display ~-3.0 1.6 -5.5 {billboard:"vertical",text:[{color:"red",text:"Youtube Channel"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}}
summon interaction ~-3.05 0.0 -5.55 {width:1.1,height:2,Tags:["_ip_interaction","freeplay/credit_youtube"]}
summon text_display ~3.0 1.6 -5.5 {billboard:"vertical",text:[{color:"#5662F6",text:"Discord Server"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}}
summon interaction ~2.95 0.0 -5.55 {width:1.1,height:2,Tags:["_ip_interaction","freeplay/credit_discord"]}
summon text_display ~-1.0 1.6 -7.5 {billboard:"vertical",text:[{color:"green",text:"OfekN"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}}
summon text_display ~1.0 1.6 -7.5 {billboard:"vertical",text:[{color:"green",text:"Big_Con__"}],transformation:{translation:[0,0,0],scale:[1,1,1],left_rotation:[0,0,0,1],right_rotation:[0,0,0,1]}}
execute positioned ~-7.0 0 4.5 run function infinite_parkour:freeplay/internal0/builder {color:"#5662F6","angle":0.78539,name:"Join us!",title:"on discord",interaction:"credit_discord"}
execute positioned ~-5.0 0 3.5 run function infinite_parkour:freeplay/internal0/builder {color:"#5662F6","angle":0,name:"Join us!",title:"on discord",interaction:"credit_discord"}
execute positioned ~-5.0 0 7.5 run function infinite_parkour:freeplay/internal0/builder {color:"#5662F6","angle":3.14159,name:"Join us!",title:"on discord",interaction:"credit_discord"}
execute positioned ~-3.0 0 3.5 run function infinite_parkour:freeplay/internal0/builder {color:"#ebd68f","angle":0,name:"lags_kills",title:"Suggestor",interaction:"credit_lags"}
execute positioned ~-1.0 0 5.5 run function infinite_parkour:freeplay/internal0/builder {color:"#eb8f8f","angle":-1.57079,name:"Flaming_Thunder_",title:"Head Builder",interaction:"credit_flaming"}
execute positioned ~-3.0 0 7.5 run function infinite_parkour:freeplay/internal0/builder {color:"#ebe58f","angle":3.14159,name:"2s2s",title:"Build Helper",interaction:"credit_2s2s"}