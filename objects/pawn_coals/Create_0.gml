/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

is_player = true;
name = "Coals";
desc = "A group of mischevous coal monsters. Can hop anywhere, but leaves fire where they go."
hp = 6;
maxhp = 6;
spd = 7;
movespace = 2;

faceicon = spr_face_coals;

fireimmunity = true;

move1 = global.abilities[?"hop"];
move2 = global.abilities[?"flamewhistle"];
move3 = global.abilities[?"ignite"];

ds_list_add(actions, move1, move2, move3);