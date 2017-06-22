<%
	Function GenerateTableFromRecordset(Recordset)
			
	'first of all determine whether there are any records 
		If Recordset.EOF Then 
			Response.Write("No records returned.") 
			Exit Function
		End if					

		Response.Write Recordset.Fields.Count & " fields" & br
		Response.Write "<table class='demo'>"
		Response.Write "<thead>"
		Response.Write "<tr>"
		For Each oField In Recordset.Fields 
		   Response.Write  "<th>" &  oField.Name  &  "</th>"
		Next 			

		'if there are records then loop through the fields 
		Do While NOT Recordset.Eof   
			Response.Write "<tr>"
			
			WriteRecord Recordset.Fields
			
			Response.Write "</tr>"
			Response.Write  chr(13)+chr(10)
			Recordset.MoveNext     
		Loop
		
		Response.Write "</tr>"
		Response.Write "</thead>"
		Response.Write "</table>"
		
	End Function
	
	Function WriteRecord (Fields)
		Dim tdo, tdc
		tdo = "<td>"
		tdc = "</td>"
	
		For Each oField In Fields 
			Response.Write tdo  &  oField.Value  & tdc
			Response.Write  chr(13)+chr(10)
		Next 
	
	End Function

Function IsEmpty (str)
	If NOT IsNull(str)  AND len(str)>0  then
		isEmpty = False
		Exit Function
	End if
	
	IsEmpty = true
	
End Function
	
	
Function doStoredProc(StProcName, Param1, Value1, Param2, Value2)

	Dim Connection
	DIM cmd
	DIM RS
	

	Set Connection = Server.CreateObject("ADODB.Connection")	
	SET cmd = Server.CreateObject("ADODB.Command")
	
	Connection.Open connectionString
	
	SET cmd.ActiveConnection = Connection
	
	SET RS = Server.CreateObject("ADODB.recordset")
	
	'Response.Write StProcName
	
	'Prepare the stored procedure	
	cmd.CommandText = StProcName
	cmd.CommandType = 4  'adCmdStoredProc
	
	If Not IsEmpty (Param1) Then
		cmd.Parameters ("@" & Param1) = Value1
	End if
	
	If Not IsEmpty (Param2) Then
		cmd.Parameters ("@" & Param2) = Value2
	End if
	
	'Execute the stored procedure
	SET RS = cmd.Execute
	
	'Response.Write "Count:" & RS.RecordCount
	
	If (not RS.EOF) THEN	
		'Response.Write "Field 1: " & rs(0)
	Else
		Response.Write "EOF"
	End if
	
	Dim jsData 	
	jsData = JSONData (RS, "") 
	Response.Write  jsData & (chr(13)+chr(10))
	
	
	'dispose your objects
	RS.Close
	SET RS = Nothing
	
	SET cmd = Nothing
	
	Connection.Close
	SET Connection = Nothing
End Function

	
Function readTable(SQL)

	'Dim connectionString
	Dim Connection
	Dim Recordset
	Dim oField
	
	
	
	Response.Write connectionString & br
	
	'create an instance of the ADO connection and recordset objects
	Set Connection = Server.CreateObject("ADODB.Connection")
	Set Recordset = Server.CreateObject("ADODB.Recordset")

	'open the connection to the database
	Connection.Open connectionString
	Recordset.Open SQL,Connection

	Dim jsData 	
	jsData = JSONData (Recordset, "") 

	Response.Write (chr(13)+chr(10))
	Response.Write "<script type='text/babel'> var data = " & jsData & ";"  

	Response.Write "</script>"
	
	'close the connection and recordset objects to free up resources
	Recordset.Close
	Set Recordset=nothing
	Connection.Close
	Set Connection=nothing
	
	readTable = recID
End Function


%>
