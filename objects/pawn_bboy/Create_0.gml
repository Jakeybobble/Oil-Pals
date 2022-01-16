/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Brigade Boy";
hp = 5;
maxhp = 5;
spd = 5;
movespace = 4;

cid = 5;

//actions = ds_list_create();

var a = new Attack(1,AttackType.normal,spr_noneicon);
var b = new Attack(7,AttackType.water,spr_watericon);
b.perform = function(tile){
	setToWater(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(7);
	}
}
var c = new Attack(2,AttackType.water,spr_watericon);
c.perform = function(tile){
	setToWater(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
var d = new Attack(3,AttackType.water,spr_watericon);
d.perform = function(tile){
	setToWater(tile);
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
move1.ability_icon_id = 12;
move1.centerx = 0; move1.centery = -1;
move1.name = "Soggy Sniper";
move1.description = "Extreme damage, but hard to aim.";

move2 = new Action();
move2.pattern = [
	[c,c,c,c,c]
];
move2.ability_icon_id = 13;
move2.centerx = 0; move2.centery = -1;
move2.name = "Water Cannon";
move2.description= "Shoots a large low damage beam, leaving puddles behind.";

move3 = new Action();
move3.pattern = [
	[d],
	[d],
	[d]
];
move3.ability_icon_id = 14;
move3.centery = -1;
move3.centerx = 1;
move3.name = "Splash";
move3.description = "Medium damage, close range."

ds_list_add(actions, move1, move2, move3);