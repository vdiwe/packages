<!-- Copyright (c) 2003, webMethods Inc.  All Rights Reserved. -->

<html>
	<head>
		<style type='text/css'>
			.readonlystyle { background: #ccc; }
		</style>
		
		<meta http-equiv="Pragma" content="no-cache">
		<meta http-equiv="Expires" content="-1">
		<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>
		<link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css">
		<script src="/WmRoot/webMethods.js.txt"></script>
		<script>
			function onSubmit()
			{
				var length = document.config.elements.length;
				for (index = 0; index < length; index++)
				{
					var element = document.config.elements[index];
					// Don't submit passwords if they have not been changed.
					if (element.type == "password" && element.value == "********")
					{
						element.disabled = true;
					}
				}
				document.config.edit.value = true;
				document.config.submit();
				return true;
			}
			
			function checkUseEncryptionField()
			{			
				if(!document.config.encryption_checkbox.checked)
				{
					document.config.encryption_checkbox.value= "false";
				}	
				else
				{			
					document.config.encryption_checkbox.value= "true";
				}											
			}

			function checkEventEnableField()
            {
            	if(!document.config.eventEnable_checkbox.checked)
            		{
            			document.config.eventEnable_checkbox.value= "false";
            		}
            		else
            		{
            			document.config.eventEnable_checkbox.value= "true";
            		}
            }
			function checkISOUTCTimeField()
			{	
				if(!document.config.time_checkbox.checked)
				{
					document.config.time_checkbox.value= "off";
				}	
				else
				{			
					document.config.time_checkbox.value= "on";
				}												
			}
						
			function isRequiredFieldEmpty(fieldName)
			{				
				var field = document.config.elements[fieldName];
				
				if(field.value!="")
				{
					field.style.backgroundColor="#FFFFFF";
				}
				else
				{
					field.style.backgroundColor="#FFE5E9";
				}
			}			
						
			function markRequiredFields()
			{
				var brokerSSL = document.config.elements["wm.wmoptimize.broker.useSSL"];
				var keyStoreFile = document.config.elements["wm.wmoptimize.ssl.keyStoreFile"];
				var trustStoreFile = document.config.elements["wm.wmoptimize.ssl.trustStoreFile"];
				var brokerPassword = document.config.elements["wm.wmoptimize.ssl.password"];
				
				if(brokerSSL.checked)
				{
					keyStoreFile.style.backgroundColor="#FFE5E9";
					trustStoreFile.style.backgroundColor="#FFE5E9";					
					brokerPassword.style.backgroundColor="#FFE5E9";
				}
				else
				{
					keyStoreFile.style.backgroundColor="#FFFFFF";
					trustStoreFile.style.backgroundColor="#FFFFFF";					
					brokerPassword.style.backgroundColor="#FFFFFF";
				}
			}
		</script>
	</head>
	<body onLoad="setNavigation('controllerConfigSettings.dsp');">
		<table width="100%">
			%ifvar action equals('saveConfiguration')%
				%invoke wm.optimize.configuration.ConfigurationService:saveConfiguration%				
				%switch status%
					%case 'success'%
						<script>writeMessage("%value -code msg%");</script>
					%case 'warning'%
						<script>writeMessage("%value -code msg%");</script>
					%case 'error'%
						<script>writeMessage("%value -code msg%");</script>
				%end%
				%onerror%
					%loop -struct%
						<tr><td>%value $key%=%value%</td></tr>
					%endloop%
				%endinvoke%
			%end if%
		</table>
		<table width="100%">
			<tr>
				<td class="menusection-Settings" colspan="2">
				  WmOptimize &gt; Configuration Settings 
				</td>
			</tr>
			<tr>
				<td>
					<form name="config">
						<table class="tableForm">
							<tr>
								<td class="heading" colspan="2">Configuration Settings</td>
							</tr>
							%invoke wm.optimize.configuration.ConfigurationService:loadConfiguration%
								%ifvar properties%
									<script> resetRows();</script>
									<script> swapRows();</script>
									%loop properties%
							<tr>
								<script> writeTD("row");</script>
									%value description%
								</td>
									<script> writeTD("rowdata-l");</script>		
									%switch key%
										%case 'wm.wmoptimize.ae.useSSL'%
											<input type="checkbox" name="%value key%" value="true" %ifvar value equals('true')% checked %endifvar%>
										%case 'wm.wmoptimize.broker.useSSL'%
											<input type="checkbox" name="%value key%" value="true" %ifvar value equals('true')% checked %endifvar% onclick="markRequiredFields()">
										%case 'wm.wmoptimize.ssl.useEncryption'%
											<input type="checkbox" name="%value key%" value="true" %ifvar value equals('true')% checked %endifvar%>
										%case 'wm.wmoptimize.mapi.eventEnable'%
                                        	<input type="checkbox" name="%value key%" value="true" %ifvar value equals('true')% checked %endifvar%>
                                        %case 'wm.wmoptimize.ssl.keyStoreFile'%
											<input name="%value key%" id="keystorefile_text" size="80" value="%value value%" onchange="isRequiredFieldEmpty('%value key%')">
										%case 'wm.wmoptimize.ssl.trustStoreFile'%
											<input name="%value key%" id="truststorefile_text" size="80" value="%value value%" onchange="isRequiredFieldEmpty('%value key%')">										
										%case 'wm.wmoptimize.ssl.password'%
											<input type="password" name="%value key%" size="80" value="" onchange="isRequiredFieldEmpty('%value key%')">
										%case 'wm.wmoptimize.ae.password'%
											<input type="password" name="%value key%" size="80" value="********">
										%case 'wm.wmoptimize.iso.utc.time.handling'%
											<input type="checkbox" name="%value key%" value="true" %ifvar value equals('true')% checked %endifvar%>
										%case% 
											<input name="%value key%" size="80" value="%value value%">
									%end%
								</td>
								<script> swapRows();</script>
							</tr>
									%endloop%
								%endifvar%
							%onerror%
								%loop -struct%
									<tr><td>%value $key%=%value%</td></tr>
								%endloop%
							%endinvoke%
							<tr>
								<td class="action" colspan=2>
									<input type="hidden" name="action" value="saveConfiguration">
									<input type="hidden" name="edit">									
									<input type="button" value="Submit" onclick="onSubmit();">
								</td>
							</tr>
						</table>
					</form>
				</td>
			</tr>
		</table>
	</body>
</html>
