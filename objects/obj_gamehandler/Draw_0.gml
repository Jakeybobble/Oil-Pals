/// @description A piece of code.
// Written by Jacob.

grid.drawTiles(GRID.x, GRID.y);

var mx = mouse_x; var my = mouse_y;

// Returns square that the mouse is in.
//show_debug_message(round(GRID.x + mx) div TS);
//var px = (mx div TS)- GRID.x/TS; var py = (my div TS) - GRID.y/TS;

var px = floor((mx-GRID.x)/TS); var py = floor((my-GRID.y)/TS);

var rectx = GRID.x + px*TS;
var recty = GRID.y + py*TS;


if(state == PickState.choosemove){
	var p = pawns[|whoseturn];
	
	if(p.dead){
		state = PickState.performing;
	}else{
		if(p.is_player){
			draw_sprite_ext(spr_myturn,0,p.x,p.y,1+abs(sin(current_time/300)*0.5),1,0,c_white,0.46);
			
			// Makes sure that the player can't cheat by pulling off something frame perfect.
			var _cancel = false; 
			if(keyboard_check_pressed(vk_anykey)){
				for(var xx = 0; xx < ds_list_size(p.actions); xx++){
					if(keyboard_lastkey == ord(string(xx+1))){
						// Act as if standing still, then skip to choose attack location...
						// NOTE: This makes it so you have to right click twice to undo to last...
						ds_list_clear(tiledata_memory);
						tile_memory = pawns[|whoseturn].tile;
						state = PickState.chooseactionposition;
						chosen_action = p.actions[|xx];
					}
				}
			}
			
			if (!_cancel){
				if(px >= 0 && px < array_length(grid.tiles)){
					if(py >= 0 && py < array_length(grid.tiles[0])){
			
						var t = GRID.tiles[px,py];
						var mytile = (px == p.tile.x && py == p.tile.y);
						var col = c_white;
						var canmovethere = false;
						if((abs(p.tile.x - px) < p.movespace) && (abs(p.tile.y - py) < p.movespace)){
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
			}
		}else if(!p.is_player){
			
			var movable = ds_list_create();
			
			var right = p.tile.x + clamp((GRID.getWidth() - p.tile.x),0,p.movespace);
			var left = p.tile.x - clamp(p.tile.x,0,p.movespace-1);
			var down = p.tile.y + clamp((GRID.getHeight() - p.tile.y),0,p.movespace);
			var up = p.tile.y - clamp(p.tile.y,0,p.movespace-1);
			
			for(var xx = left; xx < right; xx++){
				for(var yy = up; yy < down; yy++){
					var t = GRID.tiles[xx,yy];
					// Do fearOil & such here...
					if(!t.occupied){
						ds_list_add(movable,t);
					}
					//draw_sprite(spr_coolfire,0,t.xToWorld()+24,t.yToWorld()+24);
				}
				
				//draw_sprite(spr_coolfire,0,p.x,p.y);
			}
			
			if(ds_list_size(movable) == 0){
				// Do skip...
				state = PickState.chooseaction;
			}else{
				var brain = p.brain;
				var target = brain.pickTarget(pawns);
				var totile = brain.doMove(movable, p.tile, target,brain.movingtype);
				
				if(totile == undefined or totile == noone){
					totile = brain.doMove(movable, p.tile, target,brain.movingtype_backup);
				}
				// In attack: Have ability to change target...
				if(totile != noone && totile != undefined){
					// Do the move.
					//show_debug_message(totile);
					var mytile = (totile.x == p.tile.x && totile.y == p.tile.y);
					if(totile == mytile){
						state = PickState.chooseaction;
					}else{
						pawn_moving = true;
						pawn_moving_x = totile.x;
						pawn_moving_y = totile.y;
					}
				}else{
					state = PickState.chooseaction;
				}
				
			}
			
			ds_list_destroy(movable);
			
			/*
			var untilskip = 50;
			//var randx = random_range();
			while(untilskip > 0){
				var randx = irandom_range(p.tile.x-p.movespace,p.tile.x+p.movespace);
				var randy = irandom_range(p.tile.y-p.movespace,p.tile.y+p.movespace);
				var mytile = (randx == p.tile.x && randy == p.tile.y);
				// To-do: Can just subtract limits instead of having to check here...
				// Would result in less checking!
				
				// Make brain return tile here...
				// xtile + (GRID.getWidth() - xtile)
				
				if(randx >= 0 && randx < array_length(grid.tiles)){
					if(randy >= 0 && randy < array_length(grid.tiles[0])){
						var t = GRID.tiles[randx,randy];
					
						var canmovethere = false;
					
						if(t.occupied == false or mytile){
							canmovethere = true;
						}
					
						if(canmovethere){
							if(mytile){
								state = PickState.chooseaction;
							}else if(t.occupied == false){
								pawn_moving = true;
								pawn_moving_x = randx;
								pawn_moving_y = randy;
							}
							break;
						}
					}
				}
				untilskip--;
			}
			if(untilskip == 0){
				state = PickState.chooseaction;
			}
			*/
			
			
		
		
		}
	}
	
}



if(state == PickState.chooseactionposition){
	
	var p = pawns[|whoseturn];
	if(p.is_player){
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
		if(action != undefined){
			if(action.is_distant){
				action.preview(px,py,0, doaction);
			}else{
				action.preview(p.tile.x,p.tile.y,newdir, doaction);
			}
		}
	}else if(!p.is_player){
		//var pdir = point_direction();
		var targets = ds_list_create();
		for(var xx = 0; xx < ds_list_size(pawns); xx++){
			var _p = pawns[|xx];
			if(_p.is_player){
				ds_list_add(targets,_p);
			}
		}
		var closest = noone;
		var lowestdis = 10000;
		for(var xx = 0; xx < ds_list_size(targets); xx++){
			var _p = targets[|xx];
			var dis = point_distance(p.x,p.y,_p.x,_p.y);
			if(dis < lowestdis){
				closest = _p;
				lowestdis = dis;
			}
		}
		
		var todir = point_direction(p.x,p.y,closest.x,closest.y);
		var d = floor(((todir + 45) mod 360)/90);
		var newdir = (d +1 mod 3);
		var action = chosen_action;
		
		state = PickState.performing;
		
		if(action != undefined){
			if(action.is_distant){
				action.preview(closest.tile.x,closest.tile.y,0, true);
			}else{
				action.preview(p.tile.x,p.tile.y,newdir, true);
			}
		}
		ds_list_destroy(targets);
	}
	
	
}


