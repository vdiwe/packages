<HTML>
<HEAD>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<script src="menu.js.txt"></script>
<style>
body {     border-top: 1px solid #97A6CB; }
</style>
<script type="text/javascript">
function toggle(parent, id, imgId) {
	var set = 'none';
	var image = document.getElementById(imgId);
	if(parent.getAttribute('manualhide') == 'true') {
		set = 'table-row';
		parent.setAttribute('manualhide', 'false');
		image.src = 'images/expanded.gif';
	} else {
		parent.setAttribute('manualhide', 'true');
		image.src = 'images/collapsed.gif';
	}
	var elements = getElements("TR", id);
	for ( var i = 0; i < elements.length; i++) {
		var element = elements[i];
		element.style.cssText = "display:"+set;
	}
}

function getElements(tag, name) {
	var elem = document.getElementsByTagName(tag);
	var arr = new Array();
	for(i=0, idx=0; i<elem.length; i++) {
		att = elem[i].getAttribute("name");
		if(att == name) {
			arr[idx++] = elem[i];
		}
	}
	return arr;
}

function ajaxFunction()
{
	var xmlhttp;
	if (window.XMLHttpRequest)
  	{
  		// code for IE7+, Firefox, Chrome, Opera, Safari
  		xmlhttp=new XMLHttpRequest();
  	}
	else if (window.ActiveXObject)
  	{
  		// code for IE6, IE5
  		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
  	}
	else
  	{
  		alert("Your browser does not support XMLHTTP!");
  	}
	xmlhttp.onreadystatechange=function()
	{
		if(xmlhttp.readyState==4)
  		{
  			document.myForm.time.value=xmlhttp.responseText;
  		}
	}
}

</script>
</HEAD>
%invoke wm.prt.dashboard:healthCheck%
<BODY CLASS="main">
		<TABLE width="100%" class="tableForm">
			<TBODY>
				<TR>
					<TD class="menusection-Settings">Process Engine &gt; Dashboard
				</TR>
			</TBODY>
		</TABLE>
				
		<TABLE class="tableForm">
				<TBODY>
					<TR>
						<TD colspan="3" class="heading">Dashboard</TD>
					</TR>
					<TR>
						<TD width="25%" class="oddcol-l">Subsystem Name</TD>
						<TD width="10%" class="oddcol">Status</TD>
						<TD class="oddcol">Message</TD>
					</TR>
<SCRIPT>resetRows();</SCRIPT>
%loop health%
	<TR>
		<SCRIPT> writeTD('row-l\" width=\"25%'); </SCRIPT>
		&nbsp;%value name%</TD>
      		<SCRIPT> writeTD('rowdata\" width=\"10%');</SCRIPT>
		%switch status%
			%case '1'%
				<img src="images/green-ball.gif" border="0">
			%case '2'%
				<img src="images/yellow-ball.gif" border="0">
			%case '3'%
				<img src="images/red-ball.gif" border="0">
		%end%
		</TD>
		<SCRIPT> writeTD('row-l');</SCRIPT>
			%value message%
		</TD>
		<SCRIPT>swapRows();</SCRIPT>
		
	</TR>
	
%endloop%
</TBODY>
</TABLE>
</BODY>
</HTML>

