/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Pond";
desc = "Your friendly neighborhood pond. Spreads joy (and water)."
hp = 11;
maxhp = 11;
spd = 5;
movespace = 3;

faceicon = spr_face_pond;

move1 = global.abilities[?"bambooartillery"];
move2 = global.abilities[?"tsunami"];
move3 = global.abilities[?"extinguisher"];

ds_list_add(actions, move1, move2, move3);