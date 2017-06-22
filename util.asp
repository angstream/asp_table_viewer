<%

	Function replaceValue(val)
		dim result
		
		if not isNull(val) Then												
			result = Replace(val, Chr(10), "")			
			result = Replace(result, Chr(13), "")
			'escape double quotes
			result = Replace(result, """", "\""")
		else
			result =""
		end if	
		replaceValue = result
	End Function
	
'https://www.deepcodeonline.com/how-to-convert-adodb-recordset-into-json/
	Function JSONData(ByVal rs, ByVal labelName)'Converts recordset to JSON data
		Dim data, columnCount, colIndex, rowIndex, rowCount, rsArray
		If Not rs.EOF Then
		
			if not labelName ="" Then
				data = labelName & ":"
			End if	
			data = data & "["	
			rsArray = rs.GetRows() 		
			rowIndex = 0
		End If
		
		If Not IsArray(rsArray) Then		
			JSONData = ""
			Exit Function
		End if
			' Retrieve the total no. of rows (second dimension of the array)
			rowCount = ubound(rsArray,2)
			'Retrive the total no. of columns/fields (first dimension of the array)
			columnCount = ubound(rsArray,1)
			'Loop through the array holding the resultset and display records 
			'Loop through rows as the outer loop
			For rowIndex = 0 to rowCount
				data = data & "{"
			   'Loop through columns/fields as inner loop
			   For colIndex = 0 to columnCount				
					
					data = data &  """" & rs.Fields(colIndex).Name & """" & ":""" & replaceValue(rsArray(colIndex,rowIndex)) & """"
					
					If colIndex < columnCount Then
						data = data & ","
					End If
			   Next 'Move on to next column/field is there is one
			   data = data & "}"
			   If rowIndex < rowCount Then
					data = data & ","
			   End If
			Next 'Move on to next row if there is one
						
			data = data & "]"			
			'rs.Close
		JSONData = data
	End Function

%>
