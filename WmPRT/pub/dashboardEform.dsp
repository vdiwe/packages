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
var downRepos = 0;

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

function countDownRepos()
{
	downRepos = downRepos + 1;
	if (downRepos > 0)
	{
		document.getElementById('restartButton1').style.cssText="display:table-row";
		document.getElementById('restartButton2').style.cssText="display:table-row";
	}
	else
	{
		document.getElementById('restartButton1').style.cssText="display:none";
		document.getElementById('restartButton2').style.cssText="display:none";
	}
}
	
function resetDownRepos() {
	downRepos = 0;
}

function restartContentRepository(cr) {

	document.eFormRestart.friendlyName.value=cr;
	document.eFormRestart.submit();
	%invoke wm.prt.dashboard:restartContentRepository%
	%ifvar errorMessage -notempty%
		document.getElementById('errorMessage').innerHTML = "%value errorMessage%";
	%endif%
	%endinvoke%	
	
return;
}
</script>
</HEAD>
%invoke wm.prt.dashboard:eformContentRepository%
<BODY CLASS="main">
<TABLE width="100%" class="tableForm"> 
	<TR>
		<TD class="menusection-Settings">Process Engine &gt; E-forms </TD>
	</TR>
</TABLE>
<FORM name="eFormRestart" method="POST">
		<INPUT type="hidden" name="friendlyName">
		<TABLE class="tableForm" border=0>
				<TBODY>
					<TR> 
						%ifvar errorMessages% 
						<TD id="errorMessage">%value errorMessages%</TD>
						%endif%
					</TR>
					
					<TR>
						<TD class="heading">Enviroments (Listeners)</TD>
				<TD id="restartButton1" class="heading" style="display:none">		
					<input class="cursor" colspan="1" type="button" value="RestartAll"  onClick="restartContentRepository('_ALL_')" OnMouseOver="this.style.cursor='pointer'">&nbsp;</TD>
					</TR>

					<TR>
						<TD class="oddcol-l">Friendly Name</TD>
						<TD class="oddcol">Status</TD>
					</TR>
				<SCRIPT>resetDownRepos();</SCRIPT> 
				%loop repos%
					<TR>
						<SCRIPT>writeTD("row-l"); </SCRIPT>
						<A HREF=contentRepository.dsp?friendlyName=%value friendlyName%>&nbsp;%value friendlyName%</A></TD>
						
						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						%ifvar status equals('true')% 
								<img src="images/green-ball.gif" border="0">
							%else%
								<img src="images/red-ball.gif" border="0" onClick="restartContentRepository('%value friendlyName%')"  OnMouseOver="this.style.cursor='pointer'" OnLoad="countDownRepos();"> 
								<INPUT type="hidden" name="RestartAll" value="%value friendlyName%">
							%endif%
						</TD>
						<SCRIPT>swapRows();</SCRIPT>
					</TR>
				%endloop%				
					<TR> 
						<TD/>
						<TD id="restartButton2" style="display:none">
							<input class="cursor" colspan="1" type="button" value="RestartAll"  onClick="restartContentRepository('_ALL_')" OnMouseOver="this.style.cursor='pointer'"> 
						</TD>
					</TR>
				</TBODY>
		</TABLE>		
		<TABLE width="100%" class="tableForm">
					<TR manualhide="true" onClick="toggle(this, 'loggedEForm_subMenu', 'loggedEForm_twistie');" OnMouseOver="this.className='cursor';">
						<TD width="100%" class="heading"> <img id='loggedEForm_twistie' src="images/collapsed.gif">Logged Messages</TD>
					</TR>
	
					<SCRIPT>resetRows();</SCRIPT>		
					%loop messages% 
						<TR name="loggedEForm_subMenu" style="display: none">
							<SCRIPT>writeTD('row-l');</SCRIPT> &nbsp;%value messages% </TD>
							<SCRIPT>swapRows();</SCRIPT>
						</TR>		
					%endloop%
		</TABLE>

</FORM>
	
</BODY>
</HTML>						




