/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Evil Barrel";
hp = 20;
maxhp = 20;
spd = 5;
movespace = 3;

cid = 12;

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

move1 = new Action();
move1.pattern = [
	[0,0,a]
];
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 6;

move1.name = "Cigarette Toss";
move1.description = "Spawns flames and deals high damage.";

move2 = new Action();
move2.pattern = [
	[c]
];
move2.ability_icon_id = 7;
move2.centery = 0;
move2.centerx = 0;
move2.is_distant = true;

move2.name = "Oil Artillery";
move2.description = "Shoots oil anywhere on the map.";

move3 = new Action();
move3.pattern = [
	[0,b,b,b,b]
];
move3.ability_icon_id = 8;
move3.centerx = 0; move3.centery = 0;

move3.name = "Oil Spray";
move3.description = "Shoots oil a line of oil.";

ds_list_add(actions, move1, move2, move3);