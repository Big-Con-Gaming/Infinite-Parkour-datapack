#This macro places all of the trail particles in between the blocks. X Y Z indicates the ParkourGeneratedJump location (the 2nd next jump),
#Source X Y and Z indicate ParkourNextJump location (the next block to jump to)
#Player X Y and Z indicate the player's current location (could be changed in the future to just be the block the player is currently standing on)
$execute positioned $(PlayerX) $(PlayerY) $(PlayerZ) run particle trail{color:[1.0,0.8,0.0],target:[$(SourceX),$(SourceY),$(SourceZ)]} ~ ~-0.5 ~ 0 0 0 0.5 0 normal
$particle trail{color:[1.0,0.8,0.0],target:[$(X),$(Y),$(Z)]} $(SourceX) $(SourceY) $(SourceZ) 0 0 0 0.5 0 normal