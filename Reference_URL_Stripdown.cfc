<!---Function named EndRequestFunc for testing safely on CF Server--->
<!---Rename function to OnRequestStart and place in Application.cfm file before running live--->
<cffunction name="EndRequestFunc" access="public" returnType="string">
<!---Variable declared and set to empty--->
<cfset referer_path_and_file = "">
<cfset referer_path = "">
<cfset referer_file_name = "">
<cfset script_path_and_file = "">
<cfset script_path = "">
<cfset script_file_name = "">

<!---This block defines the reference file which refers user to the subsequent script URL and file--->
<cfif cgi.HTTP_REFERER neq ''>
  <!--- all of this will fail if there is no referer, for instance, if they bookmark the page --->
  <!--- cgi.HTTP_REFERER may contain URL parameters, so let's strip those --->
  <cfset referer_path_and_file = ListFirst(CGI.HTTP_REFERER, "?")>
  <!--- now let's get just the path, stripping out the web server info --->
  <cfset referer_path = ListDeleteAt(CGI.HTTP_REFERER, ListLen(CGI.HTTP_REFERER, "/"), "/")>
  <cfset referer_path = ReplaceNoCase(referer_path, "https", "", "All")>
  <cfset referer_path = ReplaceNoCase(referer_path, "http", "", "All")>
  <cfset referer_path = ReplaceNoCase(referer_path, "://machine1.firsttitleservices.com", "", "All")>
  <cfset referer_path = ReplaceNoCase(referer_path, "://www_dev.firsttitleservices.com", "", "All")>
  <cfset referer_path = ReplaceNoCase(referer_path, "://www.firsttitleservices.com", "", "All")>
  <cfset referer_path = ReplaceNoCase(referer_path, "://10.11.2.60/", "", "All")>
  <cfset referer_path = referer_path & "/">
  <cfset referer_path = ReplaceNoCase(referer_path, "/", "\", "All")>
  <!--- now let's remove everything but the file name --->
  <cfset referer_file_name = ListLast(referer_path_and_file, "/")>
  <!--- and that leaves us with these variables set --->
 <!--- referer_path_and_file = "#referer_path_and_file#"<br />
  referer_path = "#referer_path#"<br />
  referer_file_name = "#referer_file_name#"<br />
  <br />--->
</cfif> 

<!--- now let's remove everything but the file name --->
<cfset script_file_name = ListLast(script_path_and_file, "/")>
<!--- and that leaves us with these variables set--->
<!---script_path_and_file = "#script_path_and_file#"<br />
script_path = "#script_path#"<br />
script_file_name = "#script_file_name#"<br />--->
<!---<!---CFC Test Query--->
   <cfquery name="qryTest" datasource="First_Title_Main_Dev" >
INSERT INTO tblCFMPageRequest(pageName)
     VALUES
           ('MyPage.cfm')
   </cfquery>--->

<!---Directory Stripping And Modifier Block Goes Here--->
<!---Set CGI System Variables--->
<cfset currentHeader = CGI.HTTP_REFERER >
<cfset currentScriptPage = CGI.SCRIPT_NAME > 
<!---Set currentScriptPage as command line directory string and delcare new variable "reverseScriptPage"--->
<cfset reverseScriptPage = ReReplace(#currentScriptPage#, "/", "\","ALL")>
<!---Set reverseScriptPage value as newly format command line directory structure--->
<cfset newScriptPage = ListSetAt(#reverseScriptPage#, 1, "#reverseScriptPage#") >
<cfset lastScriptPage = ListFirst(#newScriptPage#, "/") > <!---Added this 5/11/2015--->
 <cfset  finalScriptPage = ListSetAt(#lastScriptPage#, 1, "#lastScriptPage#") > <!---Added this 5/11/2015--->
<cfset finalScriptPath = ReplaceNoCase(#finalScriptPage#,"\","","2" )> <!---Added this 5/11/2015--->

<!---<cfoutput>#CGI.CF_TEMPLATE_PATH#</cfoutput>--->

<!---CGI.HTTP_HEADER Formatting Block--->
<!---This block retrieves the http header value, then strips http formatting--->
<!---currentHeader variable truncated by ListLast then assigned to variable headerFileName--->
<cfset headerFileName = ListLast(#currentHeader#,"/")>
<!---currentHeader URL string has "/" replaced with "\" characters then set as variable reverseHeaderURL--->
<cfset reverseHeaderURL = ReReplace(#currentHeader#, "/", "\","ALL")>
<!---reverseHeaderURL is stripped of all known http type formattings and IP formattings--->
<cfif cgi.HTTP_REFERER neq ''>
<cfset reverseHeaderURL = ListDeleteAt(cgi.HTTP_REFERER, ListLen(cgi.HTTP_REFERER, "/"), "/")>
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "https", "", "All")>
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "http", "", "All")>
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "://machine1.firsttitleservices.com", "\", "All")> <!---This line adds the \ before the root folder--->
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "://www_dev.firsttitleservices.com", "\", "All")>  <!---This line adds the \ before the root folder--->
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "://www.firsttitleservices.com", "\", "All") >     <!---This line adds the \ before the root folder--->
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "://machine1.firsttitleservices.com", "\", "All")> <!---This line adds the \ before the root folder--->
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, "://10.11.2.60/", "\", "All")>                     <!---This line adds the \ before the root folder--->
  <cfset reverseHeaderURL = ReplaceNoCase(reverseHeaderURL, ":\\dev.firsttitleservices.com\", "\", "All")>     <!---This line adds the \ before the root folder--->
  <!---The end result is then formatted to C:\\ command line format and stored in new variable newHeaderURL--->
 <cfset newHeaderURL = ListSetAt(#reverseHeaderURL#, 1, "#reverseHeaderURL#") >
  <cfset newHeaderURL = newHeaderURL & "\">                                                                     <!---This line sets the "\" on the tail end--->
<cfset finalHeaderURL = ReReplace(#newHeaderURL#, "/", "\","ALL")>                                              <!---This line ensures all "/" are set as "\"--->
</cfif>

<!--- cgi.SCRIPT_NAME does not include URL parameters --->
<cfset script_path_and_file = ListFirst(CGI.SCRIPT_NAME, "\")>
<!---<!--- now let's get just the path, stripping out the web server info --->
<cfset script_path = GetDirectoryFromPath(GetCurrentTemplatePath())>
<cfset script_path = ReplaceNoCase(script_path, "C:\inetpub\wwwroot\Clients\firsttitleservices.com\www_dev", "", "All")>
<cfset script_path = ReplaceNoCase(script_path, "C:\inetpub\wwwroot\Clients\firsttitleservices.com\www", "", "All")>--->

<!---This Block Acquires the Script File Path--->
<cfif cgi.PATH_INFO neq ''>
  <!--- all of this will fail if there is no referer, for instance, if they bookmark the page --->
  <!--- cgi.HTTP_REFERER may contain URL parameters, so let's strip those --->
  <cfset script_path_and_file = ListFirst(CGI.PATH_INFO, "?")>
  <!--- now let's get just the path, stripping out URL formatting --->
  <cfset script_path = ListDeleteAt(CGI.PATH_INFO, ListLen(CGI.PATH_INFO, "/"), "/")>
  <cfset script_path = ReplaceNoCase(script_path, "https", "", "All")>								 <!---This line replaces "https" with clearspace before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "http", "", "All")>								 <!---This line replaces "http" with clearspace before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "://machine1.firsttitleservices.com", "\", "All")> <!---This line adds the \ before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "://www_dev.firsttitleservices.com", "\", "All")>  <!---This line adds the \ before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "://www.firsttitleservices.com", "\", "All")>      <!---This line adds the \ before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "://10.11.2.60/", "\", "All")>                     <!---This line adds the \ before the root folder--->
  
  <cfset script_path = script_path & "\">
<!---  <cfset script_path = ReplaceNoCase(script_path, "/", "\", "All")>--->
  <cfset script_path = ReReplace(script_path, "/", "\","ALL")>
  <cfset script_path = GetDirectoryFromPath(GetCurrentTemplatePath())>
  <cfset script_path = ReplaceNoCase(script_path, "C:\inetpub\wwwroot\Clients\firsttitleservices.com\www_dev", "\", "All")> <!---This line adds the \ before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "C:\inetpub\wwwroot\Clients\firsttitleservices.com\www", "\", "All")>     <!---This line adds the \ before the root folder--->
  <cfset script_path = ReplaceNoCase(script_path, "C:\inetpub\wwwroot\", "\", "All")>                                       <!---This line adds the \ before the root folder---> 
  <cfset script_path = ReReplace(script_path, "/", "\","ALL")>
  <!--- now let's remove everything but the file name --->
  <cfset script_file_name = ListLast(script_path_and_file, "/")>
  <!--- and that leaves us with these variables set --->
 <!--- referer_path_and_file = "#referer_path_and_file#"<br />
  referer_path = "#referer_path#"<br />
  referer_file_name = "#referer_file_name#"<br />
  <br />--->
</cfif>


   <!---Queries Table To Get Requested Record--->
    <cfquery name="qryGetPageRecord" datasource="First_Title_Main_Dev" dbname="First_Title_Services_Dev">    <!---Query for existing record check--->
    SELECT referrerPage																						 <!---columnn in the database table--->
    FROM tblCFMPageRequest																					 <!---Table being referenced in the DB--->
    WHERE referrerPage = '#referer_file_name#' AND scriptName = '#script_file_name#'                         <!---condition checked for in the table for existing record--->
    </cfquery>
    <cfif qryGetPageRecord.recordCount eq 0>                                                                  <!---Conditional Check for record count equal to 0--->
	<!---<cfset httpReferer = ListLast('http://www.my.com/index.cfm?uid=reece',"/")>
    <cfset ListFirst(httpReferer,"?")>--->
    <!---variable declared as scriptName and set equal to CGI.SCRIPT_NAME --->
    <!---Value truncated to actual file name through function ListLast() --->
	<!---<cfset scriptName  = ListLast('http://www.my.com/sales.cfm?uid=r433h', "/")>
    <cfset ListFirst(scriptName,"?")>--->
    <cfquery name="setNewRecord" datasource="First_Title_Main_Dev" dbname="First_Title_Services_Dev">         <!---Query to set new record---->
    INSERT INTO tblCFMPageRequest (referrerPage, referrerPath, scriptName, scriptPath)                        <!---SQL table column names--->
    VALUES (<cfqueryparam cfsqltype="cf_sql_varchar" value="#referer_file_name#">,                            <!---File name of the file which referred user to next page--->
    		<cfqueryparam cfsqltype="cf_sql_varchar" value="#finalHeaderURL#">,                               <!---directory path of the file which referred user to next page--->
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#script_file_name#">,                             <!---file name of the page user landed on from referrer page--->
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#script_path#">)                                  <!---directory path of the page user landed on--->
  </cfquery>
    </cfif>
</cffunction>
