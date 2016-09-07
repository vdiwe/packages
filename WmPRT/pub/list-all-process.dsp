<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache"/>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
<META HTTP-EQUIV="Expires" CONTENT="-1"/>
<TITLE>Process Engine Configuration Dash</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"/>
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
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
			{
				document.write(" &gt; ");
			}
			document.write(node[i]);
		}
	} else {
		document.write("Process Engine  &gt; ");
		document.write("Processes");	
	}
}
</SCRIPT>
</HEAD>
<BODY>
<TABLE width="100%">
	<TR>
	<TD class="menusection-Settings" NOWRAP><SCRIPT>getMID('%value encode(javascript) mid%');</SCRIPT>
	</TD>
	</TR>
</TABLE>	

	<table class="tableForm">
        			<tbody>
          				<TR>
						<TD CLASS="heading" colspan="3">Processes</TD>
	    				</TR>

				<TR>
					<TD width="30%" class="oddcol-l">Name</td>
					<TD width="10%" class="oddcol">Version</td>
					<TD width="10%" class="oddcol">Enabled</TD>
				</TR>
				%invoke wm.prt.dashboard:getAllModels%
				%loop models%
				%ifvar ModelID -notempty%
					<TR>
					<SCRIPT>writeTD("row-l"); </SCRIPT>
					<INPUT type="hidden" name="processModelID" value="%value ModelID%">
					<A href="modelDetails.dsp?mid=%value ModelID%&version=%value ModelVersion%&url=list-all-process.dsp?mid=%value ../mid%"> %value ModelID% </A></TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processModelVersion" value="%value ModelVersion%">
					%value ModelVersion%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processEnabled" value="%value Enabled%">
					%ifvar Enabled equals('true')%
						<img src="images/green_check.gif" border="0">Yes
					%else%
						No
					%endif%
					</TD>  
					</TR>
					<SCRIPT>
						swapRows();
					</SCRIPT>
				%endif%
				%endscope%
				%endinvoke%
				
							
			</TBODY>
		</TABLE>
</BODY>
</HTML>

