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
	randomAligned, // Moves to either the same X or Y as the target
	randomAligned_close,
	randomAligned_exact, // Takes extra variable, will try to snipe from a certain offset.
	fearOil, // Fears may be moved to separate enum as they do not have a target
	fearFire,
	fearWater
}

function Brain(_pawn) constructor{
	movingtype = MovingType.randomSpot;
	targetingtype = TargetingType.targetClosestEnemy;
	may_abstain = 0; // Chance of just not doing their attack.
	pawn = _pawn;
	
	function doMove(list, tile, target){
		var size = ds_list_size(list);
		switch(movingtype){
			case MovingType.randomSpot:
			var t = list[|irandom(size-1)];
			return t;
			break;
			#region furtherFromTarget_random
			case MovingType.furtherFromTarget_random:
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
		}
		
	}
	
	function pickTarget(list){ // Pick a pawn to target.
		// TO-DO: Make AI work on player team as well
		switch(targetingtype){
			case TargetingType.targetClosestEnemy:
			var closest_pawn = noone;
			var closest_val = 10000;
			for(var xx = 0; xx < ds_list_size(list); xx++){
				var p = list[|xx];
				var dis = point_distance(pawn.x,pawn.y,p.x,p.y)
				if(dis < closest_val && p.is_player){
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
				if(dis > furthest_val & p.is_player){
					furthest_val = dis;
					furthest_pawn = p;
				}
			}
			return furthest_pawn;
			
			case TargetingType.targetRandomEnemy:
			var p = list[|irandom(ds_list_size(list)-1)];
			return p;
			
			case TargetingType.targetRandomFriend:
			
			break;
			case TargetingType.targetEnemiesFit:
			
			break;
			case TargetingType.targetFriendsFit:
			
			break;
			case TargetingType.targetFriendInRange:
			
			break;
		}
	}
}