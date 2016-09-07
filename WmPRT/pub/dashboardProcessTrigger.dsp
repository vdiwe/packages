%ifvar UsesJMS equals('false')%
%invoke wm.server.triggers:getTriggerReport%
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
   %else%
   %scope rparam(newDoc={triggerName=triggerName})%
   %invoke wm.server.jms:getTriggerReport%
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
            
          %endloop%
          
	     <tr>
      		%onerror%
        	<script>this_writeMessage('%value errorMessage%');</script>
        	<script>setMessageFlag(true);</script>
		%endinvoke%
	     </tr>
   %endscope%
   %endif%	 


	