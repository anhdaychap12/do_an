<!--#include file="connect.asp"-->
<%
    Dim ID_productDetail
    ID_productDetail = Request.QueryString("ID_productDetail")
    
    If not isnull(ID_productDetail) and ID_productDetail <> "" Then
        connDB.Open()
        set rs = connDB.execute("select * from ProductDetails where ProductDetailID = '"&ID_productDetail&"'")
        If not rs.EOF Then
            Dim curCarts, mycarts
            If IsEmpty(session("mycarts")) Then
                set mycarts = Server.CreateObject("Scripting.Dictionary")
                mycarts.add ID_productDetail, 1
                set Session("mycarts") = mycarts
                set mycarts = nothing
            Else
                set curCarts = session("mycarts")
                If curCarts.Exists(ID_productDetail) Then
                    dim value
                    value = Clng(curCarts.Item(ID_productDetail)) + 1
                    curCarts.Item(ID_productDetail) = value
                Else
                    curCarts.add ID_productDetail, 1
                End if
                set Session("mycarts") = curCarts
            End if
            Response.Write "Product has been added to your cart."
        Else
            Response.Write "Product is not exists, please try again."
        End if
        rs.Close()
        set rs = nothing
        connDB.Close()
    End if
%>