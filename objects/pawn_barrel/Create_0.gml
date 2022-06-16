/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Barrel";
desc = "The sheriff of the oil rig. Can light fires with his cigarette as well as use oil."
hp = 15;
maxhp = 15;
spd = 3;
movespace = 3;

faceicon = spr_face_barrel;

//actions = ds_list_create();

var a = new Attack(4,AttackType.fire,spr_fireyicon);
var b = new Attack(2,AttackType.oil,spr_oilyicon);
var c = new Attack(3,AttackType.oil,spr_oilyicon);
b.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
a.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(4);
	}
}
c.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

move1 = global.abilities[?"cigarettetoss"];
move2 = global.abilities[?"oilartillery"];
move3 = global.abilities[?"oilspray"];

ds_list_add(actions, move1, move2, move3);