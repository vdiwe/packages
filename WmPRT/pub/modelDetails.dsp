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
				document.write(" &gt; ");
			document.write(node[i]);
		}
	}
}
</SCRIPT>
</HEAD>
<FORM name="eFormRestart" method="POST">	
<INPUT type="hidden" name="version" value="%value version%">
<INPUT type="hidden" name="mid" value="%value mid%">
<INPUT type="hidden" name="url" value="%value url%">
	
<BODY>
 <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings" colspan="2" NOWRAP>
	    <SCRIPT>getMID('%value encode(javascript) mid%');</SCRIPT> &gt;
	    Details
      </TD>
    </TR>
    %ifvar restart -notempty%
		%rename restart friendlyName%
		%invoke wm.prt.dashboard:restartContentRepository%
			<TR>
				<TD class="message" colspan="2">
				%value errorMessage%
				</TD>
			</TR>
		%endinvoke%
	%endif%
 <tr>
          <td valign="top" colspan="2">
            <ul>
             <li><a href="%value url%">Return to Previous Page</a></li>
            </ul>
          </td>
     </tr>
</TABLE>
%invoke wm.prt.dashboard:getProcessDetails%
%scope models%	
		<TABLE width="100%">
			<TBODY>
				%ifvar ModelID -notempty%
				<TR>
					<TD colspan="2" CLASS="heading">Process Settings  	
					</TD>
	    			</TR>
				<TR>
					<TD width="30%" class="oddrow">Version</TD>
					<TD class="oddrowdata-l">%value ModelVersion%</TD>
				</TR>
				<TR>
					<TD class="evenrow">Enabled</TD>
					<TD class="evenrowdata-l">
					%ifvar Enabled equals('true')%
							<img src="images/green_check.gif" border="0">Yes
						%else%
							No
						%endif%
					</TD>
				<TR>
					<TD class="oddrow">Instance Logging</td>
					<TD class="oddrowdata-l"><INPUT type="hidden" name="InstanceLogging" value="%value InstanceLogging%">
						%ifvar InstanceLogging equals('true')%
							Yes
						%else%
							No
						%endif% 
					</td>
					
				</TR>
				<TR>
					<TD class="evenrow">Logging Level</td>
					<TD class="evenrowdata-l"><INPUT type="hidden" name="processLoggingLevel" value="%value LoggingLevel%">
						%value LoggingLevel%
					
				</TR>
				<TR>
					<TD class="oddrow">Log Transitions</td>
					<TD class="oddrowdata-l">	<INPUT type="hidden" name="processLogTransitions" value="%value LogTransitions%">
						%ifvar LogTransitions equals('true')%
							Yes
						%else%
							No
						%endif% 
					</td>
					
            	</TR>
				<TR>
					<TD class="evenrow">Volatile Tracking</td>
					<TD class="evenrowdata-l"> 	<INPUT type="hidden" name="processVolatileTracking" value="%value VolatileTracking%">
					%ifvar VolatileTracking equals('true')%
							Yes
						%else%
							No
						%endif% </td>
					
				</TR>
				<TR>
					<TD class="oddrow">Volatile Transitions</td>
					<TD class="oddrowdata-l"> <INPUT type="hidden" name="processVolatileTransitions" value="%value VolatileTransitions%">
					%ifvar VolatileTransitions equals('true')%
							Yes
						%else%
							No
						%endif%</td>
					
				</TR>
				<TR>
					<TD class="evenrow">Optimize Locally</td>
					<TD class="evenrowdata-l"> <INPUT type="hidden" name="processOptimizeLocally" value="%value OptimizeLocally%">
					%ifvar OptimizeLocally equals('true')%
							Yes
						%else%
							No
						%endif%</td>
					
				</TR>
				<TR>
					<TD class="oddrow">Uses JMS</TD>
					<TD class="oddrowdata-l"> <INPUT type="hidden" name="processUsesJMS" value="%value UsesJMS%">
					%ifvar UsesJMS equals('true')%
							Yes
						%else%
							No
						%endif% </TD>
					
				</TR>
				<TR>
					<TD class="evenrow">Single Server</TD>
					<TD class="evenrowdata-l"><INPUT type="hidden" name="processSingleServer" value="%value SingleServer%">
					%ifvar SingleServer equals('true')%
							Yes
						%else%
							No
						%endif%</TD>
					
				</TR>
				<TR>
					<TD class="oddrow">Express Pipeline </TD>
					<TD class="oddrowdata-l"> <INPUT type="hidden" name="processExpressPipeline" value="%value ExpressPipeline%">
					%ifvar ExpressPipeline equals('true')%
							Yes
						%else%
							No
						%endif% </TD>
					
				</TR>
				<TR>
					<TD class="evenrow">Resubmission StepID(s)</td>
					<TD class="evenrowdata-l">%ifvar EnableResubmissionTrueArray -notempty%
						<INPUT type="hidden" name="processStepIDs" value="%value EnableResubmissionTrueList%">
						<select name=%value ModelID% size=1>
						%loop EnableResubmissionTrueArray%
							<option value="%value StepID%">%value StepID%</option>
						%endloop%
						</select>
						</TD>					
					%else%			
						<select name=%value ModelID% size=1>
						<option value="false">none</option>
						<INPUT type="hidden" name="processStepIDs" value="none">
						</select>
						</TD>	
					%endif%
					
				</TR>
			%endif%
			
				
							
			</TBODY>
		</TABLE>
		<br/>
		<TABLE width="100%">
			<TBODY>
				<TR>
					<TD colspan="2" CLASS="heading">Triggers</TD>
				</TR>
         			<tr>
            				<td width="20%" class="oddcol-l">Name</td>
            				<td class="oddcol-l">Enabled</td>
          			</tr>
				%rename triggerName subscriptionTrigger%
				%rename inputTriggerName triggerName%
				%include dashboardProcessTrigger.dsp%
				%rename subscriptionTrigger triggerName%
				%include dashboardProcessTrigger.dsp%
				
			</TBODY>
		</TABLE>
		<br/>
		%ifvar eFormCR -notempty%
		<TABLE width="100%" class="tableForm">
        		<tbody>
          			<TR>
					<TD colspan="4" CLASS="heading">E-form Content Repository Listeners</TD>
	    			</TR>
				<TR>
					<TD width="20%" class="oddcol-l">Name</TD>
					<TD width="10%" class="oddcol">Status</TD>
					<TD width="10%" class="oddcol">Restart Function</TD>
					<TD class="oddcol">Messages</TD>
				</TR>
				<INPUT type="hidden" name="friendlyName">
				%loop eFormCR%
				<TR>
					<SCRIPT>writeTD("row-l"); </SCRIPT>
					<A HREF="contentRepository.dsp?newDoc=&friendlyName=%value friendlyName%&mid=%value ../../mid%&version=%value ../../version%&url=%value ../../url%">&nbsp;%value friendlyName%</A></TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
						%ifvar listenerStatus equals('true')%
							<img src="images/green-ball.gif" border="0">
						%else%
							<img src="images/red-ball.gif" border="0">
							<INPUT type="hidden" name="RestartAll" value="%value friendlyName%">
						%endif%
					</TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<A href="modelDetails.dsp?mid=%value ../../mid%&version=%value ../../version%&restart=%value friendlyName%&url=%value ../../url%"> Restart </A>
					</TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
						%ifvar listenerStatus equals('true')%
						&nbsp;
						%else%
						%value ../../message%
						%endif%
					</TD>
					<SCRIPT>swapRows();</SCRIPT>
					%endscope%
				%endloop%
	  		</TBODY>
		</TABLE>	
		%endif%
</BODY>
</FORM>
%endscope%
%endinvoke%	
</HTML>
