<%@ Language=VBScript %>
<!--#include  file="rs.asp" -->
<!--#include  file="Util.asp" -->
<%
Response.CodePage = 65001 
Response.CharSet = "utf-8"
%>
<%

	Dim connectionString	
	connectionString = "my connection string" 'replace with your connection string
%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
<style>

	body {padding-top:30px;}
	h3 {color:blue;}
	.demo {
		border:1px solid #C0C0C0;
		border-collapse:collapse;
		padding:2px;
	}
	.demo th {
		border:1px solid #C0C0C0;
		padding:4px;
		background:#ECF0F4;
	}
	.demo td {
		border:1px solid #C0C0C0;
		padding:1px;
	}
	/*tr:nth-child(even) {background: #ECE4ED}*/
	
	#page-numbers {
		list-style: none;
		display: flex;
	}

#page-numbers > li {
  margin-right: 0.3em;
  color: blue;
  user-select: none;
  cursor: pointer;
}
.pagination {
    display: inline-block;
}

.pagination a {
    color: black;
    float: left;
    padding: 4px 8px;
    text-decoration: none;
}

.pagination a.active {
    background-color: #4CAF50;
    color: white;
    border-radius: 5px;
}

.pagination a:hover:not(.active) {
    background-color: #ddd;
    border-radius: 5px;
}

	input {margin:10px;}
	.blue {color:blue;}
	
</style>
<script src="https://unpkg.com/react@latest/dist/react.js"></script>
<script src="https://unpkg.com/react-dom@latest/dist/react-dom.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	
<script type='text/javascript' src="js/cookies.js"></script>


<script type='text/javascript'>
	function fnSubmit(tbl){
		
	  var form = document.getElementById("form1");
      form.method = "get";

	  form.tbl.value = tbl;
      form.submit();
      return false;
	}	
	
	function fnSubmitSql(sql){
	  var form = document.getElementById("form1");
      form.method = "get";

	  form.sql.value = sql;
      form.submit();
      return false;
	}	
	//called from the dynamic link
	function fnSubmitTable(tbl){
		
	  var form = document.getElementById("form1");
      form.method = "get";

	  form.tbl.value = '';
	  form.txt.value='';
	  form.sql.value=  "table"
	  form.cookieTbl.value = tbl;
    
	  form.submit();
      return false;
	}	
	
	function fnSearch(){
		var form = document.getElementById("form1");
		var txt = form.txt.value;
		setCookie2("test3",txt, 5);					 
		return true;
	}
	
	var data = {};
	

</script>


<%
Dim cookieTables
Dim cookArr 
Dim cookieName 
cookieName ="test3"
cookieTables =Request.Cookies(cookieName)
cookArr = Split(cookieTables, ",")

%>
</head>

  <body>


  <div id="root"></div>
 
 <div class="container-fluid">
	 <div class="row">
		<div class="col-md-2">
		 <div class="form-group bg-info">
				<ul class="nav nav-pills nav-stacked">				
					<li><a href='#' onclick="return fnSubmitSql('MyPol')">My Policies</a> 
					<%
						Dim link
						For each cookTable in cookArr
							link = "<li><a href='#' onclick='return fnSubmitTable(" & chr(34) & cookTable & chr(34) & ")'>" & cookTable & "</a></li>"				
							Response.Write link				
						Next
					%>
				</ul>	
				<a href='#'    onclick="return fnSubmit('')">Clear</a> <br>					
		</div>
				<form id="form1" action="" method="get"  onsubmit='return fnSearch()'>	
					<input type='text' name='txt'>
					<!-- <input type='submit'  value='search'>-->
					<input type='hidden' name='tbl'>
					<input type='hidden' name='sql'>
					<input type='hidden' name='cookieTbl'>					
	
				</form>
		
		</div>
		<div class="col-md-10">
			<div>
				<%
					If NOT IsNull(Request.QueryString("tbl"))  AND len(Request.QueryString("tbl"))>0  then	
						findWhichTable
					End if  
				%>
			</div>
			<div id="app">
			
			</div>	
		</div>		
	</div>		
</div>
 


<%

Dim br  
br =   "<BR>"
%>
<hr>



<div class="container">
	<div id="app"></div>	
	<div id="details"></div>
		
</div>




<%

Dim tblType 
	

 
  
Dim sql, sqlType
Dim tableName, sort
sort =""

	
	'//READ a new table parameter
	If NOT IsNull(Request.QueryString("txt"))  AND len(Request.QueryString("txt"))>0  then
		tableName =Request.QueryString("txt")
		sort= "DESC"
		sql = "SELECT TOP 100 * FROM " & tableName & " ORDER BY ID " & sort
		Response.Write sql & br
		Response.Write "<h3>" & tableName & "</h3>"
		readTable sql ', tableName, false
	End if 
		
	  
	  '//Coming from the link
	If NOT IsNull(Request.QueryString("sql"))  AND len(Request.QueryString("sql"))>0  then
		 sqlType =  Request.QueryString("sql")  
		  Select Case sqlType
			Case "MyPol"
				sql = myPolicy
			case "table"		
				tableName = Request.QueryString("cookieTbl")				
				sql = "SELECT TOP 100 * FROM " & tableName & " ORDER BY ID DESC" 				
		  End Select	     
		 
		 'Response.Write sql & br	 
		 readTable sql

	End if	 

Function FindWhichTable ()
     tblType =  Request.QueryString("tbl")  	
	 
	 sql = "SELECT TOP 50 * FROM " & tableName & " ORDER BY ID " & sort
	 
	 Response.Write sql & br
	 Response.Write "<h3> table:" & tableName & "</h3>"
	 readTable sql

End Function
	
%>
<script>
	var tableName = '<%= tableName %>';
</script>
<script type='text/babel' src='js/table.js'></script>

</body>
		


