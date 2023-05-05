<%
    Dim mycarts
    If IsEmpty(session("mycarts")) Then
        Response.Write "gio hang rong"
    Else
        set mycarts = session("mycarts")
        dim key
        for each key in mycarts.keys
            Response.Write key&": "&mycarts(key)&"<br>"
        next
        Response.Write mycarts.Count
    End if   
%>

