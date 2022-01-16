/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Oven Mitt";
hp = 10;
maxhp = 10;
spd = 5;
movespace = 3;

cid = 8;

//actions = ds_list_create();

var a = new Attack(0,AttackType.normal,spr_specialicon);
var b = new Attack(5,AttackType.normal,spr_noneicon);
var c = new Attack(3,AttackType.fire,spr_fireyicon);
b.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(5);
		setToFire(tile);
	}
}
a.perform = function(tile){
	if(tile.status != TileStatus.clear){
		tile.status = TileStatus.clear;
	}
}
c.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}

move1 = new Action();
move1.pattern = [
	[a]
];
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 24;

move1.name = "Absorbtion";
move1.description = "Clears any terrain on the spot you are standing on.";

move2 = new Action();
move2.pattern = [
	[0,b]
];
move2.ability_icon_id = 25;
move2.centery = 0;
move2.centerx = 0;

move2.name = "Body Slam";
move2.description = "Deals high damage. If it hits, spawn a flame.";

move3 = new Action();
move3.pattern = [
	[0,c]
];
move3.ability_icon_id = 26;
move3.centerx = 0; move3.centery = 0;

move3.name = "Human(?) Lighter";
move3.description = "Spawns a flame.";

ds_list_add(actions, move1, move2, move3);