<%
    If Session("Role") = "admin" Then
        Response.redirect("login.asp")
    End if
%>