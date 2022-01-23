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

function doConditions(){
		// This will set the targeting and moving type depending on conditions.
		// Conditions will be unique.
		// Actions the pawn will also want to use will be set here.
		// Note that this is only used by AI.
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
	newdmg = clamp(newdmg,1,status.affectDamage(dmg, type))
	//hp-= newdmg;
	hp = clamp(hp-newdmg,0,maxhp);
	flyingNumber(x,y,newdmg);
	if(hp <= 0){
		dead = true;
		onDeath(); // Previously before 'dead = true'.
	}
	onTakeDamage(dmg, type);
	
}

/// Set tile position of a pawn, also updates tile.
/// Animations will be set in another function which runs before this.
function setToTile(xpos, ypos){
	var t = obj_gamehandler.grid.tiles[xpos,ypos]; // Tile to set to
	if(tile != noone){
		tile.occupied = false;
		tile.stander = noone;
	}
	tile = t;
	t.occupied = true;
	t.stander = self;
	
}

failsafe_timer = 0;
function moveToTileAnim(xpos, ypos){
	var t = obj_gamehandler.grid.tiles[xpos,ypos];
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

actions = ds_list_create();