<HTML>
<HEAD>		
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">		
<META HTTP-EQUIV="Expires" CONTENT="-1">		
<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>		
<LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
<SCRIPT SRC="webMethods.js.txt"></SCRIPT>
</HEAD>	

<BODY>
<TABLE width="100%">
    <TR>
      <TD class="menusection-Settings">
          Process Engine &gt;
          Diagnostic &gt;
      </TD>
    </TR>	
<FORM NAME="diag" ACTION="diagCollector.dsp?InstanceId=%value InstanceId%&InstanceIteration=%value InstanceIteration%">
</TABLE>
<TABLE>

        <SCRIPT>resetRows();swapRows();</SCRIPT>
          <TR>
            <SCRIPT>writeTDnowrap("row");</SCRIPT>
              Instance ID</TD>
            <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
                <INPUT NAME="InstanceId">
            </TD>    
          </TR>
          <TR>
	     <SCRIPT>writeTDnowrap("row");</SCRIPT>
	       Instance Iteration</TD>
	     <SCRIPT>writeTDnowrap("row-l");</SCRIPT>
	         <INPUT NAME="InstanceIteration" >
	   </TD>    
          </TR>
	  <TR>   	
	     <TD class="action" colspan=2>
             <INPUT type="button" value="Submit" onclick="document.diag.submit();">
         </TD>
        </TR>          
</TABLE>         
</FORM>
</BODY>
</HTML>