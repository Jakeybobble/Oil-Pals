/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Oilman";
hp = 7;
maxhp = 7;
spd = 5;
movespace = 3;

//actions = ds_list_create();

var a = new Attack(1,AttackType.normal,spr_noneicon);
var b = new Attack(3,AttackType.oil,spr_oilyicon);
b.perform = function(tile){
	if(tile.status == TileStatus.clear){
		tile.status = TileStatus.oil;
	}
}
a.perform = function(tile){
	show_debug_message("Hey, it's working");
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
	[0]
];
move2.ability_icon_id = 1;
move2.name = "Oil Can";
move2.description= "Become oiled.";

move3 = new Action();
move3.pattern = [
	[b],
	[b],
	[b]
];
move3.ability_icon_id = 2;
move3.centery = -1;
move3.name = "Oil Drool";
move3.description = "Leaves a high damage oily spit pool in front of you."

ds_list_add(actions, move1, move2, move3);