/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Egghead";
hp = 15;
maxhp = 15;
spd = 10;
movespace = 2;

faceicon = spr_face_jakey;

//actions = ds_list_create();

var a = new Attack(AttackType.fire,spr_fireyicon);

a.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(1);
	}
}


move1 = new Ability();
move1.pattern = [
	[a]
];
move1.is_distant = false;
move1.name = "Egg it up";
move1.description = "Very eggy.";


ds_list_add(actions, move1);