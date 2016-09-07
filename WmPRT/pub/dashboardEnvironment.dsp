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

<BODY onLoad="setNavigation('prtPerformanceDash.dsp');">
<FORM name="performanceReport" method="POST">
<INPUT type="hidden" name="SaveXML" value="false">
<TABLE width="100%">
	<TR>
		<TD class="menusection-Settings">
			Process Engine &gt;	Environment
		</TD>
	</TR>

</TABLE>
<TABLE width="75%">
	<TR> 
		<TD colspan="2" class="heading">General</TD>
	</TR>
		<TR>
					%invoke wm.prt.dashboard:getIsClustered%
					<TD width="26%" class="oddrow-l" nowrap>Clustered</TD>
					<TD class="oddrow-l" nowrap>
					%ifvar clustered equals('true')%Yes&nbsp;
					%else% No %endif%</TD>
					%endinvoke%
		</TR> 
		<TR>
					<TD width="26%" class="evenrow-l" nowrap>Performance Collection</TD>
					<TD class="evenrow-l" nowrap>
					%invoke wm.prt.dashboard:getPerformanceCollector%
					%ifvar perfCollector equals('true')%On&nbsp;
					%else% Off %endif%</TD>
					%endinvoke%
		</TR>
					
</TABLE>				
			
	<!-- JDBC Connections -->
<br/>
		<TABLE width="75%" class="tableForm">
				<TBODY>
					<TR>
						<TD colspan="5" class="heading">JDBC Connections</TD>
					</TR>
				<TR>
					<TD width="25%" class="oddcol-l">JDBC Pool</TD>
           			<TD width="25%" class="oddcol">JDBC Alias</TD>
					<TD width="15%" class="oddcol">Minimum Connections</TD>
           			<TD width="15%" class="oddcol">Maximum Connections</TD>
					<TD width="15%" class="oddcol">Idle Timeout</TD>
				</TR>
				%invoke wm.prt.dashboard:getJDBCPoolSettings%
				%ifvar pools -notempty%
					<SCRIPT>resetRows();</SCRIPT>
					%loop pools%
					<TR>
						<SCRIPT>writeTD("row-l"); </SCRIPT>
						<INPUT type="hidden" name="jdbcFunctionName" value="%value FunctionName%">
						%value FunctionName%</TD>
						
						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<INPUT type="hidden" name="jdbcAliasName" value="%value AliasName%">
						%value AliasName%</TD>

						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<INPUT type="hidden" name="jdbcMinConnections" value="%value MinimumConnections%">
						%value MinimumConnections%</TD>

						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<INPUT type="hidden" name="jdbcMaxConnections" value="%value MaximumConnections%">
						%value MaximumConnections%</TD>

						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<INPUT type="hidden" name="jdbcIdleTimeout" value="%value IdleTimeout%">
						%value IdleTimeout%</TD>
						<SCRIPT>swapRows(); </SCRIPT>
					</TR>
					%endloop%
				%else%
					<TD width="100%" class="evencol-1">No Pools Configured</TD>
				%endif%
				%endinvoke%
			</TBODY>
		</TABLE>


	

%scope param(triggerName='wm.prt.status:controlTrigger')%
    %invoke wm.server.triggers:getTriggerReport%

	<!-- Individual Trigger Controls -->
<br/>      <table width="75%" class="tableForm">
        <tbody>
          <tr>
            <td colspan="2" class="heading">Control Triggers<br>
            </td>
          </tr>
        <tr>
            <td width="26%" class="oddcol-l">Name</td>
            <td class="oddcol-l">Enabled</td>
          </tr>
          	<SCRIPT>resetRows();</SCRIPT>
		%loop triggers%    
              <tr>
                <script>writeTD("row-l");</script>
                  <INPUT type="hidden" name="trigger" value="%value name%">
			%value name%<br>
		    </td>
              </td>

              <!-- ----------------------- -->
              <!-- Document Retrieval info -->  
              <!-- ----------------------- -->
              
              %ifvar retrievalStatus/state -notempty%
	            
	            %ifvar retrievalStatus/state equals('active')%
                  <script>writeTD("row-l");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes &nbsp;(Document Retrieval)
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="Yes">
	            %else% %ifvar retrievalStatus/state equals('active-temp')%
                  <script>writeTD("row-l");</script>
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes* &nbsp;(Document Retrieval)
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="Yes*">
	      
	            %else% %ifvar retrievalStatus/state equals('suspended')%
	              <script>writeTD("row-l");</script>No &nbsp;(Document Retrieval)
	         	<INPUT type="hidden" name="triggerRetrievalStatus" value="No">
	               
	            %else% <!-- else suspended-temp -->
	              <script>writeTD("row-l");</script>No* &nbsp;(Document Retrieval)
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="No*">
	               
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
		    <INPUT type="hidden" name="triggerRetrievalStatus" value="N/A">
                <script>writeTD("row-l");</script>N/A &nbsp;(Document Retrieval)
              %endif%     

                
              <!-- <script>writeTD("rowdata-l");</script>%value properties/ackQueueSize%</td> -->
            
              <!-- ------------------------ -->
              <!-- Document Processing info -->
              <!-- ------------------------ -->
              
              %ifvar processingStatus/state -notempty%
	            
	            %ifvar processingStatus/state equals('active')%
                  <br/><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes &nbsp;(Document Processing)</td>
	          	<INPUT type="hidden" name="triggerProcessingStatus" value="Yes&nbsp">
                  
	            %else% %ifvar processingStatus/state equals('active-temp')%
                  <br/><img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes* &nbsp;(Document Processing)</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="Yes*">
                   
	            %else% %ifvar processingStatus/state equals('suspended')%
	            <br/>No &nbsp;(Document Processing)</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="No">
                  
	            %else% <!-- else suspended-temp -->
	            <br/>No* &nbsp;(Document Processing)</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="No*">
                    
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
                <br/>N/A &nbsp;(Document Processing)</TD>
		    <INPUT type="hidden" name="triggerProcessingStatus" value="N/A">
              %endif% 
              
             <script>swapRows();</script>
            </tr>
            %endloop% 
 	    %onerror%
		<tr/>
        	<tr>
      		<script>this_writeMessage('%value errorMessage%');</script>
        	<script>setMessageFlag(true);</script>
      		</tr>
		%endinvoke%
      		%endscope%
	     	
