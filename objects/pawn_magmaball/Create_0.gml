/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Magma Ball";
hp = 30;
maxhp = 30;
spd = 6;
movespace = 3;

barks.damage = ["Meow."];

faceicon = spr_face_magmaball;

function onTakeDamage(dmg, type){
	barks.bark(BarkTypes.damage,x,y-32);
}

//actions = ds_list_create();

var a = new Attack(AttackType.normal,spr_noneicon);
var c = new Attack(AttackType.normal,spr_noneicon);
var b = new Attack(AttackType.fire,spr_fireyicon);
var d = new Attack(AttackType.normal,spr_specialicon);
b.perform = function(tile){
	setToFire(tile);
	if(tile.stander != noone){
		tile.stander.takeDamage(2);
	}
}
a.perform = function(tile){
	show_debug_message("Hey, it's working");
}
c.perform = function(tile){
	//dont do the default
}

move1 = new Ability();
move1.pattern = [
	[b,b,b],
	[b,0,b],
	[b,b,b]
];
move1.centerx = 1; move1.centery = 1;
move1.ability_icon_id = 15;

move1.name = "Soggy Chomp";
move1.description = "High damage and spews water where not attacking.";

move2 = new Ability();
move2.pattern = [
	[b,b,b]

];
move2.ability_icon_id = 16;
move2.centery = -1;
move2.centerx = 0;

move2.name = "Osmosis";
move2.description = "Absorb water it is standing on. Heal if successful.";

move3 = new Ability();
move3.pattern = [
	[0]
];
move3.ability_icon_id = 17;

move3.name = "Smash";
move3.description = "Medium damage, medium range attack.";

ds_list_add(actions, move1, move2, move3);