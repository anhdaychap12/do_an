<%
    If Session("Role") <> "customer" Then
        Response.redirect("login.asp")
    End if
%>