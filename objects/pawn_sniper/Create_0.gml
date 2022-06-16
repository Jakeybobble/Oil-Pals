/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Sniper";
hp = 15;
maxhp = 15;
spd = 10;
movespace = 2;

faceicon = spr_face_sniper;

//actions = ds_list_create();

var a = new Attack(AttackType.fire,spr_fireyicon);
var b = new Attack(AttackType.oil,spr_oilyicon);
var c = new Attack(AttackType.oil,spr_oilyicon);

a.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(1);
	}
}


move1 = new Ability();
move1.pattern = [
	[a]
];
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 6;
move1.is_distant = true;
move1.name = "Cigarette Toss";
move1.description = "Spawns flames and deals high damage.";


ds_list_add(actions, move1);