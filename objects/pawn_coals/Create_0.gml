/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Coals";
hp = 5;
maxhp = 5;
spd = 5;
movespace = 2;

cid = 7;

//actions = ds_list_create();

var a = new Attack(0,AttackType.normal,spr_specialicon);
var b = new Attack(3,AttackType.fire,spr_fireyicon);
var c = new Attack(0,AttackType.fire,spr_fireyicon);
var d = new Attack(0,AttackType.normal,spr_specialicon);
b.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(3);
	}
}
a.perform = function(_t){
	if(!_t.occupied){
		setToTile(_t.x,_t.y)
	}
}
c.perform = function(tile){
	setToFire(tile);
}
d.perform = function(tile){
	setToFire(tile);
}

move1 = new Action();
move1.pattern = [
	[c,c,c],
	[c,a,c],
	[c,c,c]
];
move1.centerx = 1; move1.centery = 1;
move1.ability_icon_id = 21;
move1.is_distant = true;

move1.name = "Hop";
move1.description = "Jump to a location and spawn fire in adjacent tiles. (dont click on enemies pls)";

move2 = new Action();
move2.pattern = [
	[b,b,b]
];
move2.ability_icon_id = 22;
move2.centery = -1;
move2.centerx = 0;

move2.name = "Flamewhistle";
move2.description = "Spawns a row of flames and deals medium damage.";

move3 = new Action();
move3.pattern = [
	[d]
];
move3.ability_icon_id = 23;
move3.centerx = 0; move3.centery = 0;

move3.name = "Ignite";
move3.description = "When standing on a flame, absorb it and heal.";

ds_list_add(actions, move1, move2, move3);