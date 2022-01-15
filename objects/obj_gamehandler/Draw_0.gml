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

if(mouse_check_button_pressed(mb_right)){
	var p = pawns[|whoseturn];
	var pdir = point_direction(p.x,p.y,mouse_x,mouse_y);
	var d = floor(((pdir + 45) mod 360)/90);
	var newdir = (d +1 mod 3);
	var action = p.actions[|0];
	//var action = new Action();
	action.perform(p.tile.x,p.tile.y,newdir);
	
}

for(var xx = 0; xx < ds_list_size(pawns); xx++){
	var p = pawns[|xx];
	if(p.is_player){
		var s = sin(current_time/200)*15;
		draw_sprite_ext(p.faceicon,0,32,room_height-48,1.4,1.4,s,c_white,1);
	}
}