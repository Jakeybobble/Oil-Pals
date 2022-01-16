/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Evil Brigade Boy";
hp = 6;
maxhp = 6;
spd = 5;
movespace = 3;

cid = 6;

//actions = ds_list_create();

var a = new Attack(1,AttackType.normal,spr_noneicon);
var b = new Attack(7,AttackType.fire,spr_fireyicon);
b.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(7);
	}
}
var c = new Attack(2,AttackType.fire,spr_fireyicon);
c.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
var d = new Attack(3,AttackType.fire,spr_fireyicon);
d.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}
a.perform = function(tile){
	show_debug_message("Hey, it's working");
}

move1 = new Action();
move1.pattern = [
	[0,0,0,0,b]
];
move1.ability_icon_id = 18;
move1.centerx = 0; move1.centery = -1;
move1.name = "Sizzling Sniper";
move1.description = "Extreme damage, but hard to aim.";

move2 = new Action();
move2.pattern = [
	[c,c,c,c,c]
];
move2.ability_icon_id = 19;
move2.centerx = 0; move2.centery = -1;
move2.name = "Lava Cannon";
move2.description= "Shoots a large low damage beam, leaving fire.";

move3 = new Action();
move3.pattern = [
	[d],
	[d],
	[d]
];
move3.ability_icon_id = 20;
move3.centery = -1;
move3.centerx = 1;
move3.name = "Magma Splash";
move3.description = "Medium damage, close range."

ds_list_add(actions, move1, move2, move3);