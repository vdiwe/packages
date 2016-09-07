<html>
  <head>
    <title>WmDB - Service Generation</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript">
	function getTableInfo (table)
	{
		document.sqlform.elements[3].value = table;
		document.sqlform.submit();
		return false;
	}
    </script>
  </head>

  <BODY onLoad="setNavigation('/WmDB/db-gentable.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_TablesInScrn', 'foo');">

    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt;  Connection Parameters &gt; Tables</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-generate.dsp">Return to Service Generation</a></li>
	    <li><a href="javascript:history.back()">Return to Connection Parameters</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="sqlform" method="post" action="db-gencolumns.dsp">
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <input type="hidden" name="$dbCatalog" value="%value $dbCatalog%"></input>
	    <input type="hidden" name="$dbSchemaPattern" value="%value $dbSchemaPattern%"></input>
	    <input type="hidden" name="$dbTable" value="xxx"></input>
	    <input type="hidden" name="package" value="%value package%"></input>
	    <input type="hidden" name="interface" value="%value interface%"></input>
	    <input type="hidden" name="service" value="%value service%"></input>
	    <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
	    <input type="hidden" name="overwrite" value="%value overwrite%"></input>
	    <input type="hidden" name="closeConn" value="true"></input>
	    <!-- %ifvar interface equals('')% -->
	    <!-- %else% -->
	    <table class="tableView" width="95%">
	      <tr>
		<td colspan="5" class="heading">Service Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="40%">Package</td>
		<td class="oddrowdata-l" colspan="4">%value package empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Folder</td>
		<td class="evenrowdata-l" colspan="4">%value interface empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Service</td>
		<td class="oddrowdata-l" colspan="4">%value service empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Execute ACL</td>
		<td class="evenrowdata-l" colspan="4">%value aclgroup empty='(inherit)'%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Overwrite</td>
		<td class="oddrowdata-l" colspan="4">%ifvar overwrite equals('on')%On%else%Off%endif%</td>
	      </tr>
	    </table>
	    <!-- %endif% -->
	    <table class="tableView" width="95%">
	      <thead>
		<tr>
		  <td class="heading" colspan="5">Tables in %value $dbAlias%</td>
		</tr>
		<tr>
		  <td class="oddcol">Name</td>
		  <td class="oddcol">Type</td>
		  <td class="oddcol">Catalog</td>
		  <td class="oddcol">Schema</td>
		  <td class="oddcol">Remarks</td>
		</tr>
	      </thead>
	      %scope param(closeConn='true')%
	      <!-- %invoke pub.db:getTables% -->
	      <tbody id="tbodyNode">
		<!-- %loop -struct% -->
		<tr>
		  <td class="oddrowdata-l">
		    <a href=""
		       onclick="return getTableInfo('%value TABLE_NAME%');">%value TABLE_NAME%</a></td>
		  <td class="oddrowdata">%value TABLE_TYPE empty='&nbsp;'%</td>
		  <td class="oddrowdata">%value TABLE_CAT empty='&lt;None&gt;'%</td>
		  <td class="oddrowdata">%value TABLE_SCHEM empty='&lt;None&gt;'%</td>
		  <td class="oddrowdata">%value REMARKS empty='&lt;None&gt;'%</td>
		</tr>
		<!-- %endloop% -->
	      </tbody>
	      <!-- %ifvar $dbLocalizedMessage% -->
	      <tbody id="tbodyNode">
		<tr>
		  <td class="message" colspan="5">%value $dbLocalizedMessage%</td>
		</tr>
	      </tbody>
	      <!-- %endif% -->
	      <!-- %onerror% -->
	      <tbody id="tbodyNode">
		<tr>
		  <td class="message" colspan="5">Could not connect: %value errorMessage%</td>
		</tr>
	      </tbody>
	      <!-- %endinvoke% -->
	      %endscope%
	    </table>
	    <script>swapColor('tbodyNode', false);</script>
	  </form>
	  <form name="execform" action="/invoke/pub.db/execSQL" method="post">
	    <table class="tableForm" width="95%">
	      <tr><td colspan="2" class="heading">Test SQL Queries</td></tr>
	      <tr>
		<td class="evenrow-l">
		  <input name="$dbSQL" size="50"></input>
		  <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
		</td>
		<td class="action">
		  <input type="button" value="Execute query"
			 onclick="document.execform.submit();"></input>
		  <input type="hidden" name="closeConn" value="true"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
