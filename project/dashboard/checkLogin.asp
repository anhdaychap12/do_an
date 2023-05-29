<%

    If IsEmpty(session("user")) or session("Role") <> "admin" Then


        Response.redirect("../login.asp")
    End if
%>