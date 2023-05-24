<!--#include file="connect.asp"-->
<%
    ''1.lấy id sản phẩm từ url
    Dim ID_product, cur_fav, my_fav
    ID_product = Request.QueryString("ID_product")

    If not isnull(ID_product) and trim(ID_product) <> "" Then
        connDB.Open()
        set rs = connDB.execute("select * from Products where ProductID = '"&ID_product&"'")
        ''2.kiểm tra ID_product có tồn tại hay không
        If not rs.EOF Then
            dim name
            name = rs("ProcductName")
            ''2.1Nếu ID tồn tại->Kiểm tra danh sách yêu thích có tồn tại hay không
            If not IsEmpty(session("fav")) Then
                ' true
                set cur_fav = session("fav")
                session("sl_fav") = cur_fav.Count
                ''2.1.1Dsyt tồn tại -> kiểm tra xem sản phẩm đó đã có trong danh sách yt chưa
                If cur_fav.Exists(ID_product) Then
                    ' true
                    ''2.1.1.1 Sản phẩm đã có trong dsyt->xóa khỏi danh sách yt
                    
                    Response.ContentType = "application/json"
                    Response.Write "{""messenger"": ""Sản phẩm đã có trong danh sách yêu thích.""}"
                Else
                    ' false
                    ''2.1.1.2 Sản phẩm chưa có trong danh sách yt->thêm vào dsyt
                    
                    cur_fav.add ID_product, name
                    session("sl_fav") = Clng(session("sl_fav")) + 1
                    Response.ContentType = "application/json"
                    Response.Write "{""messenger"": ""Thêm sản phẩm vào danh sách yêu thích.""}"
                End if
                set session("fav") = cur_fav
            Else
                ''2.1.2Dsyt không tồn tại ->Tạo mới danh sách yt
                set my_fav = Server.CreateObject("Scripting.Dictionary")
                
                my_fav.add ID_product, name
                set session("fav") = my_fav
                set my_fav = nothing
                Response.ContentType = "application/json"
                Response.Write "{""messenger"": ""Thêm sản phẩm vào danh sách yêu thích.""}"
                ' false
            End if
            
            
        Else
            ' 2.2 Nếu ID không tồ tại -> trả về thông báo là sản phẩm không tồn tại
            Response.Write "Sản phẩm không tồn tại, vui lòng chọn sản phẩm khác"
        End if
        rs.Close()
        connDB.Close()
    End if
%>