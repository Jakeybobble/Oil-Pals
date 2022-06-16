/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Griffin";
desc = "It's Griffin."
hp = 1111111;
maxhp = hp;
spd = 0;
movespace = 10;

faceicon = spr_face_griffin;

move1 = global.abilities[?"oilslap"];
move2 = global.abilities[?"oilguzzle"];
move3 = global.abilities[?"oildrool"];

brain.movingtype = MovingType.loveOil;
brain.willreconsider = true;

function doConditions(hasmoved){
	brain.nextaction = choose(0,2);
	brain.movingtype = MovingType.loveOil;
	if(hasmoved){
		if(tile.status == TileStatus.oil){
			brain.nextaction = 1;
		}
	}
	
	
	
	/*
	brain.movingtype = MovingType.randomAligned_diagonal;
	
	var shortest = 1000;
	for(var xx = 0; xx < ds_list_size(GH.pawns); xx++){
		if(!GH.pawns[|xx].isMate(self)){
			var dis = getBiggestDistance(self,GH.pawns[|xx]);
			if(dis < shortest){
				shortest = dis;
			}
		}
	}
	if(shortest > 2){
		brain.nextaction = 0;
	}else{
		brain.nextaction = 1;
	}
	*/
}

ds_list_add(actions, move1, move2, move3);