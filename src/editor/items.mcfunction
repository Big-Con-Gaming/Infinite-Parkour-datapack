/tick
  execute in infinite_parkour:editor as @a[distance=0..] run
    function infinite_parkour:editor/items/give_bundles
    # function infinite_parkour:editor/items/read_items
    # function infinite_parkour:editor/items/write_items
  execute in infinite_parkour:editor run kill @e[type=item,distance=0..]
  return 0

/read_items
  execute positioned 29 32 -4 run
    execute unless items block ~ ~ ~ container.0 * if items entity @s container.0 * run function infinite_parkour:editor/items/memorize_item {bi:0,pi:0}
    execute unless items block ~ ~ ~ container.1 * if items entity @s container.1 * run function infinite_parkour:editor/items/memorize_item {bi:1,pi:1}
    execute unless items block ~ ~ ~ container.2 * if items entity @s container.2 * run function infinite_parkour:editor/items/memorize_item {bi:2,pi:2}
    execute unless items block ~ ~ ~ container.3 * if items entity @s container.3 * run function infinite_parkour:editor/items/memorize_item {bi:3,pi:3}
    execute unless items block ~ ~ ~ container.4 * if items entity @s container.4 * run function infinite_parkour:editor/items/memorize_item {bi:4,pi:4}
    execute unless items block ~ ~ ~ container.5 * if items entity @s container.5 * run function infinite_parkour:editor/items/memorize_item {bi:5,pi:5}
    execute unless items block ~ ~ ~ container.6 * if items entity @s container.6 * run function infinite_parkour:editor/items/memorize_item {bi:6,pi:6}
    execute unless items block ~ ~ ~ container.7 * if items entity @s container.7 * run function infinite_parkour:editor/items/memorize_item {bi:7,pi:7}
    execute unless items block ~ ~ ~ container.8 * if items entity @s container.8 * run function infinite_parkour:editor/items/memorize_item {bi:8,pi:8}
    execute unless items block ~ ~ ~ container.9 * if items entity @s container.18 * run function infinite_parkour:editor/items/memorize_item {bi:9,pi:18}
    execute unless items block ~ ~ ~ container.10 * if items entity @s container.19 * run function infinite_parkour:editor/items/memorize_item {bi:10,pi:19}
    execute unless items block ~ ~ ~ container.11 * if items entity @s container.20 * run function infinite_parkour:editor/items/memorize_item {bi:11,pi:20}
    execute unless items block ~ ~ ~ container.12 * if items entity @s container.21 * run function infinite_parkour:editor/items/memorize_item {bi:12,pi:21}
    execute unless items block ~ ~ ~ container.13 * if items entity @s container.22 * run function infinite_parkour:editor/items/memorize_item {bi:13,pi:22}
    execute unless items block ~ ~ ~ container.14 * if items entity @s container.23 * run function infinite_parkour:editor/items/memorize_item {bi:14,pi:23}
    execute unless items block ~ ~ ~ container.15 * if items entity @s container.24 * run function infinite_parkour:editor/items/memorize_item {bi:15,pi:24}
    execute unless items block ~ ~ ~ container.16 * if items entity @s container.25 * run function infinite_parkour:editor/items/memorize_item {bi:16,pi:25}
    execute unless items block ~ ~ ~ container.17 * if items entity @s container.26 * run function infinite_parkour:editor/items/memorize_item {bi:17,pi:26}
    execute unless items block ~ ~ ~ container.18 * if items entity @s container.27 * run function infinite_parkour:editor/items/memorize_item {bi:18,pi:27}
    execute unless items block ~ ~ ~ container.19 * if items entity @s container.28 * run function infinite_parkour:editor/items/memorize_item {bi:19,pi:28}
    execute unless items block ~ ~ ~ container.20 * if items entity @s container.29 * run function infinite_parkour:editor/items/memorize_item {bi:20,pi:29}
    execute unless items block ~ ~ ~ container.21 * if items entity @s container.30 * run function infinite_parkour:editor/items/memorize_item {bi:21,pi:30}
    execute unless items block ~ ~ ~ container.22 * if items entity @s container.31 * run function infinite_parkour:editor/items/memorize_item {bi:22,pi:31}
    execute unless items block ~ ~ ~ container.23 * if items entity @s container.32 * run function infinite_parkour:editor/items/memorize_item {bi:23,pi:32}
    execute unless items block ~ ~ ~ container.24 * if items entity @s container.33 * run function infinite_parkour:editor/items/memorize_item {bi:24,pi:33}
    execute unless items block ~ ~ ~ container.25 * if items entity @s container.34 * run function infinite_parkour:editor/items/memorize_item {bi:25,pi:34}
    execute unless items block ~ ~ ~ container.26 * if items entity @s container.35 * run function infinite_parkour:editor/items/memorize_item {bi:26,pi:35}

