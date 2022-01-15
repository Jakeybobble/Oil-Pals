// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_init(){

}

#macro TS 48

function Grid(x, y, width, height) constructor{
	
	pos_x = x; pos_y = y;
	tiles[0,0] = 0; // Tiles array
	
	 for(var xx = 0; xx < width; xx++){
		 for(var yy = 0; yy < height; yy++){
			 
			 tiles[xx,yy] = new Tile(xx,yy);
			 
		 }
	 }
	 tiles[2,2].occupied = true;
	 
	 function getTile(xpos, ypos){
		 return tiles[xpos,ypos];
	 }
	 function drawTiles(xpos, ypos){
		 var num = 0;
		 
		 for(var yy = 0; yy < array_length(tiles[0]); yy++){
			 for(var xx = 0; xx < array_length(tiles); xx++){
				 t = tiles[xx,yy];
				 
				 if(t.occupied){
					 //draw_set_color(c_red);
				 }
				 //draw_rectangle(xpos + xx*TS, ypos + yy*TS, xpos + (xx*TS)+TS, ypos + (yy*TS)+TS, true);
				 draw_sprite(spr_tiletest, 0, xpos + xx*TS, ypos + yy*TS);
				 //draw_text(xpos + 6 + xx*TS, ypos + 6 + yy*TS, num);
				 num++;
				 
				 draw_set_color(c_white);
			 }
		 }
		 
		 
	 }
}

enum TileStatus {
	clear
}

function Tile(posx, posy) constructor{
	x = posx; y = posy;
	status = TileStatus.clear;
	occupied = false;
	stander = noone;
}

function char(cid) constructor{
	switch(cid){
		case 0:
			idle = spr_testpawn;
			hp = 5;
			nname = "Dingo";
			break;
		case 1:
			idle = spr_testpawn2;
			hp = 5;
			nname = "Dingo but Evil";
			break;
	}
}