// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_uisystem(){

}

#macro GUIDEBUG false

function GUI() constructor{
	x = 0; y = 0;
	elements = array_create(0);
	
	function getX(){
		return x;	
	}
	function getY(){
		return y;	
	}
	function draw(){
		for(var xx = 0; xx < array_length(elements); xx++){
			elements[xx].doDraw();
			if(GUIDEBUG){
				draw_set_color(c_red);
				draw_set_font(font_babyblocks);
				elements[xx].debugDraw();
				draw_set_color(c_white);
			}
		}
	}
	function destroy(){
		
	}
	
}

function GUI_Element(_parent,_x,_y) constructor{
	parent = _parent;
	elements = array_create(0);
	array_push(parent.elements,self);
	x = _x; y = _y; // Position is relative to parent.
	hide = false; // Also ceases functions, naturally.
	draw = function(){
		
	}
	doDraw = function(){
		if(!hide){
			draw();
		}
		for(var xx = 0; xx < array_length(elements); xx++){
			elements[xx].doDraw();
			if(GUIDEBUG){
				draw_set_color(c_red);
				draw_set_font(font_babyblocks);
				elements[xx].debugDraw();
				draw_set_color(c_white);
			}
		}
	}
	function getX(){
		return parent.getX() + x;
	}
	function getY(){
		return parent.getY() + y;
	}
	function destroy(){
		for(var xx = 0; xx < array_length(parent.elements); xx++){
			if(parent.elements[xx] == self){
				array_delete(parent.elements,xx,1);
			}
		}	
	}
	function debugDraw(){
		var _x = getX(); var _y = getY();
		draw_circle(_x,_y,3,true);
		draw_text_shadow(_x+8,_y,"Element:\n" + string(_x) + ", " + string(_y),c_black,c_red);
	}
}

function GUI_Sprite(_parent,_x,_y,_sprite): GUI_Element(_parent,_x,_y) constructor{
	sprite = _sprite;
	index = 0;
	animated = false;
	animspeed = 100;
	function setAnim(_speed){
		animated = true;
		animspeed = _speed;
	}
	draw = function(){
		if(!animated){
			draw_sprite(sprite,index,getX(),getY());
		}else{
			draw_sprite_animated(sprite,getX(),getY(),animspeed);
		}
	}
}

function GUI_Text(_parent,_x,_y, _text): GUI_Element(_parent,_x,_y) constructor{
	text = _text;
	font = font_express;
	halign = fa_left;
	valign = fa_top;
	color = c_white;
	shadowcolor = undefined;
	num = choose(1,2,3,4,5,6,7,8,9);
	function setFont(_font){
		font = _font;
	}
	function setColor(_color){
		color = _color;
	}
	function setAligns(_halign,_valign){
		halign = _halign; valign = _valign;
	}
	function setAll(_font,_color,_halign,_valign){
		font = _font; color = _color; halign = _halign; valign = _valign;
	}
	function setText(_text){
		text = _text;
	}
	function setShadow(_color){
		shadowcolor = _color;
	}
	function draw(){
		// To-do: Figure out that push/pop thing.
		draw_set_halign(halign);
		draw_set_valign(valign);
		draw_set_font(font);
		draw_set_color(color);
		if(shadowcolor != undefined){
			draw_text_shadow(getX(),getY(),text,shadowcolor,color);
		}else{
			draw_text(getX(),getY(),text);
		}
		
		
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(c_white);
	}
}

function GUI_Hoverable(_parent,_x,_y): GUI_Element(_parent,_x,_y) constructor{ // WIP?
	
}

function GUI_Scrollable(_parent,_x,_y,_vertical): GUI_Element(_parent,_x,_y) constructor{
	vertical = _vertical;
	onhover = false; // Currently does nothing.
	sens = 30; // TO-DO: Figure out PC scroll strength?
	limit_min = 0;
	limit_max = 1750;
	function setLimits(_min,_max){
		limit_max = _max;
		limit_min = _min;
	}
	
	function draw(){
		var pow = (mouse_wheel_down() - mouse_wheel_up())*sens;
		if(vertical){
			// TO-DO: Don't change x, change another variable and return that on getX()...
			//y = clamp(y+pow,-limit_max,limit_min); // These don't work properly.
			y-=pow;
		}else{
			//x = clamp(x+pow,-limit_max,limit_min);
			x+=pow;
		}
	}
	function debugDraw(){
		if(vertical){
			// TO-DO (Laziness)
		}else{
			show_debug_message("bruh");
			var _s = 32;
			var x1 = getX()-limit_min; var x2 = getX() + limit_max;
			draw_line(x1,getY()-_s,x1,getY()+_s);
			//draw_line(getX()+x,getY()-_s,getX()+x,getY()+_s); // Cursor // To-do.
			draw_line(x1,getY(),x2,getY()); // Hangline
			draw_line(x2,getY()-_s,x2,getY()+_s);
		}
	}
}

function GUI_Button(_parent,_x, _y, _sprite): GUI_Element(_parent,_x,_y) constructor{
	sprite = _sprite;
	sprite_onHover = undefined;
	sprite_onClick = undefined;
	width = sprite_get_width(sprite); height = sprite_get_height(sprite);
	animspeed = 100;
	
	function setSprites(_spr, _hover, _click){
		sprite = _spr; sprite_onHover = _hover; sprite_onClick = _click;
	}
	
	func = function(){ // Function to run when pressed.
		show_debug_message("This button is missing a function :-)");
	}
	
	function draw(){
		var state = 0;
		if(point_in_rectangle(mouse_x,mouse_y,getX(),getY(),getX()+width,getY()+height)){
			state = 1;
			if(mouse_check_button(mb_left)){
				state = 2;
			}
			if(mouse_check_button_released(mb_left)){
				func();
				mouse_clear(mb_left);
			}
		}
		var spr = sprite;
		switch(state){
			case 1:
			if(sprite_onHover != undefined){
				spr = sprite_onHover;
			}
			break;
			case 2:
			if(sprite_onClick != undefined){
				spr = sprite_onClick;
			}
			break;
		}
		draw_sprite_animated(spr,getX(),getY(),animspeed);
	}
}

function GUI_SimpleButton(_parent,_x, _y, _sprite): GUI_Element(_parent,_x,_y) constructor{
	sprite = _sprite;
	width = sprite_get_width(sprite); height = sprite_get_height(sprite);
	
	function setSprites(_spr){
		sprite = _spr;
	}
	
	func = function(){ // Function to run when pressed.
		show_debug_message("This simple button is missing a function :-)");
	}
	
	function draw_extra(_x, _y){
		// Extra stuff to draw on hover... Thank me later.
	}
	
	function draw(){
		var offset = 0; var hovered = false;
		if(point_in_rectangle(mouse_x,mouse_y,getX(),getY(),getX()+width,getY()+height)){
			hovered = true;
			if(mouse_check_button(mb_left)){
				offset = 1;
			}
			if(mouse_check_button_released(mb_left)){
				func();
				mouse_clear(mb_left);
			}
		}
		
		draw_sprite(sprite,0,getX(),getY()+offset);
		if(hovered){
			gpu_set_blendmode(bm_add);
			draw_set_alpha(0.5);
			draw_rectangle(getX(),getY(),getX()+width,getY()+height,false);
			draw_set_alpha(1);
			gpu_set_blendmode(bm_normal);
			
			draw_extra(getX(),getY());
		}
	}
}