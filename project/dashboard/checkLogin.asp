<%
    If isnull(session("user")) and trim(session("user")) = "" Then
        Response.redirect("../login.asp")
    End if
%>