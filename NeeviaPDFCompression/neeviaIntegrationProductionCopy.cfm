<component>

<cffunction name="MoveCompressReturn" access="public">

<!--Lets Get the file names from the DB table--->
<cfquery name="qryGetFilesJustUploaded" datasource="#request.dsn#">	
	SELECT fileupload
	FROM [First_Title_Services_Dev].[dbo].[upload_many]
	WHERE (fileupload Like '%.pdf%') and (needs_compression = '1')
	</cfquery>
	<cfset qryRecordCount = #qryGetFilesJustUploaded.RecordCount# >

<!--Set the methods and variables--->
<cfset fileSys = CreateObject('component','cfc.FileManagement')>

<cfloop query="qryGetFilesJustUploaded" startRow="1" endRow="#qryRecordCount#">
<cfset filename="#qryGetFilesJustUploaded.fileupload#" >
<cfset filePath = #fileSys.FindFilePath('#filename#','file')# >
<cffile action="move" source="#filePath#" destination="C:\compressionBin">
<cfset sleep(5000)>

<!---Compress the file now--->
<cfexecute name="C:\Program Files (x86)\neeviaPDF.com\PDFcompress\cmdLine\CLcompr.exe"
arguments="C:\compressionBin\#filename# C:\compressionBin\#filename# -co -ci jpg -cq 10 -gi jpg -gq 10 -mi jbig2 -mq 1"
outputfile="C:\inetpub\wwwroot\testingFolder\PDFCompression\bin\output.txt"
timeout="250">
</cfexecute>
<cfset sleep(5000)>
<!---Lets Return the file now--->
<!---Back to where you came from! :D--->
<cffile action="move" 
source="C:\compressionBin\#filename#" destination="#filePath#" >
<cfset sleep(5000)>
<cfquery name="qryUpdateFilesJustCompressed" datasource="#request.dsn#">
UPDATE [First_Title_Services_Dev].[dbo].[upload_many]
   SET 
      [needs_compression] = '0'
 WHERE (fileupload = '#filename#') and (needs_compression = '1')
</cfquery>

</cfloop>

</cffunction>

</component>
