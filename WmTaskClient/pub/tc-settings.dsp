<HTML>
    <HEAD language="JavaScript">
        <LINK REL="stylesheet" TYPE="text/css" HREF="webMethods.css">
        <SCRIPT SRC="webMethods.js.txt"></SCRIPT>
    </HEAD>
    <BODY>
        <TABLE width="100%">
            <p>
            %switch action%
                %case 'update'%
                    %invoke wm.task.taskclient:setConfig%
                        <tr>
                            <td class="message" colspan="2">
                                Changes applied successfully.
                            </td>
                        </tr>
                    %endinvoke%
                    %invoke wm.task.taskclient:init%
                    %endinvoke%
                %end%

                %invoke wm.task.taskclient:getConfig%
                %endinvoke%
            </p>
  
            <TR>
                <TD class="menusection-Packages" colspan="2">
                    WmTaskClient Configuration
                </TD>
            </TR>

            <TR>
                <TD>
                    <img src="images/blank.gif" height=10 width=10 border=0>
                </TD>

                <TD>
                    <TABLE class="tableForm" CELLPADDING=2>
                        <FORM name="testform" method="post" action="tc-settings.dsp">
                            <input type="hidden" name="action" value="update">
                           	<TR>
		                        <TD class="heading" colspan=2>Task Client Configuration</TD>
	                        </TR>

                            <TR>
                                <script>writeTD("row");</script>
                                    Task Server URL &nbsp;&nbsp;
                                </TD>
                                <script>writeTD("row-l");</script>
                                    <INPUT name="taskclienturl" value="%value taskclienturl%"/>
                                </TD>
	                        </TR>


		                    <script>swapRows();</script>


                       	    <TR>
		                        <script>writeTD("row");</script>
		                            Task Server Username &nbsp;&nbsp;
                                </TD>
		                        <script>writeTD("row-l");</script>
		                            <INPUT name="taskclientuser" value="%value taskclientuser%">
                                </TD>
	                        </TR>

		                    <script>swapRows();</script>

	                        <TR>
		                        <script>writeTD("row");</script>
		                            Task Server Password &nbsp;&nbsp;
                                </TD>
		                        <script>writeTD("row-l");</script>
		                            <INPUT name="taskclientpassword" type="password" value="******">
                                </TD>
	                        </TR>

                    		<script>swapRows();</script>

                            <TR>
                                <script>writeTD("row");</script>
                                    Socket Timeout (milliseconds)&nbsp;&nbsp;
                                </TD>
                                <script>writeTD("row-l");</script>
                                    <INPUT name="taskclienttimeout" value="%value taskclienttimeout%"/>
                                </TD>
	                        </TR>

                    		<script>swapRows();</script>

                            <TR>
                                <script>writeTD("row");</script>
                                    Number of Retries on Service Failure&nbsp;&nbsp;
                                </TD>
                                <script>writeTD("row-l");</script>
                                    <INPUT name="taskclientretries" value="%value taskclientretries%"/>
                                </TD>
	                        </TR>

		                    <script>swapRows();</script>

                            <TR>
                                <script>writeTD("row");</script>
                                    Delay Between Service Retries (milliseconds)&nbsp;&nbsp;
                                </TD>
                                <script>writeTD("row-l");</script>
                                    <INPUT name="taskclientretrydelay" value="%value taskclientretrydelay%"/>
                                </TD>
	                        </TR>

		                    <script>swapRows();</script>

                            <TR>
                                <script>writeTD("row");</script>
                                    Integration Server ACL containing users allowed to impersonate&nbsp;&nbsp;
                                </TD>
                                <script>writeTD("row-l");</script>
                                    <INPUT name="taskclientimpersonateacl" value="%value taskclientimpersonateacl%"/>
                                </TD>
	                        </TR>

	    
                            <TR>
                                <TD>
		                            <INPUT class="button2" type="submit" value="Save"/>
                                </TD>
	                        </TR>
                        </FORM>
                    </TABLE>
                </TD>
            </TR>
        </TABLE>
    </BODY>
</HTML>