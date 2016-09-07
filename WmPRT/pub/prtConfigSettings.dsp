<HTML>
<HEAD>
<META http-equiv="Pragma" content="no-cache">
<META http-equiv='Content-Type' content='text/html; charset=UTF-8'>
<META HTTP-EQUIV="Expires" CONTENT="-1">

<TITLE>Process Engine Settings</TITLE>
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
<SCRIPT>
    function onSubmit() {
        document.config.edit.value = true;
        document.config.submit();
        return true;
        
    }
    function setDefault() {
        document.config.edit.value = false;
        document.config.submit();
    }

    function getSize(string) {
	return string.length;
    }
</SCRIPT>
</HEAD>
<BODY onLoad="setNavigation('prtSettings.dsp',null,null);">

  <TABLE width="100%">
    <TR>
      <TD class="menusection-Settings">
          Process Engine &gt;
          Settings &gt;
	    Edit
      </TD>
    </TR>
	
<FORM NAME="config">
<INPUT NAME="edit" TYPE="hidden">

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
     <tr>
          <td valign="top">
            <ul>
             <li><a href="prtSettings.dsp">Return to Settings</a></li>
            </ul>
          </td>
     </tr>
 </TABLE>

<TABLE>
          <TR>
            <TD class="heading" colspan="2">Retry Limits and Intervals</TD>
         </TR>

        <SCRIPT>resetRows();swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Database Operation Retry Limit</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="dbRetries"  VALUE="%value dbRetries%">
            </TD>    
          </TR>

         <SCRIPT>swapRows();</SCRIPT>
            <TR>
              <SCRIPT>writeTDnowrap("row");</SCRIPT>
                  Database Operation Retry Interval (sec)</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="sleepTime"  VALUE="%value sleepTime%">
            </TD>    
          </TR>
	   <TR>
	   	<TD colspan=2>&nbsp; </TD>
	   </TR>	
         <TR>
            <TD class="heading" colspan=2>Database Cleanup and Expiration</TD>
         </TR>

         <SCRIPT>resetRows();swapRows();</SCRIPT>
         <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Cleanup Service Execution Interval (sec)</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="cleanInterval"  VALUE="%value cleanInterval%">
            </TD>    
         </TR>

          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Completed Process Expiration (sec)</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="processExpire"  VALUE="%value processExpire%">
            </TD>    
          </TR>

          <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Failed Process Expiration (sec)</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="failedProcessExpire"  VALUE="%value failedProcessExpire%">
            </TD>    
          </TR>
	   <TR>
	   	<TD colspan=2>&nbsp; </TD>
	   </TR>

         <TR>
            <TD class="heading" colspan=2>webMethods Optimize</TD>
         </TR>

          <SCRIPT>resetRows();swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              JMS Server URL</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT type="text" size="40" NAME="brokerURL" VALUE="%value brokerURL%">
            </TD>    
          </TR>
	   <TR>
	   	<TD colspan=2>&nbsp; </TD>
	   </TR>

	     <TR>
            <TD class="heading" colspan=2>Advanced</TD>
         </TR>
	   <SCRIPT>resetRows();swapRows();</SCRIPT>
	   <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Duplicate Event Detection</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE="CHECKBOX" NAME="checkDuplicates"  VALUE = true
        %ifvar checkDuplicates equals('true')%CHECKED%endif%   >
            </TD>    
          </TR>
	    <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
             Cache Cleanup Interval (sec)</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="cacheCleanupInterval" VALUE="%value cacheCleanupInterval%">
            </TD>    
          </TR>
	    <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
             Maximum Cache Buffer Size</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="cacheBufferSize" VALUE="%value cacheBufferSize%">
            </TD>    
          </TR>
	    <SCRIPT>swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
             External Cluster</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT TYPE="CHECKBOX" NAME="externalCluster" VALUE = true
        %ifvar externalCluster equals('true')%CHECKED%endif%>
            </TD>    
          </TR>
	   <TR>   	
		<TD class="action" colspan=2>
             <INPUT type="button" value="Submit" onclick="onSubmit();">
           <INPUT type="button" value="Default" onclick="setDefault();">
        </TD>
        </TR>
    </TABLE>  
  %endinvoke wm.prt.admin:configSettings%  
</FORM>
</BODY>
</HTML>
