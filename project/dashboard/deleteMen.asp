<!-- #include file="connect.asp" -->
<%
    On Error Resume Next
    id = Request.QueryString("id")
    Response.write(id)
    if (isnull(id) OR trim(id)="" OR isnull(Session("user")) OR trim(Session("user"))="") then
        Response.redirect("DBMen.asp")
        Response.End
    end if

    Set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    
    ' Xóa các bản ghi trong bảng "ProductDetails" liên quan đến ProductID
    sql = "DELETE FROM ProductDetails WHERE ProductID = '"&id&"'" 
    connDB.Execute(sql)

    ' Xóa bản ghi trong bảng "Products"
    sql = "DELETE FROM Products WHERE ProductID = '"&id&"'"
    connDB.Execute(sql)

    connDB.Close()
    If Err.Number = 0 Then
    Session("Success") = "Deleted"    
    Else
        Session("Error") = Err.Description
    End If
    Response.Redirect("DBMen.asp")
    On Error Goto 0    

    
%>