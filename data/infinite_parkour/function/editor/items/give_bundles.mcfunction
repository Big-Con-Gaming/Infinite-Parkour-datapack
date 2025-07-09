data modify storage infinite_parkour:macro bundle.increment set value 0
data modify storage infinite_parkour:macro bundle.incrementnext set value 1
data modify storage infinite_parkour:macro bundle.length set from storage infinite_parkour:editor_bundles_dictionary everything.length
data modify storage infinite_parkour:macro bundle.editor_bundles_dictionary set from storage infinite_parkour:editor_bundles_dictionary everything
data modify storage infinite_parkour:macro bundle merge from storage infinite_parkour:macro bundle.editor_bundles_dictionary.0
function infinite_parkour:editor/items/internal8 with storage infinite_parkour:macro bundle
data remove storage infinite_parkour:macro bundle
scoreboard players reset #increment ip_data
scoreboard players reset #test ip_data
function infinite_parkour:editor/items/give_bundle {slot:'17',color:'pink',name:'Modifiers',i:'8',inside:',"ipe_place_inside"', model0:'barrier',name0:'Delete',lore0:'{text:"A quick way to clean up elements",italic:false,color:"gray"}', model1:'redstone',name1:'Trail',lore1:'{text:"Creates a trail between blocks",italic:false,color:"gray"},{text:"To remove break the starting block",italic:false,color:"gray"}', model2:'air',name2:'2',lore2:'', model3:'air',name3:'3',lore3:'', model4:'air',name4:'4',lore4:'', model5:'air',name5:'5',lore5:'', model6:'air',name6:'6',lore6:'', model7:'air',name7:'7',lore7:'', model8:'air',name8:'8',lore8:'', model9:'air',name9:'9',lore9:'', modela:'air',namea:'a',lorea:'', modelb:'air',nameb:'b',loreb:'' }