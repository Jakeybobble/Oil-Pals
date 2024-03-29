// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_aibrain(){

}

enum TargetingType { // Used for both moving and attacks, should it be so?
	targetClosestEnemy, targetFurthestEnemy,
	targetRandomEnemy, targetRandomFriend, targetRandomEnemy_inrange, targetRandomFriend_inrange, // Targets random across the entire map
	targetEnemiesFit, // Try to get in range of as many enemies as possible (move to MovingType?)
	targetFriendsFit,
	targetAllEnemies, // These are primarily used for furtherFromTarget
	targetAllFriends,
	targetSelf,
	targetFriendInRange,
	targetFriendInRangePlusSelf,
	targetRandomAny
}

// Idea: Have attack "priority" number... AI will try to pick attacks closer to priority number
// This could be used to make some sort of "chanceofhealing" variable tied to priority...

// Idea: May be too expensive, but have the enemy evaluate different attacks and movements
// This would only be done well if 'backwards method' is used

enum MovingType {
	randomSpot, // <3
	furtherFromTarget_random,
	furtherFromTarget_far, // Easy to get cornered?
	straightToTarget_front, // Try to move to a tile touching the target tile
	straightToTarget_diagonal,
	straightToTarget_either,
	straightToTarget_exact,
	randomAligned, // Moves to either the same X or Y as the target
	randomAligned_close, // Not sure why I added this, it's the same as straightToTarget_front
	randomAligned_exact, // Takes extra variable, will try to snipe from a certain offset.
	randomAligned_diagonal,
	fearOil, // Fears may be moved to separate enum as they do not have a target
	fearFire,
	fearWater,
	loveOil, // Will go to loved when in range.
	loveFire,
	loveWater,
	
	NUM // This has to be last - Used for counting
}

