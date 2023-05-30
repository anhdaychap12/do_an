<!-- #include file="connect.asp" -->
<%
    On Error Resume Next
    id = Request.QueryString("id")
    Response.write(id)
    if (isnull(id) OR trim(id)="" OR isnull(Session("user")) OR trim(Session("user"))="") then
        Response.redirect("DBCategory.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Categories WHERE CategoryID=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("CategoryID",3,1, ,id)

    cmdPrep.execute
    ' connDB.execute("DELETE FROM Categories WHERE CategoryID='"&CategoryID&"'")
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("DBCategory.asp")
    On Error Goto 0    

    
%>