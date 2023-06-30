<!-- #include file="connect.asp" -->
<%
Dim str_Search, sql, resHTML
str_Search = Request.QueryString("str")
connDB.Open()
sql = "select Products.ProductID, Products.ProcductName, ImagePrducts.Image1, Categories.[Description], Products.Price, Categories.CategoryName"
sql = sql + " from Products inner join Categories on Categories.CategoryID = Products.CategoryID"
sql = sql + " inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID"
sql = sql + " where Products.ProcductName like '%"&str_Search&"%' or Categories.[Description] like '%"&str_Search&"%' "
resHTML = "<div class="&"search-box"&">"
set rs = connDB.execute(sql)
Do While not rs.EOF
    resHTML = resHTML & "<div class="&"item-box"&">"
    resHTML = resHTML & "<div class="&"item-img"&">"
    resHTML = resHTML & "<img src="&""""&rs("Image1")&""""&">"
    resHTML = resHTML & "</div>"
    resHTML = resHTML & "<div class="&"item-text"&">"
    resHTML = resHTML & "<a href="&""""&"/details.asp?productID="&rs("ProductID")&""""&">"
    resHTML = resHTML & "<h4>"&rs("ProcductName")&"</h4>"
    resHTML = resHTML & "</a>"
    resHTML = resHTML & "<p>$"&rs("Price")&"</p>"
    resHTML = resHTML & "</div>"
    resHTML = resHTML & "</div>"
    rs.MoveNext()
Loop
rs.Close()
set rs = nothing
connDB.Close()
resHTML = resHTML & "</div>"
%>


<%
    Response.Write resHTML
%>


