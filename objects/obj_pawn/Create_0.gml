/// @description A piece of code.
// Written by Jacob.

is_player = true;
name = "Dingo";
hp = 5;
maxhp = hp;
spd = 5;
movespace = 2;
defense = 0;

faceicon = spr_face_oilman;

fireimmunity = false;

status = new Status(); // Contains pawn status effects

tile = noone;

dead = false;
hasplayed = false;

barks = new Barks();

brain = new Brain(self);

graveid = irandom_range(0,sprite_get_number(spr_grave)-1);

actions = ds_list_create();

function doConditions(hasmoved){
		// This will set the targeting and moving type depending on conditions.
		// Conditions will be unique.
		// Actions the pawn will also want to use will be set here.
		// Note that this is only used by AI.
		/*
		if(){
			
		}
		*/
		brain.nextaction = 0;
		var rand = irandom_range(0,ds_list_size(actions)-1);
		brain.nextaction = rand;
		
}
function pickTarget(){
	// This does the same thing as brain.pickTarget(), but runs before both moving
	// and attacking! The AI can pick what attack they want to do with what movement.
}


function onStartTurn(){
	
}
function onEndTurn(){
	
}
function onEndWave(){
	
}
function onDeath(){
	
}
function onTakeDamage(dmg, type){
	
}

function takeDamage(dmg, type){ // Type is optional
	var newdmg = status.affectDamage(dmg, type)-defense;
	newdmg = clamp(newdmg,1,hp)
	//hp-= newdmg;
	hp = clamp(hp-newdmg,0,maxhp);
	if(!dead){
		flyingNumber(x,y,newdmg);
	}
	if(hp <= 0){
		dead = true;
		onDeath(); // Previously before 'dead = true'.
	}
	if(!dead){
		onTakeDamage(dmg, type);
	}
	
}

/// Set tile position of a pawn, also updates tile.
/// Animations will be set in another function which runs before this.
function setToTile(xpos, ypos){
	var t = GRID.tiles[xpos,ypos]; // Tile to set to
	if(tile != noone){
		tile.occupied = false;
		tile.stander = noone;
	}
	tile = t;
	t.occupied = true;
	t.stander = self;
	
}
function swapTiles(pawn){ // Swap tiles with another pawn
	var fromtile = tile;
	var totile = pawn.tile;
	tile = totile;
	tile.occupied = true;
	tile.stander = self;
	pawn.tile = fromtile;
	fromtile.occupied = true;
	fromtile.stander = pawn;
}

failsafe_timer = 0;
function moveToTileAnim(xpos, ypos){
	var t = GRID.tiles[xpos,ypos];
	failsafe_timer++;
	if(failsafe_timer > 500){
		failsafe_timer = 0;
		return true;
	}
	
	// Do anim stuff
	// If close to position, return true, otherwise, return false.
	var mspd = 4;
	var xto = GRID.x + (TS/2) + t.x * TS;
	var yto = GRID.y + (TS/2) + t.y * TS;
	var dir = point_direction(x,y,xto,yto);
	var xang = lengthdir_x(1, dir); var yang = lengthdir_y(1, dir);
	x+=xang*mspd; y+=yang*mspd;
	//show_debug_message("Yeet");
	//show_debug_message(point_distance(x,y,xto,yto));
	if(point_distance(x,y,xto,yto) < mspd){
		failsafe_timer = 0;
		return true;
	}else{
		return false;	
	}
	
}