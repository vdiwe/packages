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

%invoke wm.prt.dashboard:startupMessages%
<BODY CLASS="main">
	<TABLE width="100%" class="tableForm">
	<TR>
		<TD width="100%" colspan="3" class="menusection-Settings">Process Engine &gt; Startup Messages</TD>
	</TR>
	</TABLE>		
<SCRIPT>resetRows();</SCRIPT>		
<TABLE class="tableForm">
%ifvar messages -notempty%
%loop messages%
<TR> 
	<TD class="heading">%value key%</TD>
</TR>
%loop message%
	
	<TR>
		<SCRIPT>writeTD("row-l");</SCRIPT>
		&nbsp;%value message%</TD>
	</TR>
	<SCRIPT>swapRows();</SCRIPT>
%endloop%
%endloop%
%else%
	<TR>
		<SCRIPT>writeTD("row-l");</SCRIPT>
		There are no startup messages</TD>
	</TR>
%endif%
</TABLE>
</BODY>
</HTML>
