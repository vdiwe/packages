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
      var inputSelected = new Array();

      // array of type names for each input
      var inputType = new Array();

      %loop -struct%
	inputSelected["%value COLUMN_NAME%"] = false;
	inputType["%value COLUMN_NAME%"] = "%value DATA_TYPE%";
      %endloop%

      %endinvoke%
      %endscope%
      
      // switch the selected status of the given input
      function toggle (name) {
		if (inputSelected[name]) inputSelected[name] = false;
		else inputSelected[name] = true;
      }

      // assembles the typesByNumber and namesByNumber arrays
      function updateTypeArray () {
		namesByNumber = new Array();
		typesByNumber = new Array();
		for (var i=0; i<colNames.length; i++) {
			if (inputSelected[colNames[i]]) {
				namesByNumber[namesByNumber.length] = colNames[i];
				typesByNumber[typesByNumber.length] = inputType[colNames[i]];
			}
		}
      }

      // assemble an input clause (the end of the input sql string,
      // including column names AND question marks).  an important
      // side-effect is setting the typesByNumber array
      function makeInsertClause () {
		var str = "";
		typesByNumber = new Array();
		var cnt = 0;
		for (var i=0; i<colNames.length; i++)
			if (inputSelected[colNames[i]]) cnt++;
		if (cnt > 0) {
			str = "(";
			var cnt2 = cnt;
			for (var i=0; i<colNames.length; i++) {
				if (inputSelected[colNames[i]]) {
					str += colNames[i];
					cnt--;
					if (cnt > 0) str += ",";
				}
			}
			str += ") VALUES (";
			for (var i=0; i<cnt2; i++) {
				str += "?";
				if (i<cnt2-1) str += ",";
			}
			str += ")";
		}
		return str;
      }

      // assemble an where clause (the end of the select or delete
      // sql strings.  an important side-effect is setting the
      // typesByNumber array
      function makeWhereClause () {
		var str = "";
		var cnt = 0;
		for (var i=0; i<colNames.length; i++)
			if (inputSelected[colNames[i]]) cnt++;
		if (cnt > 0) {
			str = "WHERE ";
			for (var i=0; i<colNames.length; i++) {
				if (inputSelected[colNames[i]]) {
					str += colNames[i]+"=?";
					cnt--;
					if (cnt > 0) str += " AND ";
				}
			}
		}
		return str;
      }

      // figure out what kind of service has been selected
      function getType () {
		var svctype = document.sqlform.svctype;
		for (var i=0; i<svctype.length; i++) {
			if (svctype[i].checked) return svctype[i].value;
		}
		return "";
      }

      // this will create a SQL string and an argument type array, and
      // use them to call the db-input form for input mapping
      function prepareInput () {
		var svctype = getType();
		var sql = "";
		if (svctype == "select") {
			sql = "SELECT * FROM " + tableName + " " + makeWhereClause();
			var nameList = "";
			for (var i=0; i<colNames.length; i++) {
				nameList += colNames[i];
				if (i < colNames.length-1)
					nameList += ", ";
			}
			document.sqlform.elements[1].value += nameList;
		} else if (svctype == "insert") {
			var clause = makeInsertClause();
			if (clause == "") {
				alert ("Select inputs before generating\nan INSERT service.");
				return false;
			}
			sql = "INSERT INTO " + tableName + " " + clause;
		} else if (svctype == "delete") {
			sql = "DELETE FROM " + tableName + " " + makeWhereClause();
		}
		updateTypeArray();
		document.sqlform.typesByNumber.value = typesByNumber;
		document.sqlform.namesByNumber.value = namesByNumber;
		document.sqlform.elements[0].value = sql;
		document.sqlform.submit();
		return true;
      }
    </script>
  </head>
 
  <BODY onLoad="setNavigation('/WmDB/db-gencolumns.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_ColumnsInScrn', 'foo');" >
 
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt; Connection Parameters &gt; Tables
	  &gt; Columns</td>
      </tr>
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-generate.dsp">Return to Service Generation</a></li>
	    <li><a href="javascript:history.back()">Return to Tables</a></li>
	  </ul>
	</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form name="updateform" method="post" action="db-genupdate.dsp">
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <input type="hidden" name="$dbTable" value="%value $dbTable%"></input>
	    <input type="hidden" name="package" value="%value package%"></input>
	    <input type="hidden" name="interface" value="%value interface%"></input>
	    <input type="hidden" name="service" value="%value service%"></input>
	    <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
	    <input type="hidden" name="overwrite" value="%value overwrite%"></input>
	    <input type="hidden" name="closeConn" value="true"></input>
	  </form>
	  <form name="sqlform" method="post" action="db-input.dsp">
	    <input type="hidden" name="$dbSQL" value="xxx"></input>
	    <input type="hidden" name="$dbOutputCols" value=""></input>
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
		<td colspan="4" class="heading">Service Name</td>
	      </tr>
	      <tr>
		<td class="oddrow" width="40%">Package</td>
		<td class="oddrowdata-l" colspan="3">%value package empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Folder</td>
		<td class="evenrowdata-l" colspan="3">%value interface empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Service</td>
		<td class="oddrowdata-l" colspan="3">%value service empty='&lt;Unspecified&gt;'%</td>
	      </tr>
	      <tr>
		<td class="evenrow">Execute ACL</td>
		<td class="evenrowdata-l" colspan="3">%value aclgroup empty='None'%</td>
	      </tr>
	      <tr>
		<td class="oddrow">Overwrite</td>
		<td class="oddrowdata-l" colspan="3">%ifvar overwrite equals('on')%On%else%Off%endif%</td>
	      </tr>
	    </table>
	    <!-- %endif% -->
	    <table class="tableView" width="95%">
	      <thead>
		<tr>
		  <td colspan="4" class="heading">Service Type (select
		    columns below)</td>
		</tr>
		<tr>
		  <td class="oddrow-l" width="20%">
		    <!-- %ifvar op equals('select')% -->
		    <input type="radio" name="svctype" value="select"
			   checked="checked"></input>&nbsp;&nbsp;&nbsp;Select
		    <!-- %else% -->
		    <input type="radio" name="svctype"
			   value="select"></input>&nbsp;&nbsp;&nbsp;Select
		    <!-- %endif% -->
		  </td>
		  <td class="oddrowdata-l" colspan="3">
		    <code>SELECT * FROM %value $dbTable% WHERE col1=? AND col2=? AND ...</code>
		  </td>
		</tr>
		<tr>
		  <td class="evenrow-l">
		    <!-- %ifvar op equals('insert')% -->
		    <input type="radio" name="svctype" value="insert"
			   checked="checked"></input>&nbsp;&nbsp;&nbsp;Insert&nbsp;
		    <!-- %else% -->
		    <input type="radio" name="svctype"
			   value="insert"></input>&nbsp;&nbsp;&nbsp;Insert&nbsp;
		    <!-- %endif% -->
		  </td>
		  <td class="evenrowdata-l" colspan="3">
		    <code>INSERT INTO %value $dbTable% (col1,col2,...) VALUES (?,?,...)</code>
		  </td>
		</tr>
		<tr>
		  <td class="oddrow-l">
		    <!-- %ifvar op equals('delete')% -->
		    <input type="radio" name="svctype" value="delete"
			   checked="checked"></input>&nbsp;&nbsp;&nbsp;Delete
		    <!-- %else% -->
		    <input type="radio" name="svctype"
			   value="delete"></input>&nbsp;&nbsp;&nbsp;Delete
		    <!-- %endif% -->
		  </td>
		  <td class="oddrowdata-l" colspan="3">
		    <code>DELETE FROM %value $dbTable% WHERE col1=? AND col2=? AND ...</code>
		  </td>
		</tr>
		<tr>
		  <td class="evenrow-l">
		    <input type="radio"
			   onclick="document.updateform.submit();"
			   name="svctype" value="update"></input>&nbsp;&nbsp;&nbsp;Update
		  </td>
		  <td class="evenrowdata-l" colspan="3">
		    <code>UPDATE %value $dbTable% SET dest1=?, dest2=?,
		      ... WHERE targ1=? AND targ2=? AND ...</code>
		  </td>
		</tr>
		<tr>
		  <td class="heading" colspan="4">Columns in %value $dbTable%</td>
		</tr>
		<tr>
		  <td class="oddcol">Use this column</td>
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
		    <input type="checkbox" onclick="toggle('%value COLUMN_NAME%');"></input>
		  </td>
		  <td class="oddrowdata">&nbsp;&nbsp;&nbsp;%value COLUMN_NAME%</td>
		  <td class="oddrowdata">%value DATA_TYPE%</td>
		  <td class="oddrowdata">%value IS_NULLABLE empty='?' null='?'%</td>
		</tr>
		<!-- %endloop% -->
	      </tbody>
	      <tbody>
		<tr>
		  <td class="action" colspan="4">
		    <input type="button" value="Generate SQL" onclick="prepareInput();"></input>
		    <input type="hidden" name="typesByNumber" value="xxx"></input>
		    <input type="hidden" name="namesByNumber" value="xxx"></input>
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
