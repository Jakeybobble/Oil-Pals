/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = false;
name = "Bow down for your god";
hp = 999;
maxhp = hp;
spd = 1;
movespace = 3;

cid = 0;

barks.death = ["HA! Nice try.", "I'm not going away that easily...", "lol", "Never gonna happen", "Why don't you try that again?", "Missed me!", "Nope.", "Heyo.", "You know I coded this, right?", ""];
barks.damage = ["Owie.", "Oof.", "Ouch, ow ow.", ":-(", "What the heck.", "Dang brugh."];
barks.sound = sou_laugh;
//barks.freebark("Oh yeaaaaah", x, y);

function onDeath(){
	dead = false;
	hp = maxhp;
	var randx = irandom(GRID.getWidth()-1);
	var randy = irandom(GRID.getHeight()-1);
	setToTile(randx,randy);
	barks.bark(BarkTypes.death,xToWorld(randx)+TS/2,yToWorld(randy)-32);
}

function onEndTurn(){
	hp = maxhp;
}
function onTakeDamage(dmg, type){
	barks.bark(BarkTypes.damage,x,y-32);
}