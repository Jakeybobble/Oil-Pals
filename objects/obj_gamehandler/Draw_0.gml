/// @description A piece of code.
// Written by Jacob.

grid.drawTiles(gridpos_x, gridpos_y);

var mx = mouse_x; var my = mouse_y;
var px = (mx div TS)- gridpos_x/TS; var py = (my div TS) - gridpos_y/TS;

var rectx = gridpos_x + px*TS;
var recty = gridpos_y + py*TS;
draw_rectangle(rectx,recty,rectx+TS,recty+TS,true);

if(mouse_check_button_pressed(mb_left)){
	var p = pawns[|whoseturn];
	if(px >= 0 && px < array_length(grid.tiles)){
		if(py >= 0 && py < array_length(grid.tiles[0])){
			pawn_moving = true;
			pawn_moving_x = px;
			pawn_moving_y = py;
		}
	}
	
	
}