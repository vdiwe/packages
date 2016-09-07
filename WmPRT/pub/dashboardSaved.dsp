<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Process Engine Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>
<BODY>

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings">
          Process Engine &gt;
          Save to File
      </TD>
    </TR>
    <tr>
          <td valign="top">
            <ul>
             <li><a href="/WmPRT/">Return to Process Engine Home Page</a></li>
            </ul>
          </td>
     </tr>
  
	
  %invoke wm.prt.dashboard:saveTextFile%
	<TR> <TD> File saved to: <A href=%value savedURL%> %value savedURL% </A> </TD> </TR>
  %endinvoke%
</TABLE>
</BODY>
</HTML>	