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

function Brain() constructor{
	
}