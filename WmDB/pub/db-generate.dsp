<html>
  <head>
    <title>WmDB - Service Generation</title>
    <meta http-equiv="Pragma" content="no-cache">
    <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
    <meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
    <script type="text/javascript">
      function svcNamed () {
		if (document.sqlform.elements[4].value == "") {
			alert ("Specify a folder and service name.");
			return false;
		}
		return true;
      }

      function doclick (opt) {
		if (svcNamed()) {
			if (opt == "gensql") {
				document.sqlform.action = "db-gensql.dsp";
				document.sqlform.submit();
				return true;
			} else if (opt == "gentable") {
				document.sqlform.action = "db-connect.dsp";
				document.sqlform.submit();
				return true;
			}
		}
		return false;
      }

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

    </script>
  </head>
  
<BODY onLoad="setNavigation('/WmDB/db-generate.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_GenNewDBScrn', 'foo');">
  
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Service Generation</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form action="" name="sqlform" method="post">
	    <table class="tableForm">
	      <tr>
		<td class="heading" colspan="2">Generate New Database Service</td>
	      </tr>
	      <!-- %ifvar opt% -->
	      <!-- %switch opt% -->
	      <!-- %case 'generate'% -->
	      <!-- %invoke wm.server.db:generateSqlService% -->
	      <tr>
		<td id="message" class="message" colspan="2">%value $dbLocalizedMessage%</td>
	      </tr>
	      <!-- %endinvoke% -->
	      <!-- %endswitch% -->
	      <!-- %endif% -->
	      <tr>
		<td class="subHeading" colspan="2">Choose Data Source</td>
	      </tr>
	      <tr><td class="oddrow">Source alias</td>
		<!-- %invoke wm.server.db:dataSourceList% -->
		<!-- %ifvar sources% -->
		<td class="oddrow-l">
		  <select name="$dbAlias">
		    <!-- %loop sources% -->
		    <option value="%value alias%">%value alias%</option>
		    <!-- %endloop% -->
		  </select>
		</td>
		<!-- %else% -->
		<td class="message">No sources defined. Use Alias Management Tab to
		  define Aliases.</td>
		<!-- %endif% -->
		<!-- %endinvoke% -->
	      </tr>
	      <tr>
		<td colspan="2" class="subHeading">Name the
		  Service</td>
	      </tr>
	      <tr><td class="oddrow">Package</td>
		<!-- %invoke wm.server.packages:packageList% -->
		<!-- %ifvar packages% -->
		<td class="oddrow-l">
		  <select name="package">
		    <!-- %loop packages% -->
		    <!-- %ifvar enabled equals('true')% -->
		    <option value="%value name%">%value name%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		  </select>
		</td>
		<!-- %else% -->
		<td class="message">Fatal Error. No packages!</td>
		<!-- %endif% -->
		<!-- %endinvoke% -->
	      </tr>
	      <tr>
		<td class="evenrow">Folder</td>
		<td class="evenrow-l">
		  <input name="interface" size="43"  value="" onChange="checkLegalName(interface, 'Folder')" />
		</td>
	      </tr>
	      <tr><td class="oddrow">Service</td>
		<td class="oddrow-l">
		  <input name="service" size="43"  value="" onChange="checkLegalName(service, 'Service')" />
		</td>
	      </tr>
	      <tr><td class="evenrow">Execute ACL</td>
		<td class="evenrow-l">
		  <select name="aclgroup">
		    <option value="none">(inherit)</option>
		    <!-- %invoke wm.server.access:aclList% -->
		    <!-- %ifvar aclgroups% -->
		    <!-- %loop aclgroups% -->
		    <!-- %ifvar /aclgroup vequals(name)% -->
		    <option selected="selected" value="%value name%">%value name%</option>
		    <!-- %else% -->
		    <option value="%value name%">%value name%</option>
		    <!-- %endif% -->
		    <!-- %endloop% -->
		    <!-- %endif% -->
		    <!-- %endinvoke% -->
		  </select>
		</td>
	      </tr>
	      <tr>
		<td class="oddcol">Overwrite Existing</td>
		<td class="oddrow-l">
		  <!-- %ifvar overwrite% -->
		  <input checked="checked" type="checkbox"
			 name="overwrite"></input>&nbsp;&nbsp;&nbsp;Generated
		    objects overwrite existing objects
		  <!-- %else% -->
		  <input type="checkbox"
			 name="overwrite"></input>&nbsp;&nbsp;&nbsp;Generated
		    objects overwrite existing objects
		  <!-- %endif% -->
		</td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input class="button2" type="button" value="Generate from SQL"
			 onclick="return doclick('gensql');"></input>
		  <input class="button2" type="button" value="Generate from table"
			 onclick="return doclick('gentable');"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
