<!-- #include file="connect.asp" -->
<%
    On Error Resume Next
    id = Request.QueryString("id")
    Response.write(id)
    if (isnull(id) OR trim(id)="" OR isnull(Session("user")) OR trim(Session("user"))="") then
        Response.redirect("DBDiscount.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.CommandText = "DELETE FROM Promotions WHERE PromotionID=?"
    cmdPrep.parameters.Append cmdPrep.createParameter("PromotionID",3,1, ,id)

    cmdPrep.execute
    ' connDB.execute("DELETE FROM Promotions WHERE PromotionID='"&PromotionID&"'")
    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("DBDiscount.asp")
    On Error Goto 0    

    
%>