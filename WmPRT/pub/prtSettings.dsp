<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache"/>
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'/>
<META HTTP-EQUIV="Expires" CONTENT="-1"/>
<TITLE>Process Engine Configuration Dash</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"/>
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<script language="JavaScript">
    var messageFlag = false;
    var cnt = 0;
    function getMessageFlag() { 
      return messageFlag;
    }
    function setMessageFlag(value) {
      messageFlag = value;
    }
    function this_writeMessage(value) {
      if (!messageFlag) // this will avoid more than one error message at a time.
        writeMessage(value);
    }
    function showCluster() {
      prop = "%sysvar property('watt.server.cluster.aliasList')%";
      if (prop == null || prop.length < 1)
        return false;
      else
        return true;
    }
    function toXML() {
	  document.performanceReport.SaveXML.value=true;
	  onSubmit();
	  return;
    }
    function onSubmit() {
	  document.performanceReport.submit();
	  %invoke wm.prt.dashboard:saveToXML%
	  %endinvoke% 
	  return;
    }    
  </script>
</HEAD>

<BODY>
<TABLE width="100%">
	<TR>
		<TD class="menusection-Settings">
			Process Engine &gt;	Settings
		</TD>
	</TR>
  <tr>
                <td valign="top">
                    <ul>
                        <li><a href="prtConfigSettings.dsp">Edit Process Engine Settings</a></li>
                    </ul>
                </td>
            </tr>
</TABLE>
	<!-- Process Engine Settings -->
			<TABLE>
			<TBODY>
				%invoke wm.prt.admin:configSettings%
    				%ifvar errorMessage%
        				<tr>
           					<td class="message">%value errorMessage%</td>
        				</tr>
    				%endif%
    				%ifvar message%
        				<tr>
          					<td class="message">%value message%</td>
        				</tr>
   				 %endif%
				<TR>
					<td class="heading" colspan="2">Retry Limits and Intervals</td>
				</TR>
				<TR>
					<TD class="oddrow" nowrap>Database Operation Retry Limit</TD>
					<INPUT type="hidden" name="dbRetries" value="%value dbRetries%">
					<TD class="oddrowdata-l" nowrap>%value dbRetries%</TD>
				</TR>
				<TR>
					<TD class="evenrow" nowrap>Database Operation Retry Interval (sec)</TD>
					<INPUT type="hidden" name="sleepTime" value="%value sleepTime%">
					<TD class="evenrowdata-l" nowrap>%value sleepTime%</TD>
				</TR>
	   			<TR>
	   				<TD colspan=2>&nbsp; </TD>
	   			</TR>
				<TR>
					<td class="heading" colspan="2">Database Cleanup and Expiration</td>
				</TR>
				<TR>
					<TD class="oddrow" nowrap>Cleanup Service Execution Interval (sec)</TD>
					<INPUT type="hidden" name="cleanInterval" value="%value cleanInterval%">
					<TD class="oddrowdata-l" nowrap>%value cleanInterval%</TD>
				</TR>
				<TR>
					<TD class="evenrow" nowrap>Completed Process Expiration (sec)</TD>
					<INPUT type="hidden" name="processExpire" value="%value processExpire%">
					<TD class="evenrowdata-l" nowrap>%value processExpire%</TD>
				</TR>
				<TR>
					<TD class="oddrow" nowrap>Failed Process Expiration (sec)</TD>
					<INPUT type="hidden" name="failedProcessExpire" value="%value failedProcessExpire%">
					<TD class="oddrowdata-l" nowrap>%value failedProcessExpire%</TD>
				</TR>
	   			<TR>
	   				<TD colspan=2>&nbsp; </TD>
	   			</TR>
				<TR>
					<td class="heading" colspan="2">webMethods Optimize</td>
				</TR>
				<TR>
					<TD class="oddrow" nowrap>JMS Server URL</TD>
					<INPUT type="hidden" name="brokerURL" value="%value brokerURL%">
					<TD class="oddrowdata-l" nowrap> %value brokerURL%</TD>
				</TR> 
				
				<TR>
	   				<TD colspan=2>&nbsp; </TD>
	   			</TR>
				
				<TR>
					<td class="heading" colspan="2">Advanced</td>
				</TR>
				<TR>
					<TD class="oddrow" nowrap>Duplicate Event Detection</TD>
					<TD class="oddrowdata-l" nowrap>
					%ifvar checkDuplicates equals('true')% Yes %else% No%endif%</TD>
				</TR>
	   			
				<TR>
					<TD class="evenrow" nowrap>Cache Cleanup Interval (sec)</TD>
					<INPUT type="hidden" name="cacheCleanupInterval" value="%value cacheCleanupInterval%">
					<TD class="evenrowdata-l" nowrap>%value cacheCleanupInterval%</TD>
				</TR> 
				
				<TR>
					<TD class="oddrow" nowrap>Maximum Cache Buffer Size</TD>
					<INPUT type="hidden" name="cacheBufferSize" value="%value cacheBufferSize%">
					<TD class="oddrowdata-l" nowrap>%value cacheBufferSize%</TD>
				</TR> 
				<TR>
					<TD class="evenrow" nowrap>External Cluster</TD>
					<TD class="evenrowdata-l" nowrap>
					 %ifvar externalCluster equals('true')% Yes %else% No%endif%</TD>
				</TR> 
				%endinvoke%
			</TBODY>
		</TABLE>
</BODY>
</HTML>
