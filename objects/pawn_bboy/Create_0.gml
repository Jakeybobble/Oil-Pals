/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Brigade Boy";
desc = "Master of the super soaker. High damage but frail."
hp = 5;
maxhp = 5;
spd = 7;
movespace = 4;

faceicon = spr_face_bboy;

move1 = global.abilities[?"soggysniper"];
move2 = global.abilities[?"watercannon"];
move3 = global.abilities[?"splash"];

ds_list_add(actions, move1, move2, move3);

brain.movingtype = MovingType.randomAligned_exact;
brain.targetingtype = TargetingType.targetFurthestEnemy;
brain.offset = 5;
brain.willreconsider = true;

function doConditions(hasmoved){
	brain.nextaction = 0;
	if(brain.nextaction == 0){
		brain.willreconsider = false;
	}else{
		brain.willreconsider = true;	
	}
	if(hasmoved){
		brain.nextaction = choose(1,2);
	}
	// Conditions are unique to every enemy... Probably.
	//show_debug_message(GH.wave % 2);
	
}