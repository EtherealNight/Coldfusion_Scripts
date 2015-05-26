<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>First Title Reporting Assignments</title>
</head>

<body>

<html>
    <head>
    <title>First Title Reporting Assignment </title>

    </head>
    <body bgcolor="#CCCCCC" >
    
    <!--- Script Block for Client Side functionality--->
    
<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
<script language="javascript">
	
	$(document).ready(function() {
        $("#createReport").click(function(f) {
			var getReportName = $("input#reportName").val();
			var getReportPath = $("input#reportPath").val();
			var getReportDesc = $("input#reportDescrip").val();
			//var getCategory   = $("input#categoryBox").val();
			
			
			$.ajax({
				type:"POST",
				url: "http://10.11.2.60/testFolder/bidirectionalreporting/codetest/components/coldfusionFunction.cfc?method=testFunc&returnformat=json",
				dataType: "JSON",
				data:{ 
						reportName: getReportName,
						reportPath: getReportPath,
						reportDescrip: getReportDesc
						//categoryBox: getCategory
					
				},
				success: function(result){
					alert("You successfully added a new report to the system") } 
    });
		});
	});
	//function alertTest(){
//		alert("Your button works") ;}
			
		
</script>
<style>
  body {
      
      margin: 50px auto 200 auto;
      font-family: Arial, Helvetica;
      font-size: small;
      background: #444;
	  width: 100%;
	  height: 100%;
  }

/* ------------------------------------------------- */

#tabs {
  overflow: hidden;
  width: 80%;
  height:auto;
  margin: 0;
  padding: 0;
  list-style: none;
}

#tabs li {
  float: left;
  margin: 0 .5em 0 0;
}

