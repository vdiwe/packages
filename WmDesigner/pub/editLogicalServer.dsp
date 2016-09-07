<HTML>
<HEAD>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>

<BODY>

<TABLE width="100%">
  <TR>
  	<TD height="5"></TD>
  </TR>
  <TR>
    <TD class=menusection-Packages>Logical Servers &gt; Edit Logical Server</TD>
  </tr>
</TABLE>

<TABLE>
	%ifvar action equals('edit')%
		%invoke wm.administrator.user:editLogicalServer%
			%ifvar message%
				<script>writeMessage("%value message%");</script>
			%end if%
		%onerror%
			%loop -struct%
				<tr><td>%value $key%=%value%</td></tr>
			%endloop%
		%end invoke%
	%end if%
</TABLE>

%invoke wm.administrator.user:getLogicalServer%
%scope logicalServer%
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
		<TD colspan="2" class="heading">Edit Logical Server</TD>
		<td>&nbsp;</td>
	</TR>

    <FORM NAME="registerform" ACTION="editLogicalServer.dsp" METHOD="POST">
          <TR>
          	<td>&nbsp;</td>
            <TD class="oddrow">Name:</TD>
            <TD class="oddrowdata-l">
              %value name%</TD>
              <INPUT type="hidden" NAME="name" VALUE="%value name%"></TD>
            <td>&nbsp;</td>
          </TR>
	  <!-- bug 1-1J07DP
          <TR>
          	<td>&nbsp;</td>
            <TD class="evenrow">Type:</TD>
            <TD class="evenrowdata-l">
              <SELECT NAME="type">
		<OPTION value="IS" %ifvar type equals('IS')% selected %endif%>Integration Server</OPTION>
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
		<OPTION value="" %ifvar /logicalServer/physicalServer equals('')% selected %endif%></OPTION>
%invoke wm.administrator.user:getServerAliases%
%loop -struct servers%
		<OPTION value="%value #$key/alias%" %ifvar #$key/alias vequals(/logicalServer/physicalServer)% selected %endif%>%value #$key/alias%</OPTION>
%endloop%
%endinvoke%
		</SELECT>
</TD>
             <td>&nbsp;</td>
          </TR>
          <TR>
          	<td>&nbsp;</td>
            <TD colspan=2 class="action">           
              <INPUT TYPE="hidden" NAME="action" VALUE="edit">
              <INPUT TYPE="hidden" NAME="type" VALUE="IS">
              <INPUT type="submit" value="Save Changes">
            </TD>
            <td>&nbsp;</td>
          </TR>
      </FORM>
</TABLE>
%endscope%
%endinvoke%

</BODY>
</HTML>

