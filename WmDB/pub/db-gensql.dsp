<html>
  <head>
    <title>WmDB - Service Generation</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  <script>
	function loadLocation() {
	 	if(is_csrf_guard_enabled && needToInsertToken) {
			document.location='db-generate.dsp?'+_csrfTokenNm_+'='+_csrfTokenVal_;
		} else {
			document.location='db-generate.dsp';
		}
	}
  </script>
  <BODY onLoad="setNavigation('/WmDB/db-gensql.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_GenFromSQLScrn', 'foo');">

    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt; Generate from SQL</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-generate.dsp">Return to Service Generation</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="sqlform" method="post" action="db-input.dsp">
	    <input type="hidden" name="package" value="%value package%"></input>
	    <input type="hidden" name="interface" value="%value interface%"></input>
	    <input type="hidden" name="service" value="%value service%"></input>
	    <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
	    <input type="hidden" name="overwrite" value="%value overwrite%"></input>
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <!-- %ifvar interface equals('')% -->
	    <!-- %else% -->
	    <table class="tableView" width="95%">
	      <tr><td colspan="2" class="heading">Service Name</td></tr>
	      <tr>
		<td class="oddrow" width="40%">Package</td>
		<td class="oddrowdata-l">%value package%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Folder</td>
		<td class="evenrowdata-l">%value interface%</td>
		</tr>
	      <tr>
		<td class="oddrow">Service</td>
		<td class="oddrowdata-l">%value service%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Execute ACL</td>
		<td class="evenrowdata-l">%value aclgroup%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Overwrite</td>
		<td class="oddrowdata-l">%ifvar overwrite equals('on')%On%else%Off%endif%</td>
	      </tr>
	    </table>
	    <!-- %endif% -->
	    <table class="tableForm" width="95%">
	      <tr>
		<td class="heading" colspan="2">Enter SQL Statement</td></tr>
	      <tr>
		<td class="evencol" colspan="2">
		  <textarea name="$dbSQL" rows="5" cols="49">Enter your SQL string (including '?' parameters) here.
		  </textarea>
		</td>
	      </tr>
	      <tr>
		<td class="oddcol" colspan="2">
		<input type="checkbox" name="processReporterTokens" value="no"></input>
		    Process webMethods template tags (<b>%value</b>, <b>%ifvar</b>, etc.)
		    in this SQL statement.
		</td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input type="button" value="Evaluate"
			 onclick="document.sqlform.submit();"></input>
		  <input type="button" value="Clear"
			 onclick="document.sqlform.elements[document.sqlform.elements.length-5].value='';"></input>
		  <input type="button" value="Cancel" onclick="loadLocation();"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
