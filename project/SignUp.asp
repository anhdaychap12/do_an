<%
    ''1. Khi người dùng nhập đầy đủ thông tin vào form đăng kí -> gán giá trị của của thẻ input vào các biến tương ứng
    ''2. Tạo mới thông tin tài khoản vào bảng customer (insert vào bảng customer)
    ''3. Lấy id của khách hàng vừa tạo (dùng 2 câu lệnh ở dưới để lấy id cus vừa mới tạo) (không hiểu thì nghiên cứu file checkout nhé !)
        ' sql = "SELECT @@IDENTITY"
        ' OrderID = connDB.execute(sql).Fields(0).Value
    ''4. Tạo mới tài khoản vào bảng accounts (insert vào bảng account)
%>