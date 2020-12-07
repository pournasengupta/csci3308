/*
	Registration Page:
		viewStudentStats(id, toggle) method
			parameters:
				id - The css id of the html tag being updated.
				toggle - 
					0 - hide the html tag
					1 - make the html tag visible
			
			purpose: This method will accept the id of an html tag and a toggle value.
					 The method will then set the html tag's css visibility and height.  
					 To hide the html tag (toggle - 0), the visibility will be set to hidden and
					 the height will be set to 0.  
					 To reveal the html tag (toggle - 1), the visibility will be set to visible and
					 the height will be set to auto.
*/
function viewStudentStats(id, toggle){
	var v = document.getElementById(id).style.visibility;
	var h = document.getElementById(id).style.height;

	if(toggle > 0){
		v = "visible"; 
		h = "auto"; 
	}

	else{
		v = "hidden"; 
		h = 0; 
	}

	document.getElementById(id).style.visibility = v; 
	document.getElementById(id).style.height = h; 

};
 