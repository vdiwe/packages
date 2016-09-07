<HTML>
<HEAD>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">
<script src="menu.js.txt"></script>
<SCRIPT language="JavaScript">
function getMID(modelID)
{
	var parent = modelID.split("?");
	if (parent[0] != "_ALL_")
	{
		var node = parent[0].split("/");
		for (var i=0; i < node.length; i++)
		{
			if (i>0)
				document.write(" &gt; ");
			document.write(node[i]);
		}
	}
}
</SCRIPT>
<style>
body {     border-top: 1px solid #97A6CB; }
</style>
</HEAD>
<BODY CLASS="main">
<TABLE width="100%">
	<TR>
	<TD class="menusection-Settings" colspan="2"><SCRIPT>getMID('%value encode(javascript) mid%')</SCRIPT> &gt; %value friendlyName%
	</TD>
	</TR>
	 <tr>
          <td valign="top" colspan="2">
            <ul>
             <li><a href="modelDetails.dsp?mid=%value mid%&version=%value version%&url=%value url%">Return to Process Details</a></li>
            </ul>
          </td>
     </tr>
</TABLE>	
%invoke wm.prt.dashboard:contentRepoDetails%

	<TABLE class="tableForm" border="0">
		<TBODY>
			<TR>
				<TD colspan="2" class="heading">E-form Content Repository Listener</TD>
			</TR>
			<TR>
				<SCRIPT>swapRows();writeTD("row"); </SCRIPT>
				Friendly Name</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value friendlyName% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Host</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/host% </TD>
				<SCRIPT>swapRows();</SCRIPT>

			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Port</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/port% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Login</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/login% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Repository Path</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/path% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Listening Path</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/listeningPath% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Template Path</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/templatePath% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Status</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%ifvar repo/status equals('true')% 
								<img src="images/green-ball.gif" border="0">
							%else%
								<img src="images/red-ball.gif" border="0"> 
							%endif% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR>
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				IS Doc Type</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/isDoc% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR> 
			<TR>
				<SCRIPT>writeTD("row"); </SCRIPT>
				Template</TD>
				<SCRIPT>writeTD("rowdata-l"); </SCRIPT>
				%value repo/template% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR>  
			<TR>
				<TD width="150"> </TD>
				<TD></TD>
			</TR>
		</TBODY>
	</TABLE>
	<TABLE class="tableForm" border="0" style="display:none">
		<TBODY>
			<TR>
				<TD class="menusection-Settings">Active models using this Repository</TD>
			</TR>
			<TR>
				<TD class="oddcol-l">Model Name</TD>
			</TR>	
			<SCRIPT>resetRows();</SCRIPT>
			%loop repo/models%
			<TR>
				<SCRIPT>writeTD("row-l"); </SCRIPT>
				%value repo/models%</TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR>
			%endloop%
		</TBODY>
	</TABLE>
	<TABLE class="tableForm" border="0" style="display:none">
		<TBODY>
			<TR>
				<TD colspan="3" class="menusection-Settings">All Models using this Repository</TD>
			</TR>
			<TR>
				<TD class="oddcol-l">Model Name</TD>
				<TD class="oddcol">IS Doc Type</TD>
				<TD class="oddcol">Template Name</TD>
			</TR>
			<SCRIPT>resetRows();</SCRIPT>
			%loop repo/eformDocArray%
 			<TR>
				<SCRIPT>writeTD("row-l"); </SCRIPT>
				%loop models% %value models% <BR/> %endloop%</TD>
				<SCRIPT>writeTD("rowdata"); </SCRIPT>
				%value docType% </TD>
				<SCRIPT>writeTD("rowdata"); </SCRIPT>
				%value template% </TD>
				<SCRIPT>swapRows();</SCRIPT>
			</TR>
			%endloop%
		</TBODY>
	</TABLE>
</BODY>
%endinvoke%
%endinvoke%
</HTML>						

			


	