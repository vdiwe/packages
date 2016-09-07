<HTML>
  <HEAD>
	<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
    <META HTTP-EQUIV="Expires" CONTENT="-1">
    <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
    <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
  </HEAD>

  <BODY>
<SCRIPT>
	function confirmAdd()
	{
		var name = document.registerform.name.value;
		
		if ( isblank(name) ) {
			alert( "Name is required.");
			return false;
		}
		
		//document.registerform.submit();
		return true;
	}
</SCRIPT>
<TABLE width="100%">
  <TR>
  	<TD height="5"></TD>
  </TR>
  <TR>
    <TD class=menusection-Packages>Logical Servers &gt; Add Logical Server</TD>
  </tr>
</table>

<table>
	%ifvar action equals('add')%
		%invoke wm.administrator.user:addLogicalServer%
			%ifvar message%
				<script>writeMessage("%value message%");</script>
			%end if%
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
</table>

<table>
  <TR>
	<TD colspan="2">
	  <UL>
	     <LI><A HREF="logicalServers.dsp">Return to Logical Servers</A></LI>
	  </UL>
	</TD>
  </TR>
</table>

<TABLE>
	<TR>
		<td>&nbsp;</td>
		<TD colspan="2" class="heading">Add Logical Server</TD>
		<td>&nbsp;</td>
	</TR>

    <FORM NAME="registerform" ACTION="addLogicalServer.dsp" METHOD="POST">
          <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Name:</TD>
            <TD class="oddrowdata-l">
              <INPUT NAME="name" VALUE="%value name%"> </TD>
            <td>&nbsp;</td>
          </TR>
	  <!--  bug 1-1J07DP
          <TR>
          	<td>&nbsp;</td>
            <TD class="evenrow">Type:</TD>
            <TD class="evenrowdata-l">
              <SELECT NAME="type">
		<OPTION value="IS">Integration Server</OPTION>
			  </SELECT>
			</TD>
            <td>&nbsp;</td>
          </TR>
	  -->
          <TR>
          	<td>&nbsp;</td>
            <TD class="evenrow">Description:</TD>
            <TD class="evenrowdata-l">
              <INPUT NAME="description" VALUE="%value description%"> (optional)</TD>
            <td>&nbsp;</td>
          </TR>
         <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Physical Server:</TD>
            <TD class="oddrowdata-l">
              <SELECT NAME="physicalServer">
		<OPTION value=""></OPTION>
%invoke wm.administrator.user:getServerAliases%
%loop -struct servers%
		<OPTION value="%value #$key/alias%">%value #$key/alias%</OPTION>
%endloop%
%endinvoke%
		</SELECT>
</TD>
             <td>&nbsp;</td>
          </TR>
          <TR>
          	<td>&nbsp;</td>
            <TD colspan=2 class="action">           
              <INPUT TYPE="hidden" NAME="action" VALUE="add">
              <INPUT TYPE="hidden" NAME="type" VALUE="IS">
              <INPUT type="submit" value="Add Logical Server" onclick="return confirmAdd()">
            </TD>
            <td>&nbsp;</td>
          </TR>
      </FORM>
</TABLE>


    </BODY>
  </HTML>

