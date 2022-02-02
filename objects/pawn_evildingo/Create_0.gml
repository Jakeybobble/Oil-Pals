/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Oilman";
desc = "Big fan of oil. It's his favorite drink."
hp = 11;
maxhp = 7;
spd = 3;
movespace = 4;

faceicon = spr_face_oilman;

move1 = global.abilities[?"oilslap"];
move2 = global.abilities[?"oilguzzle"];
move3 = global.abilities[?"oildrool"];

ds_list_add(actions, move1, move2, move3);