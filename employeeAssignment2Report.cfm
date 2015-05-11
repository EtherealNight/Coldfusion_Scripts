<cfcomponent>
<!---Check Employee Assignment--->

<!---Assign Employee to Report Method--->
	<cffunction name="assignEmployee" access="public" returntype="string">
		<cfargument name="employeeID" type="numeric" required="yes" default="11299">
        <cfargument name="fName" type="string" required="yes" default="Michael">
        <cfargument name="lName" type="string" required="yes" default="Rodriguez">
        <cfargument name="assignedReport" type="numeric" required="yes" default="2" hint="This is the report ID number">
        <cfargument name="reportName" type="string" required="yes" default="Sample Report">
        <cfargument name="reportDescrip" type="string" required="yes" default="Sample reporting for testing">
        <cfargument name="url" type="any" required="yes" default="admin/reports/test">
        
        <!---Check For Existing Assignment--->
        <cfquery name="qryAlreadyAssigned" datasource="First_Title_Main_Dev" dbname="First_Title_Services_Dev">
        SELECT *
  		FROM [First_Title_Services_Dev].[dbo].[AssignedReports]
  		WHERE employeeID = '11299' AND assignedReport = '2'
        </cfquery>
        <!---If record count is zero, run insert query to assign employee to report--->
        <cfif qryAlreadyAssigned.recordCount eq 0>
        <!---Assignment Query--->
        <cfquery name="qryAssignEmployee" datasource="First_Title_Services_Dev" dbname="First_Title_Services_Dev">
         INSERT INTO AssignedReports (employeeID, fName, lName, assignedReport, reportName, reportDescrip, url)
   		
         VALUES (<cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.employeeID#">, 
    			<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.fName#">,
          	    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lName#">,
         	    <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.assignedReport#">,
         	    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.reportName#">,
        	    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.reportDescrip#">,
         	    <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.url#">)
        </cfquery>
        <cfelse>
        <h2>Employee already assigned to selected report. Please try new assignment</h2>
        </cfif>
	</cffunction>
</cfcomponent>
