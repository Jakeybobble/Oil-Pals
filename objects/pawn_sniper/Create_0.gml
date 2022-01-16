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

cid = 13;

//actions = ds_list_create();

var a = new Attack(4,AttackType.fire,spr_fireyicon);
var b = new Attack(2,AttackType.oil,spr_oilyicon);
var c = new Attack(3,AttackType.oil,spr_oilyicon);

a.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(1);
	}
}


move1 = new Action();
move1.pattern = [
	[a]
];
move1.centerx = 0; move1.centery = 0;
move1.ability_icon_id = 6;
move1.is_distant = true;
move1.name = "Cigarette Toss";
move1.description = "Spawns flames and deals high damage.";


ds_list_add(actions, move1);