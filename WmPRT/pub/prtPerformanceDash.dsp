<HTML><HEAD><META http-equiv="Pragma" content="no-cache"/><META http-equiv='Content-Type' content='text/html; charset=UTF-8'/><META HTTP-EQUIV="Expires" CONTENT="-1"/>
<TITLE>Process Engine Configuration Dash</TITLE><LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css"/><SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<script language="JavaScript">    var messageFlag = false;    var cnt = 0;
    function getMessageFlag() {       return messageFlag;    }
    function setMessageFlag(value) {      messageFlag = value;    }
    function this_writeMessage(value) {      if (!messageFlag) // this will avoid more than one error message at a time.        writeMessage(value);    }
    function showCluster() {      prop = "%sysvar property('watt.server.cluster.aliasList')%";      if (prop == null || prop.length < 1)        return false;      else        return true;    }
    function toXML() {	  document.performanceReport.SaveXML.value=true;	  onSubmit();	  return;    }
    function onSubmit() {	  document.performanceReport.submit();	  %invoke wm.prt.dashboard:saveToXML%	  %endinvoke% 	  return;    }      </script></HEAD>

<BODY onLoad="setNavigation('prtPerformanceDash.dsp');"><FORM name="performanceReport" method="POST"><INPUT type="hidden" name="SaveXML" value="false">
<TABLE width="100%">	<TR>		<TD class="menusection-Settings" colspan="2">			Process Engine &gt;	Dashboard		</TD>	</TR>	<!-- Process Engine Settings -->
	<TR>		<TD>			<TABLE style="width: 100%;">			<TBODY>				<TR>            		<TD width="50%" colspan="2" class="menusection-Settings">Process Engine Settings</TD>				</TR>
				%invoke wm.prt.admin:configSettings%    				%ifvar errorMessage%        				<tr>           					<td class="message">%value errorMessage%</td>        				</tr>    				%endif%
    				%ifvar message%        				<tr>          					<td class="message">%value message%</td>        				</tr>   				 %endif%
				<TR>					<TD class="evenrow-l" nowrap>Database Operation Retry Limit</TD>					<INPUT type="hidden" name="dbRetries" value="%value dbRetries%">					<TD class="evenrowdata-l" nowrap>%value dbRetries%</TD>				</TR>
				<TR>					<TD class="oddrow-l" nowrap>Database Operation Retry Interval (sec)</TD>					<INPUT type="hidden" name="sleepTime" value="%value sleepTime%">					<TD class="oddrowdata-l" nowrap>%value sleepTime%</TD>				</TR>
				<TR>					<TD class="evenrow-l" nowrap>Cleanup Service Execution Interval (sec)</TD>					<INPUT type="hidden" name="cleanInterval" value="%value cleanInterval%">					<TD class="evenrowdata-l" nowrap>%value cleanInterval%</TD>				</TR>
				<TR>					<TD class="oddrow-l" nowrap>Completed Process Expiration (sec)</TD>					<INPUT type="hidden" name="processExpire" value="%value processExpire%">					<TD class="oddrowdata-l" nowrap>%value processExpire%</TD>				</TR>
				<TR>					<TD class="evenrow-l" nowrap>Failed Process Expiration (sec)</TD>					<INPUT type="hidden" name="failedProcessExpire" value="%value failedProcessExpire%">					<TD class="evenrowdata-l" nowrap>%value failedProcessExpire%</TD>				</TR>
				<TR>					<TD class="oddrow-l" nowrap>Duplicate Event Detection</TD>					<INPUT type="hidden" name="checkDuplicates" value="%value checkDuplicates%">					<TD class="oddrowdata-l" nowrap>%value checkDuplicates%</TD>				</TR>
				<TR>					<TD class="evenrow-l" nowrap>Optimize Referenced Process Execution</TD>					<INPUT type="hidden" name="optimizeRefProcess" value="%value optimizeRefProcess%">					<TD class="evenrowdata-l" nowrap>%value optimizeRefProcess%</TD>				</TR>
				<TR>					<TD class="oddrow-l" nowrap>Cache Cleanup Interval</TD>					<INPUT type="hidden" name="cacheCleanupInterval" value="%value cacheCleanupInterval%">					<TD class="oddrowdata-l" nowrap>%value cacheCleanupInterval%</TD>				</TR> 								<TR>					<TD class="evenrow-l" nowrap>Maximum Cache Buffer Size</TD>					<INPUT type="hidden" name="maxCacheBufferSize" value="%value maxCacheBufferSize%">					<TD class="evenrowdata-l" nowrap>%value maxCacheBufferSize%</TD>				</TR> 
				<TR>					%invoke wm.prt.dashboard:getIsClustered%					<TD class="oddrow-l" nowrap>Clustered</TD>					<INPUT type="hidden" name="clustered" value="%value clustered%">					<TD class="oddrowdata-l" nowrap> %value clustered%</TD>					%endinvoke%				</TR> 
				<TR>					%invoke wm.prt.dashboard:getUsingClusterCache%					<TD class="evenrow-l" nowrap>Using Cluster Cache</TD>					<INPUT type="hidden" name="clusterCache" value="%value clusterCache%">					<TD class="evenrowdata-l" nowrap> %value clusterCache%</TD>					%endinvoke%				</TR> 				<TR>					<TD class="oddrow-l" nowrap>Clustered Join Lock Retry Interval (ms)</TD>					<INPUT type="hidden" name="sleepLockInterval" value="%value sleepLockInterval%">					<TD class="oddrowdata-l" nowrap>%value sleepLockInterval%</TD>				</TR> 				<TR>					<TD class="evenrow-l" nowrap>Optimize Broker URL</TD>					<INPUT type="hidden" name="brokerURL" value="%value brokerURL%">					<TD class="evenrowdata-l" nowrap> %value brokerURL%</TD>				</TR> 				%endinvoke%			</TBODY>		</TABLE>	<!-- Process Audit Settings -->
		<TABLE width="100%" class="tableForm">				<TBODY>					<TR>						<TD class="menusection-Settings">Process Audit Settings</TD>					</TR>				</TBODY>		</TABLE>		<TABLE style="width: 100%;">			<TBODY>				<TR>					<TD width="25%" class="oddcol-l">Logger Name</TD>           			<TD width="25%" class="oddcol">Enabled</TD>					<TD width="15%" class="oddcol">Mode</TD>           			<TD width="15%" class="oddcol">Guaranteed</TD>					<TD width="15%" class="oddcol">Destination</TD>				</TR>				%invoke wm.prt.dashboard:getProcessAuditSettings%				%ifvar ProcAuditSettings -notempty%					%loop ProcAuditSettings%					<TR>						<SCRIPT>writeTD("row-l"); </SCRIPT>						<INPUT type="hidden" name="loggerName" value="%value LoggerName%">						<a href=../WmRoot/settings-auditing-detail.dsp?loggerName=%value -urlencode LoggerName%>%value LoggerName%</a></TD>												<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="enabled" value="%value Enabled%">						%value Enabled%</TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="mode" value="%value Mode%">						%value Mode%</TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="guaranteed" value="%value Guaranteed%">						%value Guaranteed%</TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="destination" value="%value Destination%">						%value Destination%</TD>						<SCRIPT>swapRows(); </SCRIPT>					</TR>					%endloop%				%else%					<TD width="100%" class="evencol-1">No Process Audit Settings Configured</TD>				%endif%				%endinvoke%			</TBODY>		</TABLE>	<!-- JDBC Connections -->		<TABLE width="100%" class="tableForm">				<TBODY>					<TR>						<TD class="menusection-Security">JDBC Connections</TD>					</TR>				</TBODY>		</TABLE>
		<TABLE style="width: 100%;">			<TBODY>				<TR>					<TD width="25%" class="oddcol-l">JDBC Pool</TD>           			<TD width="25%" class="oddcol">JDBC Alias</TD>					<TD width="15%" class="oddcol">Minimum Connections</TD>           			<TD width="15%" class="oddcol">Maximum Connections</TD>					<TD width="15%" class="oddcol">Idle Timeout</TD>				</TR>
				%invoke wm.prt.dashboard:getJDBCPoolSettings%
				%ifvar pools -notempty%					%loop pools%					<TR>						<SCRIPT>writeTD("row-l"); </SCRIPT>						<INPUT type="hidden" name="jdbcFunctionName" value="%value FunctionName%">						%value FunctionName%</TD>												<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="jdbcAliasName" value="%value AliasName%">						<a href=../WmRoot/settings-editjdbcpool.dsp?funct=Display&pool=%value -urlencode AliasName%>%value AliasName%</a></TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="jdbcMinConnections" value="%value MinimumConnections%">						%value MinimumConnections%</TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="jdbcMaxConnections" value="%value MaximumConnections%">						%value MaximumConnections%</TD>						<SCRIPT>writeTD("rowdata"); </SCRIPT>						<INPUT type="hidden" name="jdbcIdleTimeout" value="%value IdleTimeout%">						%value IdleTimeout%</TD>						<SCRIPT>swapRows(); </SCRIPT>					</TR>					%endloop%				%else%					<TD width="100%" class="evencol-1">No Pools Configured</TD>				%endif%
				%endinvoke%			</TBODY>		</TABLE>	<!-- Individual Process Settings -->
		<table width="100%" class="tableForm">
        			<tbody>
          				<TR>
						<TD CLASS="menusection-Settings">Individual Process Settings</TD>
	    				</TR>
	  			</TBODY>
			</TABLE>
		<TABLE style="width: 100%;">
			<TBODY>
				<TR>
					<TD width="30%" class="oddcol-l">Process Name</td>
					<TD width="10%" class="oddcol">Enabled</TD>
					<TD width="10%" class="oddcol">Version</td>
            			<TD width="10%" class="oddcol">Logging Level</td>
					<TD width="10%" class="oddcol">Log Transitions</td>
            			<TD width="10%" class="oddcol">Volatile Tracking</td>
					<TD width="10%" class="oddcol">Volatile Transitions</td>
					<TD width="10%" class="oddcol">Optimize Locally</td>
					<TD width="10%" class="oddcol">Uses JMS</TD>
					<TD width="10%" class="oddcol">Single Server</TD>
					<TD width="10%" class="oddcol">Express Pipeline </TD>
					<TD width="10%" class="oddcol">Resubmission StepID(s)</td>
				</TR>
				%invoke wm.prt.dashboard:getProcessSettings%
				%loop models%
				%ifvar ModelID -notempty%
					<TR>
					<SCRIPT>writeTD("row-l"); </SCRIPT>
					<INPUT type="hidden" name="processModelID" value="%value ModelID%">
					%value ModelID%</TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processEnabled" value="%value Enabled%">
					%ifvar Enabled equals('true')%
						<img src="images/green-ball.gif" border="0">
					%else%
						<img src="images/red-ball.gif" border="0">
					%endif%
					</TD>  
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processModelVersion" value="%value ModelVersion%">
					%value ModelVersion%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processLoggingLevel" value="%value LoggingLevel%">
					%value LoggingLevel%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processLogTransitions" value="%value LogTransitions%">
					%value LogTransitions%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processVolatileTracking" value="%value VolatileTracking%">
					%value VolatileTracking%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processVolatileTransitions" value="%value VolatileTransitions%">
					%value VolatileTransitions%</td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processOptimizeLocally" value="%value OptimizeLocally%">
					%value OptimizeLocally% </td>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processUsesJMS" value="%value UsesJMS%">
					%value UsesJMS% </TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processSingleServer" value="%value SingleServer%">
					%value SingleServer% </TD>
					<SCRIPT>writeTD("rowdata"); </SCRIPT>
					<INPUT type="hidden" name="processExpressPipeline" value="%value ExpressPipeline%">
					%value ExpressPipeline% </TD>
					%ifvar EnableResubmissionTrueArray -notempty%
						<INPUT type="hidden" name="processStepIDs" value="%value EnableResubmissionTrueList%">
						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<select name=%value ModelID% size=1>
						%loop EnableResubmissionTrueArray%
							<option value="%value StepID%">%value StepID%</option>
						%endloop%
						</select>
						</TD>					
					%else%			
						<SCRIPT>writeTD("rowdata"); </SCRIPT>
						<select name=%value ModelID% size=1>
						<option value="false">none</option>
						<INPUT type="hidden" name="processStepIDs" value="none">
						</select>
						</TD>	
					%endif%
					</TR>
					<SCRIPT>
						swapRows();
					</SCRIPT>
				%endif%
				%endloop%
				%endinvoke%
				
							
			</TBODY>
		</TABLE>

           
</TABLE>
		
	  </TR>
	 </TD>
</TABLE>
	<!-- Global Trigger Controls -->
<table width="100%">
  <tbody>
%rename triggerName none%
    %invoke wm.server.triggers:getTriggerReport%
    
    <tr>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
           <td class="menusection-Settings">Global Trigger Controls</td>
          </tr>
        </tbody>
      </table>
      <table style="width: 100%;">
        <tbody>
          <tr>
            <td width="50%" colspan="2" class="oddcol">Document Retrieval</td>
            <td width="50%" colspan="2" class="oddcol">Document Processing</td>
          </tr>
          <tr>
            <td class="evenrow-l" nowrap>Current Threads</td>
		%ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <INPUT type="hidden" name="currentNumberDocumentRetrievalThreads" value="%value globalSettings/currentNumberDocumentRetrievalThreads%">
              <td class="evenrowdata-l" nowrap>%value globalSettings/currentNumberDocumentRetrievalThreads%</td>
            %else%
              <INPUT type="hidden" name="currentNumberDocumentRetrievalThreads" value="N/A">
		  <td class="evenrowdata-l" nowrap>N/A</td>
            %endif%
            <td class="evenrow-l" nowrap>Current Threads</td>
            <INPUT type="hidden" name="currentNumberTriggerExecutionThreads" value="%value globalSettings/currentNumberTriggerExecutionThreads%">
            <td class="evenrowdata-l" nowrap>%value globalSettings/currentNumberTriggerExecutionThreads%</td>
          </tr>
          <tr>
            <td class="oddrow-l" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumDocumentRetrievalThreadsPct -notempty%
              <INPUT type="hidden" name="maximumDocumentRetrievalThreadsPct" value="%value globalSettings/maximumDocumentRetrievalThreadsCount% (%value globalSettings/maximumDocumentRetrievalThreadsPct%% of Server Thread Pool)">
              <td class="oddrowdata-l" nowrap>%value globalSettings/maximumDocumentRetrievalThreadsCount% (%value globalSettings/maximumDocumentRetrievalThreadsPct%% of Server Thread Pool)</td>
            %else%
              <INPUT type="hidden" name="maximumDocumentRetrievalThreadsPct" value="(Broker Not Configured)">
		  <td class="oddrowdata-l" nowrap>(Broker Not Configured)</td>
            %endif%
            <td class="oddrow-l" nowrap>Maximum Threads</td>
            %ifvar globalSettings/maximumTriggerExecutionThreadsCount -notempty%
              <INPUT type="hidden" name="maximumTriggerExecutionThreadsCount" value="%value globalSettings/maximumTriggerExecutionThreadsCount% (%value globalSettings/maximumTriggerExecutionThreadsPct%% of Server Thread Pool)">
              <td class="oddrowdata-l" nowrap>%value globalSettings/maximumTriggerExecutionThreadsCount% (%value globalSettings/maximumTriggerExecutionThreadsPct%% of Server Thread Pool)</td>
            %else%
              <td class="oddrowdata-l" nowrap></td>
            %endif%
          </tr>
          <tr>
            <td class="evenrow-l" nowrap>Queue Capacity Throttle</td>
            <INPUT type="hidden" name="triggerDocumentStoreThrottle" value="%value globalSettings/triggerDocumentStoreThrottle%%">
            <td class="evenrowdata-l">%value globalSettings/triggerDocumentStoreThrottle%%</td>
            <td class="evenrow-l" nowrap>Execution Threads Throttle</td>
            <INPUT type="hidden" name="triggerExecutionThreadsThrottle" value="%value globalSettings/triggerExecutionThreadsThrottle%%">
            <td class="evenrowdata-l">%value globalSettings/triggerExecutionThreadsThrottle%%</td>
          </tr>

        </tbody>
      </table>
    </tr>

    <tr>
    </tr>	<!-- Individual Trigger Controls -->
    <tr>
      <td>
      <table width="100%" class="tableForm">
        <tbody>
          <tr>
            <td class="menusection-Settings">Individual Trigger Controls<br>
            </td>
          </tr>
        </tbody>
      </table>
      <table style="width: 100%;">
        <tbody>

          <tr>
            <td style="" colspan="1" rowspan="1" class="oddcol-l"><br>
            </td>
            <td colspan="3" class="oddcol" nowrap>Document Retrieval</td>
            <td colspan="6" class="oddcol">Document Processing<br>
            </td>
          </tr>
          <tr>
            <td class="oddcol-l">Name</td>
            <td class="oddcol">Active<br><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=all">edit&nbsp;all</a></td>
            <td class="oddcol-l">Queue Capacity</td>
            <td class="oddcol-l">Queue Refill&nbsp;Level</td>
            <td class="oddcol">Active<br><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=all">edit&nbsp;all</a></td>
            <td class="oddcol-l">Processing Mode</td>
            <td class="oddcol-l">Maximum Threads</td>
            <td class="oddcol-l">Current Threads</td>
            <td class="oddcol-l">Volatile Queue</td>
            <td class="oddcol-l">Persisted Queue</td>
          </tr>
          	%loop triggers%    
              <tr>
                <script>writeTD("row-l");</script>
                  <INPUT type="hidden" name="trigger" value="%value name%">
			<a href="../WmRoot/trigger-management-details.dsp?triggerName=%value name%">%value name%<br>
		    </td></a>
              </td>

              <!-- ----------------------- -->
              <!-- Document Retrieval info -->  
              <!-- ----------------------- -->
              
              %ifvar retrievalStatus/state -notempty%
	            
	            %ifvar retrievalStatus/state equals('active')%
                  <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>&nbsp;</td>
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="Yes">
	            %else% %ifvar retrievalStatus/state equals('active-temp')%
                  <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>*</td>
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="Yes*">
	      
	            %else% %ifvar retrievalStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=active">No</a>&nbsp;</td>
	         	<INPUT type="hidden" name="triggerRetrievalStatus" value="No">
	               
	            %else% <!-- else suspended-temp -->
	              <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setRetrievalStatus=active">No</a>*</td>
	            <INPUT type="hidden" name="triggerRetrievalStatus" value="No*">
	               
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
		    <INPUT type="hidden" name="triggerRetrievalStatus" value="N/A">
                <script>writeTD("rowdata-l");</script>N/A</TD>
              %endif%     

              %ifvar retrievalStatus/state matches('active*')%
                %ifvar properties/queueCapacity vequals(properties/queueCapacityThrottle)%
                  <INPUT type="hidden" name="triggerQueueCapacity" value="%value properties/queueCapacity%">
                	<INPUT type="hidden" name="triggerQueueRefillLevel" value="%value properties/queueRefillLevel%">
                	<script>writeTD("rowdata-l");</script>%value properties/queueCapacity%</td>
                  <script>writeTD("rowdata-l");</script>%value properties/queueRefillLevel%</td>
                %else%
                  <INPUT type="hidden" name="triggerQueueCapacity" value="%value properties/queueCapacityThrottle%&nbsp;(%value properties/queueCapacity%)">
                	<INPUT type="hidden" name="triggerQueueRefillLevel" value="%value properties/queueRefillLevelThrottle%&nbsp;(%value properties/queueRefillLevel%)">
                	<script>writeTD("rowdata-l");</script>%value properties/queueCapacityThrottle%&nbsp;(%value properties/queueCapacity%)</td>
                  <script>writeTD("rowdata-l");</script>%value properties/queueRefillLevelThrottle%&nbsp;(%value properties/queueRefillLevel%)</td>
                %endif%   
              %else%
                <INPUT type="hidden" name="triggerQueueCapacity" value="0&nbsp;(%value properties/queueCapacity%)">
                <INPUT type="hidden" name="triggerQueueRefillLevel" value="0&nbsp;(%value properties/queueRefillLevel%)">
                	<script>writeTD("rowdata-l");</script>0&nbsp;(%value properties/queueCapacity%)</td>
                <script>writeTD("rowdata-l");</script>0&nbsp;(%value properties/queueRefillLevel%)</td>  
              %endif%
              
              <!-- <script>writeTD("rowdata-l");</script>%value properties/ackQueueSize%</td> -->
            
              <!-- ------------------------ -->
              <!-- Document Processing info -->
              <!-- ------------------------ -->
              
              %ifvar processingStatus/state -notempty%
	            
	            %ifvar processingStatus/state equals('active')%
                  <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>&nbsp;</td>
	          	<INPUT type="hidden" name="triggerProcessingStatus" value="Yes&nbsp">
                  
	            %else% %ifvar processingStatus/state equals('active-temp')%
                  <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=suspended">
	              <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes</a>*</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="Yes*">
                   
	            %else% %ifvar processingStatus/state equals('suspended')%
	              <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=active">No</a>&nbsp;</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="No&nbsp">
                  
	            %else% <!-- else suspended-temp -->
	            <script>writeTD("rowdata");</script><a href="../WmRoot/trigger-management-edit-state.dsp?triggerName=%value name%&setProcessingStatus=active">No</a>*</td>
	            <INPUT type="hidden" name="triggerProcessingStatus" value="No*">
                    
	            %endif%
	            %endif%
	            %endif%
	          
	          %else%
                <script>writeTD("rowdata-l");</script>N/A</TD>
		    <INPUT type="hidden" name="triggerProcessingStatus" value="N/A">
              %endif% 
              
              %ifvar properties/isConcurrent equals('true')%
		    <INPUT type="hidden" name="triggerProcessingMode" value="Concurrent">
                  
                <script>writeTD("rowdata-l");</script>Concurrent</td>
                %ifvar processingStatus/state matches('active*')%
                  %ifvar properties/maxExecutionThreads vequals(properties/maxExecutionThreadsThrottle)%
			  <INPUT type="hidden" name="triggerMaximumThreads" value="%value properties/maxExecutionThreads%">
                    <script>writeTD("rowdata-l");</script>%value properties/maxExecutionThreads%</td>
                  %else%
                    <script>writeTD("rowdata-l");</script>%value properties/maxExecutionThreadsThrottle%&nbsp;(%value properties/maxExecutionThreads%)</td>
			  <INPUT type="hidden" name="triggerMaximumThreads" value="%value properties/maxExecutionThreadsThrottle%&nbsp;(%value properties/maxExecutionThreads%)">              
		      %endif%
                %else%
                  <INPUT type="hidden" name="triggerMaximumThreads" value="0&nbsp;(%value properties/maxExecutionThreads%)">
                  <script>writeTD("rowdata-l");</script>0&nbsp;(%value properties/maxExecutionThreads%)</td> 
                %endif%
             
              %else%
                <script>writeTD("rowdata-l");</script>Serial</td>
                <INPUT type="hidden" name="triggerProcessingMode" value="Serial">
                %ifvar processingStatus/state matches('active*')%
			<INPUT type="hidden" name="triggerMaximumThreads" value="1">
                  <script>writeTD("rowdata-l");</script>1</td>
                %else%
                  <INPUT type="hidden" name="triggerMaximumThreads" value="0 (1)">
                  <script>writeTD("rowdata-l");</script>0 (1)</td>
                %endif%
                <!-- <script>writeTD("rowdata-l");</script>%value properties/serialAutoSuspend%</td> -->
              %endif%
              
              <INPUT type="hidden" name="triggerCurrentThreads" value="%value processingStatus/activeThreadCount%">
              <script>writeTD("rowdata-l");</script>%value processingStatus/activeThreadCount%</td>
              <INPUT type="hidden" name="triggerVolatileQueue" value="%value processingStatus/volatileQueueCount%">
              <script>writeTD("rowdata-l");</script>%value processingStatus/volatileQueueCount%</td>
              <INPUT type="hidden" name="triggerPersistedQueue" value="%value processingStatus/persistedQueueCount%">
              <script>writeTD("rowdata-l");</script>%value processingStatus/persistedQueueCount%</td>
              
            <script>swapRows();</script>
            </tr>
            %endloop% <tr>
                    
          </tr>
        </tbody>
      </table>


    %invoke wm.server.jms:getConnectionAliasReport%
    %invoke wm.server.jms:getTriggerReport%

	<!-- Global JMS Trigger Controls -->
        
        <table width="100%">
        
          <tr>
            <td class="menusection-Settings" colspan=5>Global JMS Trigger Controls</td>
          </tr>
          
           <tr>
            <td class="oddcol" width="20%">Thread Pool Throttle</td>
            <td class="oddrow-l" width="30%">%value settings/threadPoolMaxThreads% (%value settings/threadPoolThrottle%% of Server Thread Pool)</td>
            <INPUT type="hidden" name="jmsThreadPoolThrottle" value="%value settings/threadPoolMaxThreads% (%value settings/threadPoolThrottle%% of Server Thread Pool)">
		
	      <td class="oddcol" width="20%">Processing Throttle</td>
	      <td class="oddrow-l" width="30%">%value settings/processingThrottle%%</td>
	      <INPUT type="hidden" name="jmsProcessingThrottle" value="%value settings/processingThrottle%%">
          </tr> 
        
        </table>  
	
	<!-- Individual JMS Trigger Controls -->
        
        <table width="100%">  
        
          <tr>
            <td class="menusection-Settings" colspan=7>Individual JMS Trigger Controls</td>
          </tr>
        <!--  <tr>
            <td class="oddcol" colspan=5 width=80%></td>
            <td class="oddcol" colspan=2 width=20%>State</td>
          </tr>
        -->
          <tr>
            <td class="oddcol-l">Trigger Name</td>
            <td class="oddcol-l">Connection Alias Name</td>
            <td class="oddcol-l" nowrap>Destination(s)</td>
            <td class="oddcol-l">Processing Mode</td>
            <td class="oddcol-l">Maximum Threads</td>
            <td class="oddcol-l">Current Threads</td>
            <td class="oddcol">Enabled&nbsp;&nbsp;<br><a href="../WmRoot/settings-jms-edit-state.dsp?triggerName=all&setState=check">edit&nbsp;all</a></td>
          </tr> 
           
          <script>resetRows();</script>
          %loop triggerDataList%
          
            %ifvar trigger/enabled equals('true')% %endif%
              <tr>
                <script>writeTD("row-l");</script>%value node_nsName%</td>
		   <INPUT type="hidden" name="jmsTriggerName" value="%value node_nsName%">
                <script>writeTD("row-l");</script>%value trigger/aliasName%</td>
                <INPUT type="hidden" name="jmsAliasName" value="%value trigger/aliasName%">
                <script>writeTD("row-l");</script>%value trigger/destinationsString%</td>
                <INPUT type="hidden" name="jmsDestination" value="%value trigger/destinationsString%">
                <script>writeTD("row-l");</script>%value trigger/processingModeString%</td>
                <INPUT type="hidden" name="jmsProcessingMode" value="%value trigger/processingModeString%">
                <script>writeTD("row-l");</script>%value trigger/maxThreadsString%</td>
		   <INPUT type="hidden" name="jmsMaxThreads" value="%value trigger/maxThreadsString%">
                
                %ifvar trigger/currentThreads equals('-1')%
                  <script>writeTD("row-l");</script>Not&nbsp;Connected</td>
		     <INPUT type="hidden" name="jmsCurrentThreads" value="Not Connected">	
                %else%
                  <script>writeTD("row-l");</script>%value trigger/currentThreads%</td>
                  <INPUT type="hidden" name="jmsCurrentThreads" value="%value trigger/currentThreads%">
                %endif%
            
                <script>writeTD("rowdata");</script>

                %switch trigger/state%
                  %case '0'%
                    
                    %ifvar trigger/currentThreads equals('-1')%
                      <a href="../WmRoot/settings-jms-edit-state.dsp?triggerName=%value node_nsName%&setState=EnabledButNotConnected">
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
			    <INPUT type="hidden" name="jmsEnabled" value="Yes">
                      </a>
                    %else%
                      <a href="../WmRoot/settings-jms-edit-state.dsp?triggerName=%value node_nsName%&setState=Enabled">
                        <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
                        <INPUT type="hidden" name="jmsEnabled" value="Yes">
                      </a>
                    %endif%
                    
                  %case '1'%
                    <a href="../WmRoot/settings-jms-edit-state.dsp?triggerName=%value node_nsName%&setState=Disabled">No</a>
                    <INPUT type="hidden" name="jmsEnabled" value="No"> 
                  %case '2'%
                    <a href="../WmRoot/settings-jms-edit-state.dsp?triggerName=%value node_nsName%&setState=Suspended">
                      <img style="width: 13px; height: 13px;" alt="suspended" border="0" src="images/yellow_check.gif">Suspended<br>
                      <INPUT type="hidden" name="jmsEnabled" value="Suspended">
                    </a>
                %end%
                </td>
            
            <!--
                <script>writeTD("rowdata");</script>
                %ifvar trigger/running equals('true')%
                  <img style="width: 13px; height: 13px;" alt="active" border="0" src="images/green_check.gif">Yes<br>
                %else%
                  %ifvar trigger/lastError%
                    <font color="red">Error</font><br>
                  %else%
                    No<br>
                  %endif%
                %end%
                </td>
             -->
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
            
          %endloop%
          
        </table>  
	%endinvoke%
	%endinvoke%

	<table width="100%">
	%invoke wm.server.query:getServiceStats%
            <TR>
               <TD>
                  <TABLE class="tableView" width="100%" id="servicecon" border=0>
                     <TR>
                        <TD CLASS="menusection-Settings" COLSPAN="5">Process Engine Services</TD>
                     <TR>


                        <TD CLASS="oddcol-l">Name (instances currently running)</td>
                        <TD CLASS="oddcol">Count</td>
                        <TD CLASS="oddcol" nowrap>Last Ran</td>

                        <TD CLASS="oddcol">Cached</td>
                        <TD CLASS="oddcol">Prefetched</td>



                     </TR> %ifvar SvcStats%
                     <script>resetRows();</script>

                     %loop SvcStats%
			   %ifvar ifc matches('wm.prt*')%
                     <TR id="%ifvar sRunning equals('&nbsp;')%%value $index%%else%%value $index%run%endif%">

                        <script>writeTD('rowdata-l');</script>
                            <nobr><A href="../WmRoot/service-info.dsp?service=%value ifc%:%value svc%"> %value ifc%:%value svc%</A> %ifvar equals('&nbsp;') sRunning%%else%(%value sRunning%)%endif%</nobr></TD>
                        <INPUT type="hidden" name="serviceName" value="%value ifc%:%value svc%">   
				<script>writeTD('rowdata');</script>
                            %value sAccessTotal%</TD>
				<INPUT type="hidden" name="serviceAccessTotal" value="%value sAccessTotal%">   
				

                        <script>writeTD('rowdata');</script>
                           <nobr>%value sAccessLast%</nobr></TD>
				<INPUT type="hidden" name="serviceAccessLast" value="%value sAccessLast%">   
				
                        <script>writeTD('rowdata');</script>
                            %ifvar equals('N') isCached%- <INPUT type="hidden" name="serviceCached" value="-">   
				%else% <IMG SRC="images/green_check.gif" height=13 width=13>
				    <INPUT type="hidden" name="serviceCached" value="true">
				%endif%</TD>
                        <script>writeTD('rowdata');</script>
              %ifvar equals('N') isPrefetched%- <INPUT type="hidden" name="servicePrefetched" value="-">
				%else%<IMG SRC="images/green_check.gif" height=13 width=13>
					<INPUT type="hidden" name="servicePrefetched" value="true">
				%endif%</TD>
                     </TR><script>swapRows();</script>
			%else%
			%ifvar ifc matches('pub.prt*')%
                     <TR id="%ifvar sRunning equals('&nbsp;')%%value $index%%else%%value $index%run%endif%">

                        <script>writeTD('rowdata-l');</script>
                            <nobr><A href="../WmRoot/service-info.dsp?service=%value ifc%:%value svc%"> %value ifc%:%value svc%</A> %ifvar equals('&nbsp;') sRunning%%else%(%value sRunning%)%endif%</nobr></TD>
                        <INPUT type="hidden" name="serviceName" value="%value ifc%:%value svc%">   
				<script>writeTD('rowdata');</script>
                            %value sAccessTotal%</TD>
				<INPUT type="hidden" name="serviceAccessTotal" value="%value sAccessTotal%">   
				

                        <script>writeTD('rowdata');</script>
                           <nobr>%value sAccessLast%</nobr></TD>
				<INPUT type="hidden" name="serviceAccessLast" value="%value sAccessLast%">   
				
                        <script>writeTD('rowdata');</script>
                            %ifvar equals('N') isCached%- <INPUT type="hidden" name="serviceCached" value="-">   
				%else% <IMG SRC="images/green_check.gif" height=13 width=13>
				    <INPUT type="hidden" name="serviceCached" value="true">
				%endif%</TD>
                        <script>writeTD('rowdata');</script>
              %ifvar equals('N') isPrefetched%- <INPUT type="hidden" name="servicePrefetched" value="-">
				%else%<IMG SRC="images/green_check.gif" height=13 width=13>
					<INPUT type="hidden" name="servicePrefetched" value="true">
				%endif%</TD>
                     </TR><script>swapRows();</script>
			%endif%
		     %endif%
		%endloop%
 %else%
                     <TR>
                        <TD CLASS="evenrow-l" colspan=5>No services</TD>

                     </TR>
%endif%
                  </TABLE> </TD>

               </TR>
         </TABLE> %endinvoke%
      </td>
    </tr>
    <td>
	<TABLE width="100%">
	<tbody>
    	<tr class="action">
		<td colspan="1">
		<input type="button" value="Save" onclick="toXML()"> </td>
		%invoke wm.prt.dashboard:lastSavedXML%
		<TD>
			%value xmlHREF%
		</TD>
		%endinvoke%
	</tr>	
	</tbody>
	</TABLE>
    <tr>
      %onerror%
        <script>this_writeMessage('%value errorMessage%');</script>
        <script>setMessageFlag(true);</script>
      %endinvoke%
      %endrename%		
    </td>
  </tbody>
</FORM>
</table>	

</TR>
</BODY>
</HTML>
