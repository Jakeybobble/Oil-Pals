/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Fishman";
hp = 15;
maxhp = 15;
spd = 10;
movespace = 2;

faceicon = spr_face_jakey;

function doConditions(hasmoved){
	brain.nextaction = 0;
	brain.movingtype = MovingType.randomAligned_diagonal;
	
	var shortest = 1000;
	for(var xx = 0; xx < ds_list_size(GH.pawns); xx++){
		if(GH.pawns[|xx].is_player){
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
}

var a = new Attack(AttackType.water,spr_watericon);
var b = new Attack(AttackType.water,spr_watericon);

a.perform = function(_tile){
	if(_tile.stander != noone){
		_tile.stander.takeDamage(1);
		swapTiles(_tile.stander);
		setToWater(_tile);
	}
}
b.perform = function(_tile){
	setToWater(_tile);
	if(_tile.stander != noone){
		if(_tile.stander != self){
		_tile.stander.takeDamage(2);
		}
	}
}


move1 = new Ability();
move1.pattern = [
	[a]
];
move1.is_distant = true;
move1.setInfo("Chain Spear","Deal water damage and swap location with random enemy.");

move2 = new Ability();
move2.pattern = [
	[b,0,0,0,b],
	[0,b,0,b,0],
	[0,0,0,0,0],
	[0,b,0,b,0],
	[b,0,0,0,b]
];
move2.setInfo("X", "Deal water damage in a diagonal pattern.");
move2.setCenter(2,2);


ds_list_add(actions, move1, move2);