/shulker
  data modify storage infinite_parkour:calc UUID set from entity @s UUID
  execute positioned ~5 ~5 ~5 summon shulker_bullet run
    data modify entity @s Target set from storage infinite_parkour:calc UUID
    data modify entity @s HasBeenShot set value 1
    data modify entity @s LeftOwner set value 1
    data modify entity @s Steps set value 100
  data remove storage infinite_parkour:calc UUID