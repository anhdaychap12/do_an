<!-- #include file="connect.asp" -->
<!--#include file="layout/header.asp"-->
<%
    ''1 Lấy id của khách khàng nếu là khách vãng lãi ->id=0
    Dim id_cus, sql, fullname, email, address, tinh, huyen, xa, so_nha, sdt, totalAmount, ShippingFree, ShippingFreeID, mycarts, cart_key, OrderID
    If not IsEmpty(session("user")) Then   
        connDB.Open()
        set rs = connDB.execute("select * from Accounts inner join Customers on Customers.AccountID = Accounts.AccountID  where Username = '"&session("user")&"'")
        If not rs.EOF Then
            id_cus = rs("CustomerID")
        End if
        rs.Close()
        set rs = nothing
        connDB.Close()
    Else
        id_cus = 0
    End if
    
    
    '2 Nếu khách hàng đã đăng nhập -> xuất ra thông tin khách hàng vào form checkout info
    If id_cus <> 0 Then
        connDB.Open()
        sql = "select * from Customers where CustomerID = '"&id_cus&"'"
        set rs =connDB.execute(sql)
        If not rs.EOF Then           
            fullname = rs("Fullname")
            address = Split(rs("Address"), ",")
            so_nha = address(0)
            xa = address(1)
            huyen = address(2)
            tinh = address(3)
            email = rs("Email")
            sdt = rs("PhoneNumber")
        End if
        rs.Close()
        set rs = nothing
        connDB.Close()
    Else
        fullname = ""
        so_nha = ""
        xa = ""
        huyen = ""
        tinh = ""
        email = ""
        sdt = ""
    End if


    'Nếu người dùng ấn nút Checkout Continute thì lưu dữ liệu vào sơ sở dữ liệu
    If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
        fullname = Request.Form("FullName")
        email = Request.Form("Email")
        tinh = Request.Form("Tinh")
        huyen = Request.Form("Huyen")
        xa = Request.Form("Xa")
        so_nha = Request.Form("AddressDetails")
        address = so_nha&","&xa&","&huyen&","&tinh
        sdt =Request.Form("Phone")
        totalAmount = Request.Form("totalAmount")
        ShippingFree = Request.Form("ShippingFree")
        

        'Lấy ID shippingfree
        connDB.Open()
        sql = "select * from ShippingFrees where ShippingName = '"&ShippingFree&"'"
        set rs = connDB.execute(sql)
        ShippingFreeID = rs("ShippingFreeID")
        rs.Close()
        set rs = nothing
        sql = ""
        ''Tạo đơn hàng mới
        
        sql = "insert into Orders(OrderDate, TotalAmount, CustomerID, ShippingFreeID, [Address], Email, Phone, Fullname)"
        sql = sql & "values(GETDATE(),'"&totalAmount&"', '"&id_cus&"', '"&ShippingFreeID&"', '"&address&"', '"&email&"', '"&sdt&"', '"&fullname&"')"
        Response.Write sql
        connDB.execute(sql)

        ''Lấy OrderID vừa tạo
        sql = "SELECT @@IDENTITY"
        OrderID = connDB.execute(sql).Fields(0).Value
        
        
        'Lưu thông tin vào bảng chi tiết đơn hàng
        If not IsEmpty(session("mycarts")) Then
            set mycarts = session("mycarts")
            for each cart_key in mycarts.keys
                sql = "insert into OrderDetails(OrderID, Quantity, ProductDetailID)"
                sql = sql & "values('"&OrderID&"', '"&mycarts(cart_key)&"', '"&cart_key&"')"
                connDB.execute(sql)
            next
        End if
        
        '' xóa dữ liệu giỏ hàng
        session.contents.remove("mycarts")
        Response.redirect("Confirm.asp?OrderID="&OrderID)
        connDB.Close()
        

    Else
        
    End if
