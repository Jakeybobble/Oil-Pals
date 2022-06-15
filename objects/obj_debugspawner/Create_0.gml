/// @description A piece of code.
// Written by Jacob.

depth = -200;

funny = 0;

function DebugSpawn(_obj,_spr) constructor{
	obj = _obj;
	spr = _spr;
}

d_friend = ds_list_create();
d_naughty = ds_list_create();

ds_list_add(d_friend,
new DebugSpawn(pawn_evildingo,spr_man),
new DebugSpawn(pawn_pond,spr_pond),
new DebugSpawn(pawn_barrel,spr_barrel),
new DebugSpawn(pawn_chead,spr_chead),
new DebugSpawn(pawn_ovenmitt,spr_ovenmitt),
new DebugSpawn(pawn_coals,spr_coals),
new DebugSpawn(pawn_ball,spr_ball),
new DebugSpawn(pawn_bboy,spr_bboy),
new DebugSpawn(pawn_ebboy,spr_evilbboy),
);

ds_list_add(d_naughty,
new DebugSpawn(pawn_tinman,spr_tinman),
new DebugSpawn(pawn_oilball,spr_oilball),
new DebugSpawn(pawn_magmaball,spr_ball39),
new DebugSpawn(pawn_evilbarrel,spr_evilbarrel),
new DebugSpawn(pawn_sniper,spr_sniper),
new DebugSpawn(pawn_fishman,spr_fishman)
);
cursor = 0;
pages = [d_naughty,d_friend];