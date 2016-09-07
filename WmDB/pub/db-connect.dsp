<html>
  <head>
    <title>WmDB - Service Generation</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>
  
  <body onLoad="setNavigation('/WmDB/db-connect.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_SpecifyConnectParamsScrn', 'bla');">
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt; Connection Parameters</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-generate.dsp">Return to
		Service Generation</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="conform" action="db-gentable.dsp" method="post">
	    <table class="tableForm">
	      <tr>
		<td class="heading" colspan="2">Specify Connection
		  Parameters</td>
	      </tr>
	      <!-- %ifvar $dbAlias% -->
	      <tr>
		<td class="subHeading" colspan="2">Data Source
		  <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
		</td>
	      </tr>
	      <tr>
		<td class="oddrow">Source Alias</td>
		<td class="oddrow-l">%value $dbAlias%</td>
	      </tr>
	      <!-- %else% -->
	      <tr>
		<td class="subHeading" colspan="2">Choose Data
		  Source</td>
	      </tr>
	      <tr>
		<td class="oddrow">Source Alias</td>
		<td class="oddrow-l">
		  <select name="$dbAlias">
		    <!-- %invoke wm.server.db:dataSourceList% -->
		    <!-- %loop sources% -->
		    <option value="%value alias%">%value alias%</option>
		    <!-- %endloop% -->
		    <!-- %endinvoke% -->
		  </select>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <tr><td colspan="2" class="subHeading">Restrictions (optional)</td></tr>
	      <tr>
		<td class="oddrow">Catalog</td>
		<td class="oddrow-l">
		  <input name="$dbCatalog" size="43"></input>
		</td>
	      </tr>
	      <tr>
		<td class="evenrow">Schema Pattern</td>
		<td class="evenrow-l">
		  <input name="$dbSchemaPattern" size="43"></input>
		</td>
	      </tr>
	      <tr>
		<td class="oddrow">Table Name Pattern</td>
		<td class="oddrow-l">
		  <input name="$dbTableNamePattern" size="43" value="%"></input>
		</td>
	      </tr>
	      <tr>
		<td class="evenrow">Table Types</td>
		<td class="evenrow-l">
		  <select name="$dbTableType" size="7" multiple="multiple">
		    <option selected="selected" value="TABLE">Table</option>
		    <option selected="selected" value="VIEW">View</option>
		    <option value="SYSTEM TABLE">System Table</option>
		    <option value="GLOBAL TEMPORARY">Global Temporary</option>
		    <option value="LOCAL TEMPORARY">Local Temporary</option>
		    <option value="ALIAS">Alias</option>
		    <option value="SYNONYM">Synonym</option>
		  </select>
		</td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input type="hidden" name="package" value="%value package%"></input>
		  <input type="hidden" name="service" value="%value service%"></input>
		  <input type="hidden" name="interface" value="%value interface%"></input>
		  <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
		  <input type="hidden" name="overwrite" value="%value overwrite%"></input>
		  <input type="hidden" name="closeConn" value="true"></input>
		  <input type="submit" value="Connect"></input>
		  <input type="reset" value="Reset"></input>
		  <input type="button" value="Cancel" onclick="javascript:history.back();"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
