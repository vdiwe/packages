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
</script>
</HEAD>
%invoke wm.prt.dashboard:mainMenu%
<BODY CLASS="menu" onload="initMenu('%value buttonUrls/sections[0]/submenu[0]/url%');">



<TABLE WIDTH="100%" cellspacing=0 cellpadding=1 border=0>

%scope buttonUrls%
%loop sections%

		%ifvar name equals('hide')%
		%else%
			%ifvar value text equals('Process Engine')%
				<TR manualhide="false" onClick="toggle(this, '%value text%_subMenu', '%value text%_twistie');" OnMouseOver="this.className='cursor';"><TD CLASS="menusection-Server" NOWRAP>
				   <img id='%value text%_twistie' src="images/expanded.gif">&nbsp;%value text%
				</TD></TR>
			%else%
				<TR manualhide="false" onClick="toggle(this, '%value text%_subMenu', '%value text%_twistie');" OnMouseOver="this.className='cursor';"><TD CLASS="menusection-Server">
				   <img id='%value text%_twistie' src="images/expanded.gif">&nbsp;%value text%
				</TD></TR>
			%endif%
    <!--<TR><TD CLASS="menusection-%value name%">
       <img src="images/blank.gif" width="4" height="1"
	    border="0">%value text%
    </TD></TR>-->
%loop submenu%
        
	%ifvar url -notempty%
	<!--<TR>-->
		%ifvar value value ../text equals('Process Engine')%
			<TR name="%value ../text%_subMenu" style="display: table-row">
		%else%
			<TR name="%value ../text%_subMenu" style="display: table-row">
		%endif%
    <TD id="i%value url%"
        %ifvar url equals('nonedsp')%
          class="menuitem-unclickable"
        %else%
          class="menuitem"
          onmouseover="menuMouseOver(this, '%value url%');"
          onmouseout="menuMouseOut(this);"
          onclick="document.all['a%value url%'].click();"
        %endif%>
    <nobr>
    <img valign="middle" src="images/blank.gif" width="4" height="1" border="0"><img valign="middle"
            %ifvar url%id="%value url%" name="%value url%"%endif%
            src="images/blank.gif"
            height="8" width="8" border="0">
        %ifvar url equals('nonedsp')%%value text%
		%else%
				<A id="a%value url%" TARGET="main" HREF="%value url%"	%ifvar noarrow%%else%onclick="menuMove('%value url%', 'main'); return true;"%endif%>

				<script type="text/javascript">
		  		if( IE() )
					{
						document.write("</a>");
					}
				</script>

				<span class="menuitemspanie">%value text%%ifvar target%...%endif%</span></a>



		%endif%
    </nobr></TD></TR>
    %else%
    %endif%
    
    
    
%endloop%
<tr>
<td class="menuseparator"><img src="images/blank.gif" width="3" height="3" border="0"></td>
</tr>
%endif%

    %endloop%
%endscope%
</TABLE>

<div style="height=0; width=0">
<form name="urlsaver">
<input type="hidden" name="helpURL" value="/WmRoot/doc/OnlineHelp/wwhelp.htm?context=is_help&topic=IS_Server_SrvrStatsScrn">
</form>
</div>

</BODY>
</HTML>
