
   <!--- Set Variable with the current date time--->
    cflock timeout="120" scope="server" type="exclusive">
	<cfset timeStamp = #Now()# />
	<!--- Strip out the {ts} portion of the datetimestamp. Otherwise SQL Server won't allow Now() to be directly inserted into a query--->
	<cfset dateTimeStamp = ReplaceNoCase(timeStamp, "{", "", "ALL")/>
	<cfset dateTimeStamp = ReplaceNoCase(dateTimeStamp, "}", "", "ALL")/>
	<cfset dateTimeStamp = ReplaceNoCase(dateTimeStamp, "'", "", "ALL")/>
	<cfset dateTimeStamp = ReplaceNoCase(dateTimeStamp, "ts","","ALL") />
    </cflock>
<!--- Now loop through the returned list of file names returned in the query and compress the associated files --->    
<!---Get the query of the files just uploaded by date  time stamp--->

<cfquery name="qryGetFilesJustUploaded" datasource="#request.dsn#">											<!--- Limit to filed with pdf file type endings --->
SELECT fileupload
  FROM [First_Title_Services_Dev].[dbo].[upload_many]
  WHERE filedate >= '#dateTimeStamp#' AND fileupload Like '% .pdf'
</cfquery>

<!--- Next Set a loop function to run cfexecute--->
<cfloop query="qryGetFilesJustUploaded">
<cfset pdf_file_name = 'qryGetFileJustUploaded' />
<cfexecute name="C:\Program Files (x86)\neeviaPDF.com\PDFcompress\cmdLine\CLcompr.exe"
arguments="C:\inetpub\wwwroot\testingFolder\PDFCompression2\pdf\#pdf_file_name# C:\inetpub\wwwroot\testingFolder\PDFCompression2\pdf\#pdf_file_name# -co -ci jpg -cq 10 -gi jpg -gq 10 -mi jbig2 -mq 1"
outputfile="C:\inetpub\wwwroot\testingFolder\PDFCompression2\output.txt"
timeout="250">
</cfexecute>
</cfloop>