%>
<body>
    <div class="main">
        <div class="checkout">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Checkout</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-8 m-12 c-12">
                        <div class="checkout-info">
                            <form method="post" action="">
                                <h4>Checkout info</h4>
                                <div class="row">
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="FullName"><p class="add-description">Full name:</p></label>
                                            <input type="text" id="FullName" name="FullName" placeholder="Vui lòng nhập họ và tên !" value="<%=fullname%>">
                                         </div>
                                    </div>
                                    
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Email"><p class="add-description">Email:</p></label>
                                            <input type="email" id="Email" name="Email" placeholder="cho123@gmail.com" value="<%=email%>">
                                         </div>
                                    </div>
                                    
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Tinh"><p class="add-description">Tỉnh/Thành Phố:</p></label>
                                            <input type="text" id="Tinh" name="Tinh" placeholder="Vui lòng nhập địa chỉ!" value="<%=tinh%>">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Quan"><p class="add-description">Quận/Huyện:</p></label>
                                            <input type="text" id="Quan" name="Huyen" placeholder="Vui lòng nhập địa chỉ!" value="<%=huyen%>">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Phuong"><p class="add-description">Phường/Xã:</p></label>
                                            <input type="text" id="Phuong" name="Xa" placeholder="Vui lòng nhập địa chỉ!" value="<%=xa%>">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="AddressDetails"><p class="add-description">Chi tiết địa chỉ:</p></label>
                                            <input type="text" id="AddressDetails" name="AddressDetails" placeholder="Vui lòng ghi rõ số nhà!" value="<%=so_nha%>">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Phone"><p class="add-description">Phone:</p></label>
                                            <input type="text" id="Phone" name="Phone" placeholder="Vui lòng nhập số điện thoại!" value="<%=sdt%>">
                                         </div>
                                    </div>
                                </div>
                                <input type="hidden" name="totalAmount" id="totalAmount">
                                <input type="hidden" name="ShippingFree" id="ShippingFree" value="Normal">
                                <button type="submit" class="checkout-btn">Continute Checkout</button>
                           </form>
                        </div>
                    </div>
                    <div class="col l-4 m-12 c-12">
                        <div class="checkout-cart-info">
                            <div class="checkout-cart-title">
                                <h4>Total Product</h4>
                                <span><%=so_luong_sp_cart%></span>
                            </div>
                            <div class="checkout-cart-content">
                                <%
                                    ''Hiển thị các sản phẩm trong giỏ hàng
                                    ''1. Kiểm tra xem có sản phẩm nào trong giỏ hàng không
                                    
                                    If not IsEmpty(session("mycarts")) Then
                                        set mycarts = session("mycarts")
                                        connDB.Open()
                                        for each cart_key in mycarts.keys
                                            set rs = connDB.execute("select Products.ProductID, Products.ProcductName, Sizes.Size, Colors.Color, ImagePrducts.Image1,  Products.Price from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID inner join ImagePrducts on ProductDetails.ProductID = ImagePrducts.ProductID where ProductDetailID = '"&cart_key&"'")
                                            If not rs.EOF Then
                                %>
                                    <div class="checkout-cart-item">
                                        <div class="checkout-cart-item-title">
                                            <h4><%=rs("ProcductName")%></h4>
                                            <p><%=rs("Size")%></p>
                                            <p><%=rs("Color")%></p>
                                        </div>
                                        <h4 class="so_luong">x<%=mycarts(cart_key)%></h4>
                                        <h4 class="gia_tien">$<%=rs("Price")%></h4>
                                    </div>
                                <%                                            
                                            End if
                                            rs.Close()
                                            set rs = nothing
                                        next
                                        connDB.Close()
                                    End if
                                %>
                                
                            </div>

                            <div class="shopping-cost-ship">
                                
                                <h4>Shipping:</h4>
                                <select class="select" id="Select_Free">
                                    <option >Normal</option>
                                    <option >Express</option>
                                </select>
                                <h4 id="ship">$5</h4>
                            </div>
                            <div class="checkout-cart-total">
                                <h4>Total:</h4>
                                <h4 id="tong_gia" name="tong_gia"></h4>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- #include file="layout/footer.asp" -->
    </div>
    <script src="main.js"></script>
    <script>
        function tong_gia_tien_noship() {
            var kq = 0;
            $('.checkout-cart-item').each(function () {
                // 'lay so luong cua moi san pham
                var str_so_luong = $(this).find('.so_luong').html();
                var so_luong = parseInt(str_so_luong.replace("x", ""));

                // lay gia tien cua moi san pham
                var str_gia_tien = $(this).find('.gia_tien').html();
                var gia_tien = parseInt(str_gia_tien.replace("$", ""));
                
                kq += so_luong * gia_tien;
            });

            return kq;
        }
        var ship, ship_name;
        $('#Select_Free').change(function () {
            ship_name = $(this).val();
            $('#ShippingFree').val(ship_name);
            if (ship_name == "Normal") {
                
                $('#ship').html('$'+'5')
                tong_gia_tien = tong_gia_tien_noship() + 5;
                $('#totalAmount').val(tong_gia_tien)
                $("#tong_gia").html('$'+tong_gia_tien)
            }
            else{
                
                $('#ship').html('$'+'10');
                tong_gia_tien = tong_gia_tien_noship() + 10;
                $('#totalAmount').val(tong_gia_tien)
                $("#tong_gia").html('$'+tong_gia_tien)
            }
        });

        var str = $('#ship').html();
        var rs_str = str.split("$");
        var tong_gia_tien = tong_gia_tien_noship() + parseInt(rs_str[1])
        $('#totalAmount').val(tong_gia_tien)
        
        $("#tong_gia").html('$'+tong_gia_tien)
    </script>
</body>