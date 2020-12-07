function viewStudentStats(id, toggle)
{
	if(toggle <= 0)
	{
		document.getElementById(id).style.visibility = "hidden";
		document.getElementById(id).style.width = "0";
		document.getElementById(id).style.height = "0";
	}
	else if(toggle > 0)
	{
		document.getElementById(id).style.visibility = "visible";
		document.getElementById(id).style.width = "auto";
		document.getElementById(id).style.height = "auto";
	}
}