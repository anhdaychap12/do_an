<!-- #include file="connect.asp" -->
<%
Dim str_Search, sql, resHTML
str_Search = "skirt"
connDB.Open()
sql = "select Products.ProductID, Products.ProcductName, ImagePrducts.Image1, Categories.[Description], Products.Price, Categories.CategoryName"
sql = sql + " from Products inner join Categories on Categories.CategoryID = Products.CategoryID"
sql = sql + " inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID"
sql = sql + " where Products.ProcductName like '%"&str_Search&"%' or Categories.[Description] like '%"&str_Search&"%' "
resHTML = "<div>"
set rs = connDB.execute(sql)
Do While not rs.EOF
    resHTML = resHTML & "<div>"
    resHTML = resHTML & "<h3>" & rs("ProcductName") & "</h3>"
    resHTML = resHTML & "<p>" & rs("Description") & "</p>"
    resHTML = resHTML & "<p>Price: $" & rs("Price") & "</p>"
    resHTML = resHTML & "<img src='" & rs("Image1") & "' alt='" & rs("ProcductName") & "' />"
    resHTML = resHTML & "</div>"
    rs.MoveNext()
Loop
rs.Close()
set rs = nothing
connDB.Close()
resHTML = resHTML & "</div>"
%>
<!-- #include file="layout/header.asp" -->
<body>
<%
    Response.Write resHTML
%>
</body>
<!-- #include file="layout/footer.asp" -->
