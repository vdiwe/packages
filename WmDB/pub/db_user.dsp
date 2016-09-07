<html>
  <head>
    <title>WmDB - Alias Management</title>
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<meta http-equiv="Expires" content="-1">
    <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
  </head>
  <body>
    <table width="100%">
      <tr>
	<td class="menusection-Adapters" colspan="2">WmDB &gt;
	  Alias Management &gt; Change Password</td>
      </tr>
      <tr>
	<td class="padding">&nbsp;</td>
	<td>
	  <form method="post" name="create" action="db-alias.dsp">
	    <table class="tableForm">
	      <tr>
		<td class="heading" colspan="2">Set Password
		  Information</td>
	      </tr>
	      <tr>
		<td class="oddrow">New Password</td>
		<td class="oddrow-l">
		  <input name="newPwd" type="password" autocomplete="off" size="25" value="%value newPwd%"></input></td>
	      </tr>
	      <tr>
		<td class="evenrow">Retype New Password</td>
		<td class="evenrow-l">
		  <input name="newPwd2" type="password" autocomplete="off" size="25" value="%value newPwd2%"></input></td>
	      </tr>
	      <tr>
		<td class="action" colspan="2">
		  <input type="hidden" name="alias" value="%value alias%"></input>
		  <input type="hidden" name="falias" value="%value falias%"></input>
		  <input type="hidden" name="action" value="validatePwd"></input>
		  <input type="hidden" name="newPwd" value="%value newPwd%"></input>
		  <input type="hidden" name="newPwd2" value="%value newPwd2%"></input>
		  <input type="submit" value="Set Password"></input>
		  <input type="button" value="Cancel" onclick="document.location='db-alias.dsp?falias=%value falias%'"></input>
		</td>
	      </tr>
	    </table>
	  </form>
	</td>
      </tr>
    </table>
  </body>
</html>
