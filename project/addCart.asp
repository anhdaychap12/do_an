<!--#include file="connect.asp"-->
<%
    Dim ID_productDetail
    ID_productDetail = Request.QueryString("ID_productDetail")
    
    If not isnull(ID_productDetail) and ID_productDetail <> "" Then
        connDB.Open()
        set rs = connDB.execute("select * from ProductDetails where ProductDetailID = '"&ID_productDetail&"'")
        If not rs.EOF Then
            Dim curCarts, mycarts
            session("totalProduct") = Clng(session("totalProduct")) + 1
            If IsEmpty(session("mycarts")) Then
                set mycarts = Server.CreateObject("Scripting.Dictionary")
                mycarts.add ID_productDetail, 1
                set Session("mycarts") = mycarts
                set mycarts = nothing
                Response.ContentType = "application/json"
                Response.Write "{""messenger"": ""Product has been added to your cart."", ""totalProduct"": ""1""}"
            Else
                set curCarts = session("mycarts")
                If curCarts.Exists(ID_productDetail) Then
                    dim value
                    value = Clng(curCarts.Item(ID_productDetail)) + 1
                    curCarts.Item(ID_productDetail) = value
                Else
                    curCarts.add ID_productDetail, 1
                End if
                ''tính lại tổng sl sp
                dim quan, total_quan
                total_quan = Clng(0)
                for each quan in curCarts.keys
                    total_quan = total_quan + Clng(curCarts(quan))
                Next
                Response.ContentType = "application/json"
                Response.Write "{""messenger"": ""Product has been added to your cart."", ""totalProduct"": """&total_quan&"""}"
                set Session("mycarts") = curCarts
            End if
            
        Else
            Response.ContentType = "application/json"
            Response.Write "{""messenger"": ""Product is not exists your cart.""}"
        End if
        rs.Close()
        set rs = nothing
        connDB.Close()
    End if
%>