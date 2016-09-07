<html>
  <head>
    <title>WmDB - Alias Management</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
    <script type="text/javascript" src="/WmRoot/webMethods.js.txt"></script>
  </head>

  %ifvar falias equals('nnnn')% <!-- signals that we pushed the ADD button -->

    <BODY onLoad="setNavigation('/WmDB/db-alias.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_NewDBAliasScrn');">

  %else%

    %ifvar alias -notempty%     <!-- the name of the alias we edit -->

       <BODY onLoad="setNavigation('/WmDB/db-alias.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_EditAliasInfoScrn');">

    %endif%

    <BODY onLoad="setNavigation('/WmDB/db-alias.dsp', '/WmDB/doc/OnlineHelp/wwhelp.htm?context=wmdb_help&topic=DB_AliasMgmntScrn');">

  %endif%

    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Alias Management
	  <!-- %ifvar falias% -->
	  <!-- %switch falias% -->
	  <!-- %case 'nnnn'% -->
	  &gt; Add
	  <!-- %case% -->
	  &gt; Edit
	  <!-- %endswitch% -->
	  <!-- %endif% -->
	</td>
      </tr>
      <!-- %switch action% -->
      <!-- %case 'add'% -->
      <!-- %invoke wm.server.db:dataSourceAdd%
      %endinvoke% -->
      <!-- %case 'change'% -->
      <!-- %invoke wm.server.db:dataSourceChange%
      %endinvoke% -->
      <!-- %case 'delete'% -->
      <!-- %invoke wm.server.db:dataSourceDelete%
      %endinvoke% -->
      <!-- %endswitch% -->
      <!-- %ifvar message% -->
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td class="message" colspan="2">%value message%</td></tr>
      <tr><td colspan="2">&nbsp;</td></tr>
      <!-- %endif% -->
      <!-- %ifvar action equals('validatePwd')% -->
      <!-- %invoke wm.server.db:validatePassword% -->
      <tr><td colspan="2">&nbsp;</td></tr>
      <tr><td class="message" colspan="2">%value message%</td></tr>
      <!-- %endinvoke% -->
      <!-- %endif% -->
      <!-- %ifvar falias% -->
      <tr>
	<td colspan="2">
	  <ul>
	    <li><a href="db-alias.dsp">Return to
		Alias Management</a></li>
	  </ul>
	</td>
      </tr>
      <!-- %endif% -->
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <!-- %ifvar falias% -->
	  <!-- %switch falias% -->
	  <!-- %case 'nnnn'% -->
	  <script type="text/javascript">
	    function onSubmit() {
		var alias = document.aliasform.alias.value;
		if (alias == null || alias == "") {
			alert ("Specify an alias name.");
		} else {
		        if (checkLegalName (document.aliasform.alias, "Alias"))
		        {
			  document.aliasform.submit();
			  return true;
			}
		}
		return false;
	    }

            function checkLegalName(field, fieldName)
            {
              var name = field.value;
              var illegalChars = "- #&@^!%*:$./\\`;,~+=)(|}{][><\"";

              for (var i=0; i<illegalChars.length; i++)
              {
                if (name.indexOf(illegalChars.charAt(i)) >= 0)
                {
                  alert (fieldName + " contains illegal character: '" + illegalChars.charAt(i) + "'");
                  field.value = "";
                  return false;
                }
              }
              return true;
            }
	  </script>
	  <form method="post" name="aliasform" action="db-alias.dsp">
	    <input type="hidden" name="action" value="add"></input>
	    <table class="tableForm" width="95%">
	      <tr><td class="heading" colspan="2">New DB Alias</td></tr>
	      <tr>
		<td class="evenrow">Alias</td>
		<td class="evenrow-l"><input name="alias" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow">DB URL</td>
		<td class="oddrow-l"><input name="url" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">DB Username</td>
		<td class="evenrow-l"><input name="user" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow">DB Password</td>
		<td class="oddrow-l"><input type="password" autocomplete="off" name="password" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">DB Driver</td>
		<td class="evenrow-l"><input name="args" size="43"></input></td>
		</tr>
	      <tr>
		<td class="oddrow">Minimum Connections</td>
		<td class="oddrow-l"><input name="minconns" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">Maximum Connections</td>
		<td class="evenrow-l"><input name="maxconns" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow" width="28%">Expiration Time (ms)</td>
		<td class="oddrow-l"><input name="expiretime" size="43"></input></td>
	      </tr>
	      <!-- %invoke wm.server.db:dataSourceList% -->
	      <!-- %ifvar drivers% -->
	      <tr>
		<td class="evenrow">Loaded Drivers</td>
		<td class="evenrow-l">
		  <select name="jdbc" onchange="driverSelect();">
		    <option value="none">&lt;None or new driver&gt;</option>
		    <!-- %loop drivers% -->
		    <option value="%value%">%value%</option>
		    <!-- %endloop% -->
		  </select>
		  <script type="text/javascript">
		    function driverSet (name) {
		    var driverSelect = document.aliasform.jdbc;
		    driverSelect.selectedIndex = 0;
		    if (name != "") for (var i=0; i<driverSelect.options.length; i++) {
			var thisname = driverSelect.options[i].value;
			if (thisname == name) {
				driverSelect.selectedIndex = i;
			}
		    }
		    }

		    function driverSelect () {
		    var driverSelect = document.aliasform.jdbc;
		    var newDriver = driverSelect.options[driverSelect.selectedIndex].value;
		    if (newDriver == "none") {
			document.aliasform.args.value = "";
			document.aliasform.args.focus();
		    } else {
			document.aliasform.args.value = newDriver;
		    }
		    }
		  </script>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <!-- %endinvoke% -->
	      <tr><td class="action" colspan="2">
		<input type="button" value="Submit"
		       onclick="onSubmit();"></input>
		<input type="button" value="Reset"
		       onclick="document.aliasform.reset();"></input>
		<input type="button" value="Cancel"
		       onclick="document.location='db-alias.dsp'"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	  <!-- %case% -->
	  <form method="post" name="aliasform" action="db-alias.dsp">
	    <table class="tableForm" width="95%">
	      <tr><td class="heading" colspan="2">Edit Alias Information</td></tr>
	      <!-- %invoke wm.server.db:dataSourceList% -->
	      <!-- %loop sources% -->
	      <!-- %ifvar alias vequals('/falias')% -->
	      <tr>
		<td class="evenrow">Alias</td>
		<td class="evenrow-l">%value alias%</td>
	      </tr>
	      <tr>
		<td class="oddrow">DB URL</td>
		<td class="oddrow-l"><input name="url" size="43" value="%value url%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">DB Username</td>
		<td class="evenrow-l"><input name="user" size="43" value="%value user%"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow">DB Password</td>
		<td class="oddrow-l">
		  <a href="db_user.dsp?falias=%value /falias%&amp;alias=%value alias%">Change password</a>
		</td>
	      </tr>
	      <tr>
		<td class="evenrow">DB Driver</td>
		<td class="evenrow-l"><input name="args" value="%value args%" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="oddrow">Minimum Connections</td>
		<td class="oddrow-l"><input name="minconns" value="%value minconns%" size="43"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">Maximum Connections</td>
		<td class="evenrow-l">
		  <input name="maxconns" value="%value maxconns%"
			 size="43"></input>
		</td>
	      </tr>
	      <tr>
		<td class="oddrow">Expiration Time (ms)</td>
		<td class="oddrow-l">
		  <input name="expiretime" value="%value expiretime%"
			 size="43"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <!-- %endloop% -->
	      <!-- %ifvar drivers% -->
	      <tr>
		<td class="evenrow" width="28%">Loaded Drivers</td>
		<td class="evenrow-l">
		  <select name="jdbc" onchange="driverSelect();">
		    <option value="none">&lt;None or new driver&gt;</option>
		    <!-- %loop drivers% -->
		    <option value="%value%">%value%</option>
		  <!-- %endloop% -->
		  </select>
		  <script type="text/javascript">
		    function driverSet (name) {
		    var driverSelect = document.aliasform.jdbc;
		    driverSelect.selectedIndex = 0;
		    if (name != "") for (var i=0; i<driverSelect.options.length; i++) {
			var thisname = driverSelect.options[i].value;
			if (thisname == name) {
				driverSelect.selectedIndex = i;
			}
		      }
		      }

		      function driverSelect () {
		      var driverSelect = document.aliasform.jdbc;
		      var newDriver = driverSelect.options[driverSelect.selectedIndex].value;
		      if (newDriver == "none") {
			document.aliasform.args.value = "";
			document.aliasform.args.focus();
		      } else {
			document.aliasform.args.value = newDriver;
		      }
		      }

		      driverSet (document.aliasform.args.value);
		  </script>
		</td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input type="hidden" name="action" value="change"></input>
		  <input type="hidden" name="alias" value="%value alias%"></input>
		  <input type="hidden" name="password" value="%value ../password%"></input>
		  <input type="submit" value="Submit" onclick="document.aliasform.submit();"></input>
		  <input type="button" value="Reset" onclick="document.aliasform.reset();"></input>
		  <input type="button" value="Cancel" onclick="document.location='db-alias.dsp'"></input>
		</td>
	      </tr>
	      <!-- %endif% -->
	      <!-- %endinvoke% -->
	    </table>
	  </form>
	  <!-- %endswitch% -->
	  <!-- %else% -->
	  <script type="text/javascript">
	    function getSelectedAlias  (action) {
		var opt = document.aliasform.alias;
		var alias = null;
		if (opt.selectedIndex == -1) {
			if (action == "edit") {
				alert ("Select an alias to edit.");
			}
			else if (action == "delete") {
				alert ("Select an alias to delete.");
			}
			else if (action == "connect to") {
				alert ("Select an alias to connect to.");
			}
			else {
				alert ("Select an alias to "+action+".");
			}
		} else {
			alias = opt.options[opt.selectedIndex].value;
		}
		return alias;
	    }

	    function editAlias () {
		var alias = getSelectedAlias ("edit");
		if (alias != null) {
			document.aliasform.falias.value = alias;
			document.aliasform.submit();
			return true;
		}
		return false;
	    }

	    function deleteAlias () {
		var alias = getSelectedAlias ("delete");
		if (alias != null) {
			if (confirm("OK to delete alias "+alias+"?")) {
				document.deleteform.alias.value = alias;
				document.deleteform.submit();
				return true;
			}
		}
		return false;
	    }

	    function connectAlias () {
		var alias = getSelectedAlias ("connect to");
		if (alias != null) {
			document.connectform.elements[0].value = alias;
			document.connectform.submit();
		}
		return false;
	    }
	  </script>
	  <form method="post" name="aliasform" action="db-alias.dsp">
	    <input type="hidden" name="falias" value=""></input>
	    <table class="tableForm">
	      <tr>
		<td class="heading">Current Data Sources</td>
	      </tr>
	      <tr>
		<td class="oddrow-l">
		  <select name="alias" size="6">
		    <!-- %invoke wm.server.db:dataSourceList% -->
		    <!-- %loop sources% -->
		    <option value="%value alias%">%value alias%</option>
		    <!-- %endloop% -->
		    <!-- %endinvoke% -->
		  </select>
		</td>
	      </tr>
	      <tr>
		<td class="action">
		  <input class="data" type="button" name="add" value="Add"
			 onclick="document.location='db-alias.dsp?falias=nnnn'"></input>
		  <input class="data" type="button" value="Edit" onclick="editAlias();"></input>
		  <input class="data" type="button" value="Delete" onclick="deleteAlias();"></input>
		  <input class="data" type="button" value="Connect" onclick="connectAlias();"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	  <form method="post" name="deleteform" action="db-alias.dsp">
	    <input type="hidden" name="action" value="delete"></input>
	    <input type="hidden" name="alias" value="xxx"></input>
	  </form>
	  <form method="post" name="connectform" action="db-connect.dsp">
	    <input type="hidden" name="$dbAlias" value="xxx"></input>
	  </form>
	  <!-- %endif% -->
	</td>
      </tr>
    </table>
  </body>
</html>
