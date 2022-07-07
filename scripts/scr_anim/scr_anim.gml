// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_anim(){
	// Generalized Animation System (GAS)
}

// Concept:
// Pawns can hold custom animations, or grab from a global library, just like with abilities.
// "Anims" will have several variables and methods:
// onStart, onEnd(), running()
// A timer will tick on for how long the animation has been running
// There should be a list of pawns in the animation, somewhere. Somehow.

// An animation holder might be necessary to check whether an animation is running.
// Also to run the current animation... In step (or draw)?

function AnimHandler(_pawn) constructor{
	current = noone; // Current animation
	actor = _pawn; // Actor is typically the pawn
	sideactors = [];
	time = 0;
	
	function update(){ // Makes sure animations are running when they should be
		if(current != noone){
			time++;
			current.draw(self);
			if(time >= current.maxlength){ // On end
				actor.anim.animating = false;
				actor.anim.onEnd();
				for(var _s = 0; _s < array_length(sideactors); _s++){
					var sa = sideactors[_s];
					sa.anim.animating = false;
					sa.anim.onEnd();
					
				}
				current.onEnd(self);
				current = noone; sideactors = [];
				time = 0;
			}
		}
	}
	function play(_anim){
		GH.setPerformTimer(_anim.maxlength)
		actor.anim.copy(actor);
		current = _anim;
		_anim.onStart(self);
		actor.anim.animating = true;
		for(var _s = 0; _s < array_length(sideactors); _s++){
			var sa = sideactors[_s];
			sa.anim.copy(sa);
			sa.anim.animating = true;
		}
	}
}

function Anim() constructor{
	
	// Note: Only constant variables should be in here.
	speed = 1; // Might be able to do some funky stuff with this in the future?
	maxlength = 120; // Animation will automatically stop after 1000 frames.
	
	function onStart(_handler){
		
	}
	function draw(_handler){
		
	}
	function onEnd(_handler){
		
	}
}