%scope param(triggerName='wm.prt.status:BroadcastTrigger')% 
    %invoke wm.server.jms:getTriggerReport%
	
	<!-- Individual JMS Trigger Controls -->
              

          
            %ifvar trigger/enabled equals('true')% %endif%
              <tr>
                <script>writeTD("row-l");</script>%value node_nsName%</td>
		   <INPUT type="hidden" name="jmsTriggerName" value="%value node_nsName%">
                
                <script>writeTD("row-l");</script>

                %switch trigger/state%
                  %case '0'%
                    
                    %ifvar trigger/currentThreads equals('-1')%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
			    <INPUT type="hidden" name="jmsEnabled" value="Yes">
                    %else%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
                        <INPUT type="hidden" name="jmsEnabled" value="Yes">
                    %endif%
                    
                  %case '1'%
                    No
                    <INPUT type="hidden" name="jmsEnabled" value="No"> 
                  %case '2'%
                    <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="images/yellow_check.gif">Suspended<br>
                      <INPUT type="hidden" name="jmsEnabled" value="Suspended">
                %end%
                </td>
              </tr>
              
              <!-- Error Message --> 
              
              %ifvar trigger/lastError%
                <tr>
                  <script>writeTDspan("row-l", 8);</script>
                    <font color="red">%value trigger/lastError%</font><br>
                    <INPUT type="hidden" name="jmsError" value="%value trigger/lastError%"> 
                  </td>
                </tr>
              %endif%
              
              <script>swapRows();</script>
            
          %onerror%
	     <tr>
      		<script>this_writeMessage('%value errorMessage%');</script>
        	<script>setMessageFlag(true);</script>
	     </tr>
        </tbody>
      </table>
	%endinvoke%
%endscope%
%scope param(triggerName='wm.prt.status:RestartTrigger')% 
    %invoke wm.server.jms:getTriggerReport%
	
	<!-- Individual JMS Trigger Controls -->
              

          
            %ifvar trigger/enabled equals('true')% %endif%
              <tr>
                <script>writeTD("row-l");</script>%value node_nsName%</td>
		   <INPUT type="hidden" name="jmsTriggerName" value="%value node_nsName%">
                
                <script>writeTD("row-l");</script>

                %switch trigger/state%
                  %case '0'%
                    
                    %ifvar trigger/currentThreads equals('-1')%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
			    <INPUT type="hidden" name="jmsEnabled" value="Yes">
                    %else%
                      <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
                        <INPUT type="hidden" name="jmsEnabled" value="Yes">
                    %endif%
                    
                  %case '1'%
                    No
                    <INPUT type="hidden" name="jmsEnabled" value="No"> 
                  %case '2'%
                    <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="images/yellow_check.gif">Suspended<br>
                      <INPUT type="hidden" name="jmsEnabled" value="Suspended">
                %end%
                </td>
              </tr>
              
              <!-- Error Message --> 
              
              %ifvar trigger/lastError%
                <tr>
                  <script>writeTDspan("row-l", 8);</script>
                    <font color="red">%value trigger/lastError%</font><br>
                    <INPUT type="hidden" name="jmsError" value="%value trigger/lastError%"> 
                  </td>
                </tr>
              %endif%
              
              <script>swapRows();</script>
            
          %onerror%
	     <tr>
      		<script>this_writeMessage('%value errorMessage%');</script>
        	<script>setMessageFlag(true);</script>
	     </tr>
        </tbody>
      </table>
	%endinvoke%
%endscope%
</FORM>
</BODY>
</HTML>

