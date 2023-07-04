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
    sql = "DELETE from Accounts WHERE AccountID = '"&id&"'" 
    connDB.Execute(sql)

    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("DBAccount.asp")
    

%>