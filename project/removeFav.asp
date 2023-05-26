<%
    Dim ID_product
    ID_product = Request.QueryString("ID_product")
    Dim mycarts
    If not IsEmpty(Session("fav")) Then
        set my_fav = Session("fav")
        
        my_fav.remove(ID_product)
        If my_fav.Count > 0 Then
            set session("fav") = my_fav
        Else
            session.contents.remove("fav")
        End if
        Response.redirect("favorite.asp")
    End if

%>