<!-- #include file="connect.asp" -->
<%
    id = Request.QueryString("id")
    Response.write(id)
    if (isnull(id) OR trim(id)="" OR isnull(Session(user)) OR trim(user)="") then
        Response.redirect("DBAccount.asp")
        Response.end
    end if
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.open()
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE from Accounts WHERE AccountID =?"
    cmdPrep.parameters.Append cmdPrep.createParameter("AccountID",3,1, , id)
    cmdPrep.execute

    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("DBAccount.asp")
    On Error Goto 0  

%>