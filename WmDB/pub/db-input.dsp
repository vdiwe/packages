<html>
  <head>
    <title>WmDB - Service Generation</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript">

      function checkLegalName(field, fieldName)
      {
        var name = field.value;
        var illegalChars = "- #&@^!%*:$/\\`;,~+=)(|}{][><\"";

        for (var i=0; i<illegalChars.length; i++)
        {
          if (name.indexOf(illegalChars.charAt(i)) >= 0)
          {
            alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
            field.value = "";
            return;
          }
        }
      }

      %ifvar namesByNumber%

      // this stanza will only be here if we have predefined guesses
      // for input names and types (through table introspection).

      // input names
      var nameStr = "%value namesByNumber%";
      var inputNames = nameStr.split (',');

      // input guesses
      var typeStr = "%value typesByNumber%";
      var inputTypes = typeStr.split (',');

      // set the value of a field (param name)
      function setFieldValue (fld, val) {
		fld.value = val;
      }

      // set the value of an option selector (param type)
      // throws up an alert if it's an unknown SQL type
      function setSelectValue (sel, val) {
		sel.selectedIndex = -1;
		val = val.toUpperCase();
		var msg = "";
		for (var i=0; i<sel.options.length; i++) {
			msg += sel.options[i].value + "\n";
			var match = (sel.options[i].value == val);
			if (!match) {
				match = (sel.options[i].value == "INTEGER" && val == "INT");
			}
			if (match) {
				sel.selectedIndex = i;
				return;
			}
		}
		alert ("Unrecognized SQL type: "+val);
	}

	// set input names/types if we have recevied guesses
	function setInputTypes () {
		if (inputTypes) {
			var len = inputTypes.length;
			for (var i=0; i<inputTypes.length; i++) {
				if (inputTypes[i]) {
					var minus = 2 * (len - i) - 1;
					var idx = document.sqlform.elements.length - minus;
					setFieldValue (document.sqlform.elements[idx-1], inputNames[i]);
					setSelectValue (document.sqlform.elements[idx], inputTypes[i]);
				}
			}
		}
	  }

	  %endif%

	  // verify that we have parameter names and types assigned
	  // (if we need them)
	  function ok () {

		var pn = document.sqlform.paramName;
		var paramCount = 0;
		var ok = true;
		if (pn) {
			if (pn[1]) {
				var ok = true;
				for (var i=0; i<pn.length; i++) {
					paramCount++;
					if (!pn[i].value) ok = false;
				}
			} else {
				paramCount = 1;
				ok = pn.value;
			}
		}
		if (!ok) {
			if (paramCount == 1) {
				alert ("Specify name for input parameter.");
			} else {
				alert ("Specify names for input parameters.");
			}
		} else {
			document.sqlform.submit();
		}
	    }
    </script>
  </head>

  <BODY onLoad="setNavigation('/WmDB/db-input.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_InputBindGenScrn', 'foo');">

    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation &gt; Input
	  Binding Generation</td>
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
	  <!-- %invoke wm.server.db:prepareSqlString% -->
	  <form name="sqlform" method="post" action="db-generate.dsp">
	    <input type="hidden" name="opt" value="generate"></input>
	    <input type="hidden" name="$dbAlias" value="%value $dbAlias%"></input>
	    <input type="hidden" name="$dbSQL" value="%value $dbSQL%"></input>
	    <table class="tableForm" width="95%">
	      <!-- %ifvar interface -notempty% -->
	      <tr><td colspan="3" class="heading">Service Name</td></tr>
	      <!-- %else% -->
	      <tr><td colspan="3" class="heading">Name The Service</td></tr>
	      <!-- %endif% -->
	      <tr>
		<td class="oddrow">Package</td>
		<td class="oddrow-l" colspan="2">
		  <!-- %ifvar package -notempty% -->
		  %value package%
		  <input type="hidden" name="package" value="%value package%"></input>
		  <!-- %else% -->
		  <select name="package">
		    <!-- %invoke wm.server.packages:packageList% -->
		    <!-- %loop packages% -->
		    <option value="%value name%">%value name%</option>
		    <!-- %endloop% -->
		    <!-- %endinvoke% -->
		  </select>
		  <!-- %endif% -->
		</td>
	      </tr>
	      <tr>
		<td class="evenrow">Folder</td>
		<td class="evenrow-l" colspan="2">
		  <!-- %ifvar interface -notempty% -->
		  %value interface%
		  <input type="hidden" name="interface" value="%value interface%"></input>
		  <!-- %else% -->
		  <input name="interface" value="" onChange="checkLegalName(interface, 'Folder')" />
		  <!-- %endif% -->
		</td>
	      </tr>
	      <tr>
		<td class="oddrow">Service</td>
		<td class="oddrow-l" colspan="2">
		  <!-- %ifvar service -notempty% -->
		  %value service%
		  <input type="hidden" name="service" value="%value service%"></input>
		  <!-- %else% -->
		  <input name="service" value="" onChange="checkLegalName(service, 'Service')" />
		  <!-- %endif% -->
		</td>
	      </tr>
	      <tr><td class="evenrow">Execute ACL</td>
		<td class="evenrow-l" colspan="2">
		  %ifvar aclgroup equals('none')%
		  none
		  %else%
		  %value aclgroup%
		  %endif%
		  <input type="hidden" name="aclgroup" value="%value aclgroup%"></input>
		</td>
	      </tr>
	      <tr><td class="oddrow">Overwrite</td>
		<td class="oddrow-l" colspan="2">

          %ifvar overwrite equals('on')%
          <input type="hidden" name="overwrite" value="on"></input>On
          %else%
          <input type="hidden" name="overwrite" value="off"></input>Off
          %endif%
		</td>
	      </tr>
	      <tr><td class="heading" colspan="3">SQL Statement</td></tr>
	      <tr>
		<td class="oddrow">SQL</td>
		<td class="oddrow-l" colspan="2">%value sqlhtml%</td>
	      </tr>
	      <!-- %ifvar /processReporterTokens% -->
	      <tr>
		<td class="evenrow">Template Tags</td>
		<td class="evenrow-l" colspan="2">Processing webMethods template
		  tags in this statement.<input type="hidden" name="processReporterTokens"
						value="%value /processReporterTokens%"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <tr>
		<td class="action" colspan="3">
		  <input type="button" value="Generate" onclick="return ok();"></input>
		  <input type="button" value="Reset" onclick="document.sqlform.reset();"></input>
		</td>
	      </tr>
	    </table><br />
	    <!-- %ifvar qcount% -->
	    <table class="tableForm" width="95%">
	      <tr>
		<td class="heading" colspan="3">Bind Parameters
		  <input type="hidden" name="generateInputMap" value="yes"></input>
		  <input type="hidden" name="useParamTypes" value="yes"></input>
		  <input type="hidden" name="useParamNames" value="yes"></input>
		  <input type="hidden" name="$dbOutputCols" value="%value $dbOutputCols%"></input>
		</td>
	      </tr>
	      <!-- %loop qcount% -->
	      <tr>
		<td class="oddrow" rowspan="2">Parameter %value%</td>
		<td class="oddrow-l">name</td>
		<td class="oddrow-l"><input size="43" name="paramName"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow-l">type</td>
		<td class="oddrow-l">
		  <select name="paramType">
		    <!-- %loop sqltypes% -->
		    <option value="%value%">%value%</option>
		    <!-- %endloop% -->
		  </select>
		</td>
	      </tr>
	      <!-- %endloop% -->
	    </table>
	    <!-- %endif% -->
	  </form>
	  <!-- %endinvoke% -->
	</td>
      </tr>
    </table>
    <!-- %ifvar typesByNumber% -->
    <script type="text/javascript">setInputTypes();</script>
    <!-- %endif% -->
  </body>
</html>
