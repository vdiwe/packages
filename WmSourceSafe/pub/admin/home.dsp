<?xml version='1.0'?>
<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
                      '/local/share/xml/XHTML/dtds/xhtml1-transitional.dtd'>

%invoke wm.vss.admin:getUiProperties%%endinvoke%

<html>
    <head>
        <title>%value uiProperties/productName%</title>
        <meta http-equiv='Content-Type' content='text/html; charset=UTF-8'></meta>
        <meta http-equiv="Pragma" content="no-cache"></meta>
        <meta http-equiv="Expires" content="-1"></meta>
        <link rel="stylesheet" type="text/css" href="/WmRoot/webMethods.css"></link>
        <link rel="stylesheet" type="text/css" href="/WmSourceSafe/vss.css"></link>
    </head>

    <body>
    
        %invoke wm.vss.admin:getStartupErrors%
            %scope startupErrors%
                <!-- Show startup errors, if any -->
                <table width=100%>
                    <tr>
                        <td id="message">
                            <b>Errors occured during package startup.</b>
                        </td>
                    </tr>
                    %loop -struct%
                        %scope #$key%
                            <tr class="message">
                                <td id="message">
                                    <b><a href=/WmSourceSafe/error/showErrorDetail.dsp?errorMessage=%value -urlencode $key%>%value message%</a></b>
                                    <a href=/invoke/wm.vss.error/getErrorDetail?errorMessage=%value -urlencode $key%>[alternate view]</a>
                                    <br>
                                    %ifvar reason%
                                        (caused by %value exceptionClass%: %value reason%)
                                    %endif%
                                </td>
                            </tr>
                        %endscope%
                    %endloop%
                </table>
                <!-- End startup errors -->
            %endscope%
        %endinvoke%
        
        %invoke wm.vss.admin:getConfiguration%
            %invoke wm.vss.admin.statistic:getStatistics%
                <table width=100%>
                
                    <tr>
                        <td class="menusection-Adapters" colspan=3>
                            %value uiProperties/button.name% &gt; %value uiProperties/tabs.1.name%
                        </td>
                    </tr>
            
                    <tr>
                        <td valign="top" width=50%>
                            <table class="table2" width=100%>
                                <tr>
                                    <td class="heading" colspan=3>
                                        General
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="oddcol" nowrap="nowrap">
                                        %value uiProperties/button.name% Start Date
                                    </td>
                                    <td class="oddrowdata" colspan=2>
                                        %value statistics/packageLoadDate%
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="heading" colspan=3>
                                        Logs
                                    </td>
                                </tr>

                                <tr>
                                    <td class="oddcol" nowrap="nowrap">
                                        %value uiProperties/button.name% Log
                                    </td>
                                    <td class="oddrowdata" colspan=2>
                                        <!-- this doesn't seem to work on all browsers -->
                                        <a href=/invoke/wm.vss.log/readLogFile?logId=WmSourceSafe>view</a>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="oddcol" nowrap="nowrap">
                                        %value uiProperties/button.name% Log Level
                                    </td>
                                    <td class="oddrowdata" colspan=1>
                                        %ifvar configuration/logLevel%
                                            %value configuration/logLevel%
                                        %else%
                                            Use server log level
                                        %endif%
                                    </td>
                                    <td class="oddrowdata">
                                        <a href=editLogLevel.dsp?logId=WmSourceSafe>change</a>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="oddcol" nowrap="nowrap">
                                        %value uiProperties/button.name% Errors
                                    </td>
                                    <td class="oddrowdata" colspan=2>
                                        <a href=/WmSourceSafe/error/showErrors.dsp>view</a>
                                    </td>
                                </tr>
                                
                                <tr>
                                    <td class="oddcol" nowrap="nowrap">
                                        %value uiProperties/button.name% Envelope Log
                                    </td>
                                    <td class="oddrowdata" colspan=2>
                                        <a href=envelopeLogging.dsp>view</a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    
                        <td valign="top" width=50%>
                            <table width=100%>
                                <tr>
                                    <td class="heading" colspan=2>
                                        Test
                                    </td>
                                </tr>
                                <tr>
                                    <td class="oddcol" nowrap="nowrap" colspan=2>
                                        <a href=../test/chooseTest.dsp>Test Connection</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="oddcol" nowrap="nowrap" colspan=2>
                                        <a href=../test/submitEnvelopeToService.dsp>Test Send/Receive</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="oddcol" nowrap="nowrap" colspan=2>
                                        <a href=../test/parseStringTest.dsp>Validate Document</a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
                <!-- end of top table -->

                %include envelopeStatisticsTable.dsp%

            %onerror%
                %include ../../../WmSourceSafe/pub/error/onerrorTable.dsp%
            %endinvoke%
        
        %onerror%
            %include ../../../WmSourceSafe/pub/error/onerrorTable.dsp%
        %endinvoke%
    </body>
</html>
