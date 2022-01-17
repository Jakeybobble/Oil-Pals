/// @description A piece of code.
// Written by Jacob.

depth = -y;

image_yscale = 1+sin(current_time/300)*0.15;

var gr = obj_gamehandler.grid;
var xpos = gr.pos_x; var ypos = gr.pos_y;
if(tile != noone){ // Note: Player may appear at corner of grid?
	xpos+=tile.x*TS;ypos+=tile.y*TS;
}
// Note: Don't set position like this during animation...
if(obj_gamehandler.pawn_moving){
	
}else{
	x = xpos + TS/2; y = ypos + TS/2;
}

hp = clamp(hp,0,maxhp);