// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_rotateArray(array, origx, origy){
	var returnarray = array_create(array_length(array[0]));
	// Rotates left
	var newx; var newy;
		for (var xx = 0; xx < array_length(array); xx++) {
			for (var yy = 0; yy < array_length(array[0]); yy++) {
				//var num = array[xx, array_length(array[0])-yy-1];
				var num = array[array_length(array)-xx-1, yy];
				returnarray[yy,xx] = num;
				
		        //newarray[i,j] = array[j, array_length(array)-i-1]
		    }
		}
		
		newx = origy;
		newy = array_length(array)-1-origx;
		//newy = 
		
		return [returnarray, newx, newy];
}