/// @description A piece of code.
// Written by Jacob.

grid.drawTiles(gridpos_x, gridpos_y);

var mx = mouse_x; var my = mouse_y;
var px = (mx div TS)- gridpos_x/TS; var py = (my div TS) - gridpos_y/TS;

var rectx = gridpos_x + px*TS;
var recty = gridpos_y + py*TS;


if(state == PickState.choosemove){
	var p = pawns[|whoseturn];
	
	if(p.is_player){
		draw_sprite_ext(spr_myturn,0,p.x,p.y,1+abs(sin(current_time/300)*0.5),1,0,c_white,0.46);
	
		if(px >= 0 && px < array_length(grid.tiles)){
			if(py >= 0 && py < array_length(grid.tiles[0])){
			
				var t = GRID.tiles[px,py];
				var mytile = (px == p.tile.x && py == p.tile.y);
				var col = c_white;
				var canmovethere = false;
				if(abs(p.tile.x - px) < p.movespace && abs(p.tile.y - py) < p.movespace){
					if(t.occupied == false or mytile){
						canmovethere = true;
					}
				}
				if(!canmovethere){
					col = c_gray
				}
				draw_set_color(col);
				draw_rectangle(rectx,recty,rectx+TS,recty+TS,true);
				draw_set_color(c_white);
			
				if(mouse_check_button_pressed(mb_left)){
		
					if(canmovethere){
						ds_list_clear(tiledata_memory);
						if(mytile){
							tile_memory = pawns[|whoseturn].tile;
							state = PickState.chooseaction;
						}else if(t.occupied != true){
							tile_memory = pawns[|whoseturn].tile;
							pawn_moving = true;
							pawn_moving_x = px;
							pawn_moving_y = py;
						}
					}
				}
			}
		}
	}else if(!p.is_player){
		
	}
}



if(state == PickState.chooseactionposition){
	
	var p = pawns[|whoseturn];
	var pdir = point_direction(p.x,p.y,mouse_x,mouse_y);
	var d = floor(((pdir + 45) mod 360)/90);
	var newdir = (d +1 mod 3);
	var action = chosen_action;
	var doaction = false;
	if(mouse_check_button_pressed(mb_right)){
		chosen_action = noone;
		state = PickState.chooseaction;
		mouse_clear(mb_right);
	}else if(mouse_check_button_pressed(mb_left)){
		// X TO-DO: Set this to performing!
		state = PickState.performing;
		//state = PickState.choosemove;
		doaction = true;
		mouse_clear(mb_left);
	}
	if(action.is_distant){
		action.preview(px,py,0, doaction);
	}else{
		action.preview(p.tile.x,p.tile.y,newdir, doaction);
	}
	
	
}


for(var xx = 0; xx < ds_list_size(pawns); xx++){
	var p = pawns[|xx];
	if(p.is_player){
		var s = sin(current_time/200)*15;
		draw_sprite_ext(p.faceicon,0,32,room_height-48,1.4,1.4,s,c_white,1);
	}
}