/// @description A piece of code.
// Written by Jacob.

var mx = mouse_x; var my = mouse_y;

// Returns square that the mouse is in.
//show_debug_message(round(GRID.x + mx) div TS);
//var px = (mx div TS)- GRID.x/TS; var py = (my div TS) - GRID.y/TS;

var px = floor((mx-GRID.x)/TS); var py = floor((my-GRID.y)/TS);

var rectx = GRID.x + px*TS;
var recty = GRID.y + py*TS;


if(state == PickState.choosemove){
	var p = pawns[|whoseturn];
	chosen_ability = undefined;
	menutopset = 256;
	if(p.dead){
		state = PickState.performing;
	}else{
		if(p.isPlayer()){
			#region Is Player
			//draw_sprite_ext(spr_myturn,0,p.x,p.y,1+abs(sin(current_time/300)*0.5),1,0,c_white,1); // Opacity prev: 0.46
			//p.drawSelected(); // NOT WORKING! TO-DO: Add player turn cursor object that teleports.
			obj_playerturn.x = p.x; obj_playerturn.y = p.y;
			obj_playerturn.show = true;
			
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
						chosen_ability = p.actions[|xx];
					}
				}
			}
			
			if (!_cancel){
				if(px >= 0 && px < array_length(GRID.tiles)){
					if(py >= 0 && py < array_length(GRID.tiles[0])){
			
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
			#endregion
		}else if(!p.isPlayer()){
			#region Is Not Player
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
				}
			}
			
			if(ds_list_size(movable) == 0){
				// Do skip...
				state = PickState.chooseaction;
			}else{
				
				// Choose where to move...
				
				p.doConditions(false);
				
				var brain = p.brain;
				
				// Filter out the deads...
				var targetpawns = ds_list_create();
				ds_list_copy(targetpawns,pawns);
				for(var xx = ds_list_size(targetpawns)-1; xx > 0; xx--){
					var _p = targetpawns[|xx];
					if(_p.dead){
						ds_list_delete(targetpawns,xx);
					}
				}
				
				var target = brain.pickTarget(targetpawns,p);
				
				ds_list_destroy(targetpawns);
				
				var totile = brain.doMove(movable, p.tile, target,brain.movingtype);
				
				if(totile == undefined or totile == noone){
					show_debug_message(p.name + " used backup moving type.");
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
		#endregion
		}
	}
	
}



if(state == PickState.chooseactionposition){
	var p = pawns[|whoseturn];
	if(p.isPlayer()){
		#region Is Player
		var pdir = point_direction(p.x,p.y,mouse_x,mouse_y);
		var d = floor(((pdir + 45) mod 360)/90);
		var newdir = (d +1 mod 3);
		var ability = chosen_ability;
		
		var to_attack = undefined;
		if(ability != undefined){
			to_attack = ability.getTiles(px,py,newdir,p);
			ability.preview(to_attack);
		}
		
		if(mouse_check_button_pressed(mb_right)){
			chosen_ability = noone;
			state = PickState.chooseaction;
			mouse_clear(mb_right);
		}else if(mouse_check_button_pressed(mb_left)){
			if(to_attack != undefined){
				var perform = ability.perform(to_attack,p);
				if(perform){
					state = PickState.performing;
				}
				mouse_clear(mb_left);
			}
		}
		#endregion
	}else if(!p.isPlayer()){
		#region Is not Player
		
		/* Old
		var targets = ds_list_create();
		for(var xx = 0; xx < ds_list_size(pawns); xx++){
			var _p = pawns[|xx];
			if(_p.isPlayer()){
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
		*/
		
		state = PickState.performing;
		
		// Filter out the deads...
		var targetpawns = ds_list_create();
		ds_list_copy(targetpawns,pawns);
		for(var xx = ds_list_size(targetpawns)-1; xx > 0; xx--){
			var _p = targetpawns[|xx];
			if(_p.dead){
				ds_list_delete(targetpawns,xx);
			}
		}
		
		//targetpawn = p.brain.pickTarget(pawns,p);
		targetpawn = p.brain.pickTarget(targetpawns,p);
		ds_list_destroy(targetpawns);
		if(targetpawn != undefined && targetpawn != noone){
			var todir = point_direction(p.x,p.y,targetpawn.x,targetpawn.y);
			
			var d = floor(((todir + 45) mod 360)/90);
			var newdir = (d +1 mod 3);
			var ability = chosen_ability;
			
			var to_attack = undefined; // Tiles to attack from Ability.
			if(ability != undefined){
				to_attack = ability.getTiles(targetpawn.tile.x,targetpawn.tile.y,newdir,p);
				ability.perform(to_attack,p);
			}
		}
		
		
		
		
		//ds_list_destroy(targets);
		#endregion
	}
	
	
}


