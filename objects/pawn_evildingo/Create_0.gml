/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Oilman";
desc = "Big fan of oil. It's his favorite drink."
hp = 11;
maxhp = 7;
spd = 3;
movespace = 4;

faceicon = spr_face_oilman;

//actions = ds_list_create();

var a = new Attack(1,AttackType.normal,spr_noneicon);
var b = new Attack(3,AttackType.oil,spr_oilyicon);
var c = new Attack(0,AttackType.oil,spr_specialicon);
b.perform = function(tile){
	setToOil(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(5);
	}
}
a.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(1);
	}
}

c.perform = function(tile){
	if(tile.status == TileStatus.oil){
		tile.status = TileStatus.clear;
		hp+=2;
	}
}

move1 = new Action();
move1.pattern = [
	[0,a,a,b]
];
move1.centerx = 0; move1.centery = 0;
move1.name = "Oil Slap";
move1.description = "Does extra damage on oil spot.";

move2 = new Action();
move2.pattern = [
	[c]
];
move2.ability_icon_id = 1;
move2.name = "Oil Guzzle";
move2.description= "Drink oil from the tile you are standing on, healing you.";

move3 = new Action();
move3.pattern = [
	[b],
	[b],
	[b]
];
move3.ability_icon_id = 2;
move3.centery = -1;
move3.centerx = 1;
move3.name = "Oil Drool";
move3.description = "Leaves a high damage oily spit pool in front of you."

ds_list_add(actions, move1, move2, move3);