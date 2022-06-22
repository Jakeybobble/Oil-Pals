// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_uisystem(){

}

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
		}
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
		}
	}
	function getX(){
		return parent.getX() + x;
	}
	function getY(){
		return parent.getY() + y;
	}
}

function GUI_Text(_parent,_x,_y, _text): GUI_Element(_parent,_x,_y) constructor{
	text = _text;
	font = font_express;
	halign = fa_left;
	valign = fa_top;
	color = c_white;
	shadowcolor = undefined;
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
	draw = function(){
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
	
	draw = function(){
		var pow = (mouse_wheel_down() - mouse_wheel_up())*sens;
		if(vertical){
			// TO-DO: Don't change x, change another variable and return that on getX()...
			//y = clamp(y+pow,-limit_max,limit_min); // These don't work properly.
			y+=pow;
		}else{
			//x = clamp(x+pow,-limit_max,limit_min);
			x+=pow;
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
	
	draw = function(){
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