<!-- #include file="connect.asp" -->
<%
    On Error Resume Next
    Sub handleError(message)
        Session("Error") = message
        'send an email to the admin
        'Write the error message in an application error log file
    End Sub

    Dim ProductName, Description, PromotionID, Price, sql, id_Pro
    ProductName = Request.QueryString("ProductName")
    Description = Request.QueryString("Description")
    PromotionID = Request.QueryString("PromotionID")
    Price = Request.QueryString("Price")
    CateID = Request.QueryString("CateID")

    connDB.Open()
    If cint(PromotionID) <> 0 Then
        ' true
        sql = "insert into Products(ProcductName, CategoryID, Price, [Description], PromotionID) values"
        sql = sql & " ('"&ProductName&"','"&CateID&"','"&Price&"','"&Description&"','"&PromotionID&"')"
    Else
        ' false
        sql = "insert into Products(ProcductName, CategoryID, Price, [Description]) values"
        sql = sql & " ('"&ProductName&"','"&CateID&"','"&Price&"','"&Description&"')"
    End if
    connDB.execute(sql)
    If Err.Number = 0 Then
        sql = "SELECT @@IDENTITY"
        id_Pro = connDB.execute(sql).Fields(0).Value
        Session("success") = "New Product added!"
        Response.ContentType = "application/json"
        Response.Write "{""id_Pro"": """&id_Pro&""",""message"":"""&session("success")&"""}"
    Else
        handleError(Err.Description)
        Response.ContentType = "application/json"
        Response.Write "{""message"":"""&session("Error")&"""}"
    End if
    connDB.Close()

%>