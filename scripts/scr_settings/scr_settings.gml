// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_settings(){

}

function Settings() constructor{
	
	volume_music = 1;
	volume_sfx = 1;
	
	function save(){ // Save settings to disk
		// GIANT TO-DO!
	}
	function load(){ // Load settings from disk
		
	}
	
}

global.settings = new Settings();