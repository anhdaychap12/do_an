<!-- #include file="connect.asp" -->
<%
    Dim ColorID, ProductID, listSize, sql, k, v, rs, i, rsHTML, quan

    ColorID = Request.QueryString("ColorID")
    ProductID = Request.QueryString("ProductID")
    ''Lay danh sach size
    set listSize = CreateObject("Scripting.Dictionary")

    connDB.Open()
    sql = "select * from Sizes"
    set rs = connDB.execute(sql)
    Do While not rs.EOF
        k = rs("SizeID")
        v = rs("Size")
        listSize.add k, v
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing

    rsHTML = "<div class="&""""&"row no-gutters"&""""&">"

    for each i in listSize.keys
        sql = "select ProductDetails.Quantity from ProductDetails "
        sql = sql & " inner join Colors on ProductDetails.ColorID = Colors.ColorID"
        sql = sql & " inner join Sizes on ProductDetails.SizeID = Sizes.SizeID"
        sql = sql & " inner join Products on ProductDetails.ProductID = Products.ProductID"
        sql = sql & " where Colors.ColorID = '"&ColorID&"' and Sizes.SizeID = '"&i&"' and Products.ProductID = '"&ProductID&"'"
        set rs = connDB.execute(sql)
        If not rs.EOF Then
            quan = Cint(rs("Quantity"))
        Else
            quan = 0
        End if
        rs.Close()
        set rs = nothing
        ' Response.Write listSize(i) &": "&quan&"<br>"
        
        rsHTML = rsHTML & "<div class="&""""&"col l-1 m-3 c-4"&""""&">"
        rsHTML = rsHTML & "<div class="&"add-input"&">"
        rsHTML = rsHTML & "<p class="&"add-description"&">Size:</p>"
        rsHTML = rsHTML & "<a href="&"#"&" class="&"size-item"&">"&listSize(i)&"</a>"
        rsHTML = rsHTML & "</div>"
        rsHTML = rsHTML & "</div>"
        rsHTML = rsHTML & "<div class="&""""&"col l-11 m-9 c-8"&""""&">"
        rsHTML = rsHTML & "<div class="&"add-input"&">"
        rsHTML = rsHTML & "<label for="&"Quantity"&i&"><p class="&"add-description"&">Quantity:</p></label>"
        rsHTML = rsHTML & "<input type="&"number"&" min="&"0"&" id="&"Quantity"&i&" name="&"Quantity"&" placeholder="&"Quantity"&" value="&quan&">"
        rsHTML = rsHTML & "</div>"
        rsHTML = rsHTML & "</div>"

        
    Next

    rsHTML = rsHTML & "</div>"
    connDB.Close

    Response.Write rsHTML
%>