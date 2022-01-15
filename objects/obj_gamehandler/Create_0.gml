/// @description A piece of code.
// Written by Jacob.

depth = 99;

player_turn = true;

gridpos_x = 96;
gridpos_y = 96;

var grid_x = 13; var grid_y = 9; // ((((WIDTH!!!))))
grid = new Grid(gridpos_x, gridpos_y, grid_x, grid_y);

pawns = ds_list_create(); // All pawns, including players
whoseturn = 0;

var coolpawn = instance_create_depth(gridpos_x,gridpos_y, 0, pawn_evildingo);
coolpawn.setToTile(5,5);
ds_list_add(pawns, coolpawn);
//coolpawn.tile = grid.tiles[0,0];

pawn_moving = false;
pawn_moving_x = 0; pawn_moving_y = 0; // Tile moving to

// Lists
pawn_friendly = [obj_pawn,pawn_evildingo];