function Brain(_pawn) constructor{
	movingtype = MovingType.randomSpot;
	targetingtype = TargetingType.targetClosestEnemy;
	abstain = false; // Will skip attacking if this is true.
	pawn = _pawn;
	nextaction = 0;
	nextpawn = noone; // TO-DO: Store next pawn to attack here, for willreconsider.
	willreconsider = false; // If true, will do another condition check after moving. Remember to set to false first (to default it out).
	
	// -- "Arguments" --
	offset = 1; // Extra variable for certain moving types.
	arg_target = noone; // For checking if target is specific object.
	
	movingtype_backup = MovingType.randomSpot;
	
	function doMove(list, tile, target, type){ // TO-DO: Input the movingtype instead of grabbing it from the struct.
		var size = ds_list_size(list);
		switch(type){
			case MovingType.randomSpot:
			var t = list[|irandom(size-1)];
			return t;
			break;
			#region furtherFromTarget_random
			case MovingType.furtherFromTarget_random:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			var dis = point_distance(pawn.x,pawn.y,target.x,target.y);
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				var dis2 = point_distance(t.xToWorld(),t.yToWorld(),target.x,target.y);
				if(dis2 > dis){
					ds_list_add(picks,t);
				}
			}
			
			var t = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			if(t != undefined){
				return t;
			}else{
				return noone;	
			}
			#endregion
			break;
			#region furthestFromTarget_far
			case MovingType.furtherFromTarget_far: // Not yet tested.
			if(target == noone) return undefined;
			var picks = ds_list_create();
			var dis = point_distance(pawn.x,pawn.y,target.x,target.y);
			var furthest_spot = undefined;
			var furthest_dis = 0;
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				var dis2 = point_distance(t.xToWorld(),t.yToWorld(),target.x,target.y);
				if(dis2 > dis){
					//ds_list_add(picks,t);
					furthest_spot = t;
					furthest_dis = dis2;
				}
			}
			ds_list_destroy(picks);
			return furthest_spot;
			#endregion
			break;
			case MovingType.randomAligned:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.x == target.tile.x or t.y == target.tile.y){
					ds_list_add(picks, t);
					//t.status = TileStatus.water;
				}
			}
			var toreturn = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			
			return toreturn;
			
			break;
			case MovingType.randomAligned_close:
			
			break;
			case MovingType.randomAligned_exact:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.x == target.tile.x or t.y == target.tile.y){
					var d = getTileBiggestDistance(t,target.tile);
					if(d == offset){
						ds_list_add(picks, t);
						//t.status = TileStatus.water;
					}
				}
			}
			var toreturn = picks[|irandom(ds_list_size(picks)-1)];
			//show_debug_message(ds_list_size(picks));
			ds_list_destroy(picks);
			return toreturn;
			break;
			case MovingType.straightToTarget_front:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.x == target.tile.x){
					var yy = t.y - target.tile.y;
					if(abs(yy) == 1){
						//t.status = TileStatus.fire;
						ds_list_add(picks,t);
					}
				}else if(t.y == target.tile.y){
					var yy = t.x - target.tile.x;
					if(abs(yy) == 1){
						ds_list_add(picks,t);
						//t.status = TileStatus.fire;
					}
				}
			}
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.straightToTarget_diagonal: // TO-DO: May be broken when there is noone, do test.
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				var w = t.x - target.tile.x;
				var h = t.y - target.tile.y;
				if(t.x != target.tile.x && t.y != target.tile.y){
					if(abs(w) == 1 && abs(h) == 1){
						ds_list_add(picks,t);
					}
					
				}
				
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.straightToTarget_either:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(getTileBiggestDistance(t,target.tile) == 1){
					ds_list_add(picks,t);
				}
			}
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.straightToTarget_exact:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(getTileBiggestDistance(t,target.tile) == offset){
					ds_list_add(picks,t);
				}
			}
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.randomAligned_diagonal:
			if(target == noone) return undefined;
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				var w = t.x - target.tile.x;
				var h = t.y - target.tile.y;
				if(abs(w) == abs(h)){
					ds_list_add(picks,t);
				}
			}
			
			#region love/hate stuff...
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.loveOil:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status == TileStatus.oil){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.fearOil:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status != TileStatus.oil){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.loveWater:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status == TileStatus.water){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.fearWater:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status != TileStatus.water){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.loveFire:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status == TileStatus.fire){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case MovingType.fearFire:
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				if(t.status != TileStatus.fire){
					ds_list_add(picks,t);
				}
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			#endregion
			
			/* Easily copyable code! Yay!
			var picks = ds_list_create();
			for(var xx = 0; xx < size; xx++){
				var t = list[|xx];
				// Stuff here...
			}
			
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			*/
			
		}
		
	}
	
	function pickTarget(list,me){ // Pick a pawn to target.
		
		var taunt = getTaunt();
		if(taunt != noone){
			return taunt; // NOTE: Do more stuff here in the future, potentially
		}
		
		switch(targetingtype){
			case TargetingType.targetClosestEnemy:
			var closest_pawn = noone;
			var closest_val = 10000;
			for(var xx = 0; xx < ds_list_size(list); xx++){
				var p = list[|xx];
				var dis = point_distance(pawn.x,pawn.y,p.x,p.y)
				if(dis < closest_val && !p.isMate(me)){
					closest_val = dis;
					closest_pawn = p;
				}
			}
			return closest_pawn;
			
			case TargetingType.targetFurthestEnemy:
			var furthest_pawn = noone;
			var furthest_val = 0;
			for(var xx = 0; xx < ds_list_size(list); xx++){
				var p = list[|xx];
				var dis = point_distance(pawn.x,pawn.y,p.x,p.y);
				if(dis > furthest_val && !p.isMate(me)){
					furthest_val = dis;
					furthest_pawn = p;
				}
			}
			return furthest_pawn;
			
			case TargetingType.targetRandomEnemy:
			var picks = ds_list_create();
			for(var xx = 0; xx < ds_list_size(list); xx++){
				if(!list[|xx].isMate(me)){
					ds_list_add(picks);
				}
			}
			ds_list_shuffle(picks);
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			case TargetingType.targetRandomFriend:
			var picks = ds_list_create();
			for(var xx = 0; xx < ds_list_size(list); xx++){
				if(list[|xx].isMate(me)){
					ds_list_add(picks);
				}
			}
			ds_list_shuffle(picks);
			var pick = picks[|irandom(ds_list_size(picks)-1)];
			ds_list_destroy(picks);
			return pick;
			break;
			case TargetingType.targetEnemiesFit: // Might not be possible to make...
			
			break;
			case TargetingType.targetFriendsFit:
			
			break;
			case TargetingType.targetFriendInRange:
			
			break;
			case TargetingType.targetRandomAny:
			var p = list[|irandom(ds_list_size(list)-1)];
			return p;
			break;
		}
	}
}