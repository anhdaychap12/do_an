<%
    Dim ID_productDetail
    ID_productDetail = Request.QueryString("ID_productDetail")
    Dim mycarts
    If not IsEmpty(Session("mycarts")) Then
        set mycarts = Session("mycarts")
        mycarts.remove(ID_productDetail)
        If mycarts.Count > 0 Then
            set session("mycarts") = mycarts
        Else
            session.contents.remove("mycarts")
        End if
        Response.redirect("shopping.asp")
    End if
%>