#tabs a {
  position: relative;
  background: #ddd;
  background-image: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ddd));
  background-image: -webkit-linear-gradient(top, #fff, #ddd);
  background-image: -moz-linear-gradient(top, #fff, #ddd);
  background-image: -ms-linear-gradient(top, #fff, #ddd);
  background-image: -o-linear-gradient(top, #fff, #ddd);
  background-image: linear-gradient(to bottom, #fff, #ddd);  
  padding: .7em 3.5em;
  float: left;
  text-decoration: none;
  color: #444;
  text-shadow: 0 1px 0 rgba(255,255,255,.8);
  -webkit-border-radius: 5px 0 0 0;
  -moz-border-radius: 5px 0 0 0;
  border-radius: 5px 0 0 0;
  -moz-box-shadow: 0 2px 2px rgba(0,0,0,.4);
  -webkit-box-shadow: 0 2px 2px rgba(0,0,0,.4);
  box-shadow: 0 2px 2px rgba(0,0,0,.4);
}

#tabs a:hover,
#tabs a:hover::after,
#tabs a:focus,
#tabs a:focus::after {
  background: #fff;
}

#tabs a:focus {
  outline: 0;
}

#tabs a::after {
  content:'';
  position:absolute;
  z-index: 1;
  top: 0;
  right: -.5em;  
  bottom: 0;
  width: 1em;
  background: #ddd;
  background-image: -webkit-gradient(linear, left top, left bottom, from(#fff), to(#ddd));
  background-image: -webkit-linear-gradient(top, #fff, #ddd);
  background-image: -moz-linear-gradient(top, #fff, #ddd);
  background-image: -ms-linear-gradient(top, #fff, #ddd);
  background-image: -o-linear-gradient(top, #fff, #ddd);
  background-image: linear-gradient(to bottom, #fff, #ddd);  
  -moz-box-shadow: 2px 2px 2px rgba(0,0,0,.4);
  -webkit-box-shadow: 2px 2px 2px rgba(0,0,0,.4);
  box-shadow: 2px 2px 2px rgba(0,0,0,.4);
  -webkit-transform: skew(10deg);
  -moz-transform: skew(10deg);
  -ms-transform: skew(10deg);
  -o-transform: skew(10deg);
  transform: skew(10deg);
  -webkit-border-radius: 0 5px 0 0;
  -moz-border-radius: 0 5px 0 0;
  border-radius: 0 5px 0 0;  
}

#tabs #current a {
  background: #fff;
  z-index: 3;
}

#tabs #current a::after {
  background: #fff;
  z-index: 3;
}

/* ------------------------------------------------- */

#content {
    background: #fff;
    padding: 2em;
    height: 220px;
    position: relative;
    z-index: 2;	
    -moz-border-radius: 0 5px 5px 5px;
    -webkit-border-radius: 0 5px 5px 5px;
    border-radius: 0 5px 5px 5px;
    -moz-box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
    -webkit-box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
    box-shadow: 0 -2px 3px -2px rgba(0, 0, 0, .5);
}

/* ------------------------------------------------- */

#about {
    color: #999;
}

#about a {
    color: #eee;
}

</style>

    <!---Shut off debugging--->
    <cfsetting showdebugoutput="no">
    <!---Invoke Components--->
    <cfinclude template="controller/reportController.cfc">
    <!---Employee List Query--->
    <cfquery name="getAvailableEmployees" datasource="First_Title_Main_Dev">     <!---This query selects employee names from the First_Admin table then concatenates the names.--->
    SELECT ID, fname + ' ' + lname AS employeeName 								 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM First_Admin
    WHERE ID NOT IN (SELECT employeeID FROM AssignedReports)														 <!---Table referenced is First_Admin--->
    ORDER BY employeeName
    </cfquery>
    
    <!---Employee Assigned Query--->
    <cfquery name="getAssignedEmployees" datasource="First_Title_Main_Dev">  <!---This query selects the assigned employees from the AssignedReports table--->
 	SELECT employeeName									 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM AssignedReports												  	 <!---Table referenced is AssignedReports--->
    ORDER BY employeeName
    </cfquery>
    
    <!---Report Name Retrieval Query--->
     <cfquery name="getReports" datasource="First_Title_Main_Dev"> 			 <!---This query selects the assigned employees from the AssignedReports table--->
 	SELECT rid, Report_Name											 <!---SELECT Statement then concatenate the first and last name, aliased as column Full_Name--->
    FROM Report_Master_List													  	 <!---Table referenced is AssignedReports--->
    </cfquery>
         <!---Application Control Pane--->
  <div id="right_div" style="position:fixed; width: 100%; background-color:#CCC; float:none;">
  
            <!---Application Control Pane Query--->
<cfquery name="qEmployeeAssignments" datasource="First_Title_Main_Dev">		<!---Control Grid Query. Grabs all employees assigned to a report--->
    SELECT employeeName, reportName, reportDescrip      <!---Query criteria: first name, last name, reportName, reportDescrip --->
    FROM AssignedReports													<!--- Table being referenced --->
</cfquery>

     <!---This begins the visual component layout--->
     <div id="entire-page-div" style="position: relative; overflow: hidden; width:95%; margin-left:20px">
     <div id="left_module" style="position: relative; width: 30%; background-color:#CCC; float:left; margin-right:10px" >
     <br/>												                   <!---This is the available employees list. Returns employees not assigned to a report--->
   <p>Available Employees</p>
     <cfform name="assignedEmployees" action="getReport.cfm" width="100%" height="240" format="html" >  <!---Form Initialization--->
     <cfselect name="employee" query="getAvailableEmployees"                     <!---CFSELECT To populate form element from above Available Employee  query --->
     value="employeeName" display="employeeName" required="yes" size="10">       <!---CFSELECT To populate form element from above Available Employee  query --->
     </cfselect>
     <br />
     </cfform>
     </div>
     	   <!---     ---->
           <!---     ---->
           <!---     ---->
            
     <div id="center_div" style="position: relative; width: 30%; background-color:#CCC; float:left; margin-left:20px">
     <!---Assigned Employees Module---> 
     <br/>
     <p>Assigned Employees</p>
     <cfform name="assignedEmployees" action="getReport.cfm" width="100%" height="240">   		<!---Assigned Employee Form Initialization--->
   	 <cfselect name="employee" query="getAssignedEmployees"                  					<!---CFSELECT To populate form element from above Employee Assignment query --->
     value="employeeName" display="employeeName" required="yes" size="10">		 				<!---CFSELECT To populate form element from above Employee Assignment query --->
     </cfselect>
   	 </cfform>
     </div>
            
          <!---     ---->
          <!---     ---->
          <!---     ---->
          
     <div id="right_div" style="position: relative; width: 30%; background-color:#CCC; float: left; margin-left:30px">
     <!---Report List Module --->											
      <br/>
     <p>Available Reports</p>
     <cfform action="getReport.cfm" name="assignedEmployees" height="240" width="100%">	<!---Report List Form Initialization--->
     <cfselect name="Report_Name" query="getReports" 							                <!---CFSELECT To populate form element from above Get Report query--->
     value="Report_Name" display="Report_Name" required="yes" size="10">                    <!---CFSELECT To populate form element from above Get Report query--->
     </cfselect>
     <br />
      <cfinput type="button" name="AssignEmp" label="Assign Employee" value="Manage Reports">
   	 </cfform>
     </div>            
     </div>
     <br/>
 <div>    
     <ul id="tabs">
    <li><a href="#" name="tab1">Employee Perspective</a></li>
    <li><a href="#" name="tab2">Report Perspective</a></li>
    <li><a href="#" name="tab3">Report Creation</a></li>
    <li><a href="#" name="tab4">Misc.</a></li>    
    </ul>
</div>
<div id="content"> 
    <div id="tab1" style="height: 50%;"> 
  
        <cfform height="200">
        <cfgrid name="employeePerspective" format="html" striperows="yes" selectmode="browse" delete="yes" query="qEmployeeAssignments" height="200">
        <cfgridcolumn name="employeeName" header="Last Name" width="200"/>
        <cfgridcolumn name="reportName"  header="Report Name" width="200" />
        <cfgridcolumn name="reportDescrip" header="Report Description"  width="300" />
        </cfgrid>
        <cfinput type="button" name="newEmp" label="Add Employee" value="Add Employee">
      <cfinput type="button" name="AssignEmp" label="Delete Employee" value="Delete Employee">
        </cfform> </div>
    <div id="tab2" style="height: 60%;">
   <!--- <table bgcolor="CadetBlue" cellpadding="0" cellspacing="0">  
 <tr bgcolor="DarkCyan">  
     <td><b>Report Name</b></td>  
     <td><b>Employee Name</b></td>  
     <td><b>Report Description</b></td>    
    </tr>  
 <cfoutput query="qEmployeeAssignments">  
        <tr>  
            <td>#reportName#</td>  
            <td>#employeeName#</td>  
            <td>#reportDescrip#</td>  
        </tr>  
    </cfoutput>  
</table>--->  
	
        <cfform height="200">
        <cfgrid name="reportPerspective" format="html" striperows="yes" selectmode="browse" delete="yes" query="qEmployeeAssignments" height="200">
        <cfgridcolumn name="reportName" header="Report Name" width="200"/>
        <cfgridcolumn name="employeeName"  header="Employee Name" width="200" />
        <cfgridcolumn name="reportDescrip" header="Report Description"  width="300" />
        </cfgrid>
         <cfinput type="button" name="AssignEmp" label="Assign Employee" value="Assign Employee">
   	 	 <cfinput type="button" name="editEmp" label="Delete Assignment" value="Delete Assignment">
        </cfform>
     
      

	</div>
    
    <div id="tab3">
    
     <form name="addReportForm"  height="400" width="500" enctype="multipart/form-data" id="addReportForm">												<!--- Form Initialization --->
     <p> Report Name </p>
       <input type="Text" name="reportName"  id="reportName" size="20"	 />
	 <p> Report Path </p>	
     <input type="Text" name="reportPath" size="20" maxlength="35" label="Report Path"     							<!--- Report Path Field ---> 
     value="Report Path" required="yes" id="reportPath"> 
     
	 <!--- Report Category Dropdown box --->   
     <p> Category </p>
     <select name="category" label="Category" id="categoryBox" message="Select Category" 						        <!--- DB populated drop down box for reports. Required field. ---> 
     width="250" required="yes" tooltip="Select Category">  												  			<!--- Values are static for testing. CFSELECT to be populated by query--->
     <option value="Admin Tools">Admin Tools </option>							                                      
     <option value="Reports">Reports</option>
     <option value="Vendor Tools">Vendor Tools </option>
     <option value="Company Links">Company Links</option>
     <option value="Operations"> Operations</option>
	 </select>      
     <p> Report Description </p>    
      <textarea name="reportDescrip" size="20" maxlength="200" label="Report Description"
     value=" Enter Report Description" required="yes" id="reportDescrip" width="600" height="250">
     </textarea>
     <br />
     <br />
     <input type="button" name="createReport" label="Add New Report" value="Add New Report" id="createReport" />
     </form>
     
    
    </div>
    <div id="tab4">This is for misc. </div>
</div>

<script src="http://code.jquery.com/jquery-1.7.2.min.js"></script>
<script>
$(document).ready(function() {
    $("#content").find("[id^='tab']").hide(); // Hide all content
    $("#tabs li:first").attr("id","current"); // Activate the first tab
    $("#content #tab1").fadeIn(); // Show first tab's content
    
    $('#tabs a').click(function(e) {
        e.preventDefault();
        if ($(this).closest("li").attr("id") == "current"){ //detection for current tab
         return;       
        }
        else{             
          $("#content").find("[id^='tab']").hide(); // Hide all content
          $("#tabs li").attr("id",""); //Reset id's
          $(this).parent().attr("id","current"); // Activate this
          $('#' + $(this).attr('name')).fadeIn(); // Show content for the current tab
        }
    });
});
</script>


</body>
</html>
