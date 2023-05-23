<%
    Dim ID_product, quantity, mycarts, new_total_quantity
    ID_product = Request.QueryString("ID_product")
    quantity = Request.QueryString("quantity")
    new_total_quantity = 0

    If not IsEmpty(session("mycarts")) Then
        set mycarts = session("mycarts")
        mycarts(ID_product) = quantity
        dim key
        
        for each key in mycarts.keys
            new_total_quantity = new_total_quantity + Clng(mycarts(key))
        next
        set session("mycarts") = mycarts
        Response.ContentType = "application/json"
        Response.Write "{""total_quantity"": """&new_total_quantity&"""}"
        session("totalProduct") = new_total_quantity
    End if
%>