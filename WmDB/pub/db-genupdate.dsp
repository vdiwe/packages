<html>
  <head>
    <title>WmDB - Service Generation</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript">
      // table name (with spaces escaped if it's an MS database)
      var tableName = "%value $dbTable%";
      if (tableName.indexOf(" ") >= 0) {
		tableName = "["+tableName+"]";
      }
      
      %scope param(closeConn='true')%
      %invoke pub.db:getTableInfo%

      // array of column names for all columns
      var colNames = new Array (
		%loop -struct%
			"%value COLUMN_NAME%" %loopsep ', '%
		%endloop%
      );

      // array of column names and types for selected inputs, in order
      // and indexed by number (used in constructing the follow-up page)
      var namesByNumber = new Array();
      var typesByNumber = new Array();

      // array of booleans for each input (is this input selected?)
      var destSelected = new Array();
      var targSelected = new Array();

      // array of type names for each input
      var inputType = new Array();

      %loop -struct%
	targSelected["%value COLUMN_NAME%"] = false;
	destSelected["%value COLUMN_NAME%"] = false;
	inputType["%value COLUMN_NAME%"] = "%value DATA_TYPE%";
      %endloop%

      %endinvoke%
      %endscope%

      // switch the selected (target) status of the given input
      function toggleTarget (name) {
		if (targSelected[name]) targSelected[name] = false;
		else targSelected[name] = true;
      }

      // switch the selected (dest) status of the given input
      function toggleDest (name) {
		if (destSelected[name]) destSelected[name] = false;
		else destSelected[name] = true;
      }

      // assembles the typesByNumber array
      function updateTypeArray () {
		namesByNumber = new Array();
		typesByNumber = new Array();
		for (var i=0; i<colNames.length; i++) {
			if (destSelected[colNames[i]]) {
				namesByNumber[namesByNumber.length] = "new"+colNames[i];
				typesByNumber[typesByNumber.length] = inputType[colNames[i]];
			}
		}
		for (var i=0; i<colNames.length; i++) {
			if (targSelected[colNames[i]]) {
				namesByNumber[namesByNumber.length] = colNames[i];
				typesByNumber[typesByNumber.length] = inputType[colNames[i]];
			}
		}
      }

      // assemble a SET clause (comma-separated list of updated values)
      function makeSetClause () {

		var str = "";

		// count how many columns were selected
		var cnt = 0;
		for (var i=0; i<colNames.length; i++)
			if (destSelected[colNames[i]]) cnt++;

		// if any were selected, go through the list and add them to
		// the SQL string which we're going to return
		if (cnt > 0) {
			str = "SET ";
			var cnt2 = cnt;
			for (var i=0; i<colNames.length; i++) {
				if (destSelected[colNames[i]]) {
					str += colNames[i] + "=?";
					cnt--;
					if (cnt > 0) str += ",";
				}
			}
		}
		return str;
      }

      // assemble an where clause (the end of the update clause)
      function makeWhereClause () {
		typesByNumber = new Array();
		var str = "";
		var cnt = 0;
		for (var i=0; i<colNames.length; i++)
			if (targSelected[colNames[i]]) cnt++;
		if (cnt > 0) {
			str = "WHERE ";
			for (var i=0; i<colNames.length; i++) {
				if (targSelected[colNames[i]]) {
					str += colNames[i]+"=?";
					cnt--;
					if (cnt > 0) str += " AND ";
				}
			}
		}
		return str;
      }

      // this will create a SQL string and an argument type array, and
      // use them to call the db-input form for input mapping
      function prepareInput () {

		var sql = "UPDATE " + tableName + " ";
		var set = makeSetClause();
		var where = makeWhereClause();

		if (set == "") {
			alert ("Select destination columns before\ngenerating an UPDATE service.");
			return false;
		}

		sql += set + " " + where;

		updateTypeArray();

		document.updateform.typesByNumber.value = typesByNumber;
		document.updateform.namesByNumber.value = namesByNumber;
		document.updateform.elements[0].value = sql;
		document.updateform.submit();
		return true;
      } //
    </script>
  </head>
  <body>
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt; Connection Parameters &gt; Tables
	  &gt; Columns &gt; Update</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-generate.dsp">Return to Service Generation</a></li>
	    <li><a href="javascript:history.back()">Return to Columns</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="sqlform" method="post" action="db-gencolumns.dsp">
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <input type="hidden" name="$dbTable" value="%value $dbTable%"></input>
	    <input type="hidden" name="package" value="%value package%"></input>
	    <input type="hidden" name="interface" value="%value interface%"></input>
	    <input type="hidden" name="service" value="%value service%"></input>
	    <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
	    <input type="hidden" name="overwrite" value="%value overwrite%"></input>
	    <input type="hidden" name="op" value="xxx"></input>
	    <input type="hidden" name="closeConn" value="true"></input>
	  </form>
	  <form name="updateform" method="post" action="db-input.dsp">
	    <input type="hidden" name="$dbSQL" value="xxx"></input>
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <input type="hidden" name="package" value="%value package%"></input>
	    <input type="hidden" name="interface" value="%value interface%"></input>
	    <input type="hidden" name="service" value="%value service%"></input>
	    <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
	    <input type="hidden" name="overwrite" value="%value overwrite%"></input>
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
		<td class="evenrowdata-l" colspan="4">%value aclgroup empty='None'%</td>
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
		  <td colspan="5" class="heading">Service Type (select
		    columns below)</td>
		</tr>
		<tr>
		  <td class="oddrow-l">
		    <input type="radio"
			   onclick="document.sqlform.op.value='select'; document.sqlform.submit();"
			   name="svctype" value="select"></input>&nbsp;&nbsp;&nbsp;Select
		  </td>
		  <td class="oddrowdata-l" colspan="4">
		    <code>SELECT * FROM %value $dbTable% WHERE col1=? AND col2=? AND ...</code>
		  </td>
		</tr>
		<tr>
		  <td class="evenrow-l">
		    <input type="radio"
			   onclick="document.sqlform.op.value='insert'; document.sqlform.submit();"
			   name="svctype" value="insert"></input>&nbsp;&nbsp;&nbsp;Insert
		  </td>
		  <td class="evenrowdata-l" colspan="4">
		    <code>INSERT INTO %value $dbTable% (col1,col2,...) VALUES (?,?,...)</code>
		  </td>
		</tr>
		<tr><td class="oddrow-l">
		    <input type="radio"
			   onclick="document.sqlform.op.value='delete'; document.sqlform.submit();"
			   name="svctype" value="delete"></input>&nbsp;&nbsp;&nbsp;Delete
		  </td>
		  <td class="oddrowdata-l" colspan="4">
		    <code>DELETE FROM %value $dbTable% WHERE col1=? AND col2=? AND ...</code>
		  </td>
		</tr>
		<tr><td class="evenrow-l">
		    <input type="radio" name="svctype" value="update" checked="checked"></input>&nbsp;&nbsp;&nbsp;Update
		  </td>
		  <td class="evenrowdata-l" colspan="4">
		    <code>UPDATE %value $dbTable% SET dest1=?, dest2=?,
		      ... WHERE targ1=? AND targ2=? AND ...</code>
		  </td>
		</tr>
		<tr>
		  <td class="heading" colspan="5">Columns in %value $dbTable%</td>
		</tr>
		<tr>
		  <td class="oddcol">Set</td>
		  <td class="oddcol">Criteria</td>
		  <td class="oddcol">Name</td>
		  <td class="oddcol">Data type</td>
		  <td class="oddcol">Nullable?</td>
		</tr>
	      </thead>
	      %scope param(closeConn='true')%
	      <!-- %invoke pub.db:getTableInfo% -->
	      <tbody id="tbodyNode">
		<!-- %loop -struct% -->
		<tr>
		  <td class="oddrow-l">
		    <input type="checkbox" onclick="toggleDest('%value COLUMN_NAME%');"></input>
		  </td>
		  <td class="oddrowdata">
		    <input type="checkbox" onclick="toggleTarget('%value COLUMN_NAME%');"></input>
		  </td>
		  <td class="oddrowdata">%value COLUMN_NAME%</td>
		  <td class="oddrowdata">%value DATA_TYPE%</td>
		  <td class="oddrowdata">%value IS_NULLABLE empty='?' null='?'%</td>
		</tr>
		<!-- %endloop% -->
	      </tbody>
	      <tbody>
		<tr>
		  <td class="action" colspan="5">
		    <input type="hidden" name="typesByNumber" value="xxx"></input>
		    <input type="hidden" name="namesByNumber" value="xxx"></input>
		    <input type="button" value="Generate SQL" onclick="prepareInput();"></input>
		  </td>
		</tr>
	      </tbody>
	      <!-- %endinvoke% -->
	      %endscope%
	      <!-- %ifvar $dbLocalizedMessage% -->
	      <tbody>
		<tr>
		  <td class="message" colspan="4">%value $dbLocalizedMessage%</td>
		</tr>
	      </tbody>
	      <!-- %endif% -->
	    </table>
	    <script>swapColor('tbodyNode', true);</script>
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
