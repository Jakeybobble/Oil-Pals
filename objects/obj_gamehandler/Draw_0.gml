/// @description A piece of code.
// Written by Jacob.

grid.drawTiles(gridpos_x, gridpos_y);

var mx = mouse_x; var my = mouse_y;
var px = (mx div TS)- gridpos_x/TS; var py = (my div TS) - gridpos_y/TS;

var rectx = gridpos_x + px*TS;
var recty = gridpos_y + py*TS;


if(state == PickState.choosemove){
	draw_rectangle(rectx,recty,rectx+TS,recty+TS,true);

	if(mouse_check_button_pressed(mb_left)){
		var p = pawns[|whoseturn];
		if(px >= 0 && px < array_length(grid.tiles)){
			if(py >= 0 && py < array_length(grid.tiles[0])){
				tile_memory = pawns[|whoseturn].tile;
				pawn_moving = true;
				pawn_moving_x = px;
				pawn_moving_y = py;
			}
		}
	}
}

if(state == PickState.chooseaction){
	var p = pawns[|whoseturn];
	var count = ds_list_size(p.actions);
	for(var xx = 0; xx < count; xx++){
		var action = p.actions[|xx];
		var hovered = false;
		var posx = p.x + 64*xx;
		var posy = p.y + 64;
		var drawcolor = c_white;
		if(point_in_rectangle(mouse_x,mouse_y,posx,posy,posx+32*2,posy+(32*2))){
			drawcolor = c_red;
			hovered = true;
		}
		
		if(mouse_check_button_pressed(mb_left)){
			if(hovered){
				state = PickState.chooseactionposition;
				chosen_action = p.actions[|xx];
				mouse_clear(mb_left);
			}
		}else if(mouse_check_button_pressed(mb_right)){
			p.setToTile(tile_memory.x,tile_memory.y);
			tile_memory = noone;
			state = PickState.choosemove;
			mouse_clear(mb_right);
		}
		
		draw_sprite_ext(spr_abilities,action.ability_icon_id,posx,posy,2,2,0,drawcolor,1);
	}
}

if(state == PickState.chooseactionposition){
	
	var p = pawns[|whoseturn];
	var pdir = point_direction(p.x,p.y,mouse_x,mouse_y);
	var d = floor(((pdir + 45) mod 360)/90);
	var newdir = (d +1 mod 3);
	var action = p.actions[|0];
	var doaction = false;
	if(mouse_check_button_pressed(mb_right)){
		chosen_action = noone;
		state = PickState.chooseaction;
		mouse_clear(mb_right);
	}else if(mouse_check_button_pressed(mb_left)){
		// TO-DO: Set this to performing!
		//state = PickState.performing;
		state = PickState.choosemove;
		doaction = true;
		mouse_clear(mb_left);
	}
	action.preview(p.tile.x,p.tile.y,newdir, doaction);
	
}


for(var xx = 0; xx < ds_list_size(pawns); xx++){
	var p = pawns[|xx];
	if(p.is_player){
		var s = sin(current_time/200)*15;
		draw_sprite_ext(p.faceicon,0,32,room_height-48,1.4,1.4,s,c_white,1);
	}
}