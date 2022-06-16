/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Griffin";
desc = "It's Griffin."
hp = 1111111;
maxhp = hp;
spd = 0;
movespace = 10;

faceicon = spr_face_griffin;

move1 = global.abilities[?"oilslap"];
move2 = global.abilities[?"oilguzzle"];
move3 = global.abilities[?"oildrool"];

ds_list_add(actions, move1, move2, move3);