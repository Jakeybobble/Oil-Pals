/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Evil Brigade Boy";
desc = "Master of the super scalder. Same as Brigade Boy, but fire-y."
hp = 6;
maxhp = 6;
spd = 7;
movespace = 4;

faceicon = spr_face_ebboy;

move1 = global.abilities[?"sizzlingsniper"];
move2 = global.abilities[?"lavacannon"];
move3 = global.abilities[?"magmasplash"];

ds_list_add(actions, move1, move2, move3);