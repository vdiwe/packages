<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Frame Top</TITLE>
<META http-equiv=Content-Type content="text/html; charset=utf-8">
<style>
BODY {
	FONT-SIZE: x-small; COLOR: black; LINE-HEIGHT: 12pt; FONT-FAMILY: Tahoma
}
.navbar {
	FONT-SIZE: x-small; COLOR: #ffffff; FONT-FAMILY: Tahoma;
}
.navbar A {
	FONT-SIZE: x-small; COLOR: #ffffff; FONT-FAMILY: Tahoma;
}
.maintitle {
	FONT-WEIGHT: bold; FONT-SIZE: x-small; letter-spacing: 2pt; COLOR: #ffffff; FONT-FAMILY: Tahoma
}
.sectionheader {
	FONT-WEIGHT: bold; FONT-SIZE: x-small; COLOR: black; FONT-FAMILY: Tahoma
}
.pagetext {
	FONT-WEIGHT: normal; FONT-SIZE: x-small; COLOR: black; LINE-HEIGHT: 12pt
}
A {
	FONT-SIZE: x-small; COLOR: #2a4b83; FONT-FAMILY: Tahoma;
}
.footer {
	FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana
}
A.footer {
	FONT-SIZE: 8pt; COLOR: #ffffff; FONT-FAMILY: Verdana
}
.Popup {
	FONT-WEIGHT: normal; FONT-SIZE: x-small; COLOR: black; LINE-HEIGHT: 12pt
}
.Popup A {
	FONT-WEIGHT: normal; FONT-SIZE: x-small; COLOR: #2a4b83; FONT-FAMILY: Tahoma; TEXT-DECORATION: underline
}
</style>
</HEAD>

<script>
function loadPage(url)
{
	window.location.replace(url);
}


%ifvar message%
  %ifvar norefresh%%else%
    setTimeout("loadPage('frame_top.dsp')", 30000);
        %endif%
%endif%
</script>

<BODY vLink=#003399 aLink=#003399 link=#003399 leftMargin=0 topMargin=0>
<TABLE cellSpacing=0 cellPadding=0 width=100% height=100% style="border-collapse: collapse" >
  <TBODY>
  
  <tr>
  <td>
        <TABLE width=100% CELLSPACING=0 BORDER=0>
           <TR>
              <TD nowrap class="maintitle" width="100%" bgcolor="#000000">webMethods Designer</TD>
              <TD bgcolor="#ffffff"><IMG src="images/newlogo.gif" border=0></TD>
           </TR>
        </TABLE>
  </td>
  </tr>

  <TR>
    <TD valign=top align=right colSpan=2 height=65 bgcolor="#2C4B84">
    <a class=navbar href="/invoke/wm.administrator.user/disconnect" target=_top><font color="#FFFFFF">Log Off</font></a>
    <font color="#FFFFFF"></a>&nbsp;&nbsp;
    </TD>

  </TR>
</BODY></HTML>
