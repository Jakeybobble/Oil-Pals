/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Ball";
hp = 10;
maxhp = 10;
spd = 5;
movespace = 4;

//actions = ds_list_create();

var a = new Attack(4,AttackType.normal,spr_noneicon);
var c = new Attack(3,AttackType.normal,spr_noneicon);
var b = new Attack(0,AttackType.water,spr_watericon);
var d = new Attack(0,AttackType.normal,spr_specialicon);

b.perform = function(tile){
	setToWater(tile);
}
a.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(4);
	}
}
c.perform = function(tile){
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}
d.perform = function(tile){
	if(tile.status == TileStatus.water){
		tile.status = TileStatus.clear;
		hp++;
	}
}

move1 = new Action();
move1.pattern = [
	[b,b,b],
	[b,0,a],
	[b,b,b]
];
move1.centerx = 1; move1.centery = 1;
move1.ability_icon_id = 15;

move1.name = "Soggy Chomp";
move1.description = "High damage and spews water where not attacking.";

move2 = new Action();
move2.pattern = [
	[d]

];
move2.ability_icon_id = 16;
move2.centery = 0;
move2.centerx = 0;

move2.name = "Osmosis";
move2.description = "Absorb water it is standing on. Heal if successful.";

move3 = new Action();
move3.pattern = [
	[0,c,c,c]
];
move3.ability_icon_id = 17;

move3.name = "Smash";
move3.description = "Medium damage, medium range attack.";

ds_list_add(actions, move1, move2, move3);