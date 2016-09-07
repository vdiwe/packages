<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Logical Servers</TITLE>
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META http-equiv=Pragma content=no-cache>
<META http-equiv=Expires content=-1>
<LINK href="webMethods.css" type=text/css rel=stylesheet>
<SCRIPT src="webMethods.js.txt"></SCRIPT>

<BODY>
<TABLE width="100%">
  <TR>
  	<TD height="5"></TD>
  </TR>
  <TR>
    <TD class=menusection-Packages>Logical Servers</TD>
  </tr>
</table>

<table>
	%ifvar action equals('delete')%
		%invoke wm.administrator.user:removeLogicalServer%
			%ifvar message%
			  <script>writeMessage("%value message%");</script>
			%end if%
		%onerror%
			<script>writeMessage("%value errorMessage%");</script>
		%end invoke%
	%end if%		
</table>
<TABLE cellSpacing=0 cellPadding=0 width="100%">
  <TBODY>
  <TR>
    <TD>
      <ul>
		<li><a href="addLogicalServer.dsp">Add Logical Server</a></li>
      </ul>
 </TD>
  </TR>
  </TBODY>
</TABLE>

<table>
  <tr>
    <td><img border="0" src="images/blank.gif" width="20" height="1"></td>
    <td class="heading" colspan="5" valign="top">
Logical Servers
    </td>
    <td valign="top">
    <img border="0" src="images/blank.gif" width="20" height="1"></td>
  </tr>
  <tr>
    <td valign="top"></td>
    <td class="oddcol-l" nowrap>Logical Server Name&nbsp;&nbsp;</td>
    <td width="100%" class="oddcol" nowrap align="center">Description</td>
    <td width="100%" class="oddcol" nowrap align="center">Physical Server Name&nbsp;&nbsp;</td>
    <td class="oddcol" nowrap>&nbsp;Edit&nbsp;</td>
    <td class="oddcol" nowrap>Remove</td>
    <td valign="top" ></td>
  </tr>
%invoke wm.administrator.user:getAllLogicalServers%
%loop logicalServer%
  <tr> 
	<td>&nbsp;</td>
	<script>writeTD("rowdata-l", "nowrap valign=\"top\"");</script>
	%value name%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"");</script>
	%value description%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	%value physicalServer%
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	<a HREF="editLogicalServer.dsp?serverName=%value name -urlencode%&returnToURL=logicalServers.dsp">Edit</a>
	</td>
	<script>writeTD("rowdata", "nowrap valign=\"top\"")</script>
	<a class="imagelink" HREF="logicalServers.dsp?action=delete&serverName=%value name -urlencode%" onclick="return confirmDelete('%value name%', 'true');"><img border="0" src="images/delete.gif" width="14" height="14"></a>
	</td>
	<td valign="top"></td>
	<script>
        	swapRows();
	</script> 
  </tr>
%endloop%

</table>

</BODY></HTML>