/write_items
  execute positioned 29 32 -4 run
    item replace entity @s container.0 from block ~ ~ ~ container.0
    item replace entity @s container.1 from block ~ ~ ~ container.1
    item replace entity @s container.2 from block ~ ~ ~ container.2
    item replace entity @s container.3 from block ~ ~ ~ container.3
    item replace entity @s container.4 from block ~ ~ ~ container.4
    item replace entity @s container.5 from block ~ ~ ~ container.5
    item replace entity @s container.6 from block ~ ~ ~ container.6
    item replace entity @s container.7 from block ~ ~ ~ container.7
    item replace entity @s container.8 from block ~ ~ ~ container.8
    item replace entity @s container.18 from block ~ ~ ~ container.9
    item replace entity @s container.19 from block ~ ~ ~ container.10
    item replace entity @s container.20 from block ~ ~ ~ container.11
    item replace entity @s container.21 from block ~ ~ ~ container.12
    item replace entity @s container.22 from block ~ ~ ~ container.13
    item replace entity @s container.23 from block ~ ~ ~ container.14
    item replace entity @s container.24 from block ~ ~ ~ container.15
    item replace entity @s container.25 from block ~ ~ ~ container.16
    item replace entity @s container.26 from block ~ ~ ~ container.17
    item replace entity @s container.27 from block ~ ~ ~ container.18
    item replace entity @s container.28 from block ~ ~ ~ container.19
    item replace entity @s container.29 from block ~ ~ ~ container.20
    item replace entity @s container.30 from block ~ ~ ~ container.21
    item replace entity @s container.31 from block ~ ~ ~ container.22
    item replace entity @s container.32 from block ~ ~ ~ container.23
    item replace entity @s container.33 from block ~ ~ ~ container.24
    item replace entity @s container.34 from block ~ ~ ~ container.25
    item replace entity @s container.35 from block ~ ~ ~ container.26

/memorize_item
  $item replace block ~ ~ ~ container.$(bi) from entity @s container.$(pi)
  $say $(bi)

/give_bundles
  item replace entity @s container.9 with green_bundle[item_name="Blocks",bundle_contents=[
  +{id:"stick",Count:1,components:{item_model:"stone",item_name:"Platform"}},
  +{id:"stick",Count:1,components:{item_model:"tuff",item_name:"Blocker"}},
  +{id:"stick",Count:1,components:{item_model:"ladder",item_name:"Ladder"}},
  +{id:"stick",Count:1,components:{item_model:"slime_block",item_name:"SlimeBlock"}},
  +{id:"stick",Count:1,components:{item_model:"honey_block",item_name:"HoneyBlock"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
  item replace entity @s container.10 with yellow_bundle[item_name="Pickups",bundle_contents=[
  +{id:"stick",Count:1,components:{item_model:"gold_nugget",item_name:"SimplePickup"}},
  +{id:"stick",Count:1,components:{item_model:"emerald",item_name:"AdvancedPickup"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'2'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
  item replace entity @s container.11 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.12 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.13 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.14 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.15 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.16 with white_bundle[item_name="'Future Category'"]
  item replace entity @s container.17 with pink_bundle[item_name="Modifiers",bundle_contents=[
  +{id:"stick",Count:1,components:{item_model:"white_dye",item_name:"'Clear'"}},
  +{id:"stick",Count:1,components:{item_model:"lime_dye",item_name:"'Set Target'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'2'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'3'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'4'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'5'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'6'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'7'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'8'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'9'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'10'"}},
  +{id:"stick",Count:1,components:{item_model:"black_stained_glass_pane",item_name:"'11'"}}
  +]]
