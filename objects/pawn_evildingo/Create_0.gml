/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Evil Dingo";
hp = 5;
spd = 5;
movespace = 3;

//actions = ds_list_create();

var a = new Attack(2,AttackType.normal);
move1 = new Action();
move1.pattern = [
	[0,a,a,0,0,a,a,a],
	[a,0,0,a,a,a,a,a],
	[0,a,a,0,0,a,a,a]
];
move1.centerx = 1; move1.centery = 1;

ds_list_add(actions, move1);