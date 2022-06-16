/// @description A piece of code.
// Written by Jacob.

// Inherit the parent event
event_inherited();

name = "Cleaverhead";
desc = "Forever doomed to spill his oil blood everywhere he goes. Leaves a trail of oil where he walks."
hp = 7;
maxhp = 7;
spd = 9;
movespace = 4;

faceicon = spr_face_chead;

status.superoiled = 99999;
status.oiled = 999999;

move1 = global.abilities[?"oiledswipe"];
move2 = global.abilities[?"splitskull"];
move3 = global.abilities[?"sneeze"];

ds_list_add(actions, move1, move2, move3);