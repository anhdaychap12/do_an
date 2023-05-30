<!-- #include file="connect.asp" -->
<!--#include file="layout/header.asp"-->
<%
    ''1 Kiểm tra xem khách hàng đã đăng nhập hay chưa
    Dim id_cus
    If not IsEmpty(session("user")) Then
    ''1.1 Khách hàng đã đăng nhập->Lấy thông tin khách hàng để làm thông tin nhận hàng
        ' true
        ''a lấy id của khách hàng
        connDB.Open()
        set rs = connDB.execute("select * from Accounts where Username = '"&session("user")&"'")
        If not rs.EOF Then
            id_cus = rs("AccountID")
        End if
    Else
    ''1.2 Khách hàng chưa đăng nhập->yêu cầu khách hàng nhập thông tin chi tiết địa chỉ, sdt, ..
        ' false
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
                            <form method="post">
                                <h4>Checkout info</h4>
                                <div class="row">
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="FullName"><p class="add-description">Full name:</p></label>
                                            <input type="text" id="FullName" name="FullName" placeholder="Please fill fullname!">
                                         </div>
                                    </div>
                                    
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Email"><p class="add-description">Email:</p></label>
                                            <input type="email" id="Email" name="Email" placeholder="Please fill email">
                                         </div>
                                    </div>
                                    
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Tinh"><p class="add-description">Province/City:</p></label>
                                            <input type="text" id="Tinh" name="Tinh" placeholder="Please fill address!">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Quan"><p class="add-description">District/County:</p></label>
                                            <input type="text" id="Quan" name="Quan" placeholder="Please fill address!">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Phuong"><p class="add-description">Ward/Commune:</p></label>
                                            <input type="text" id="Phuong" name="Phuong" placeholder="Please fill address!">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="AddressDetails"><p class="add-description">Detail address:</p></label>
                                            <input type="text" id="AddressDetails" name="AddressDetails" placeholder="Please fill house number!">
                                         </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <div class="check-input">
                                            <label for="Phone"><p class="add-description">Phone:</p></label>
                                            <input type="text" id="Phone" name="Phone" placeholder="Please fill phonenumber!">
                                         </div>
                                    </div>
                                </div>
                                <a href="#" class="checkout-btn">Continute Checkout</a>
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
                                    Dim mycarts, cart_key
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
                                <select class="select">
                                    <option value="1">Express</option>
                                    <option value="2">Normal</option>
                                </select>
                            </div>
                            <div class="checkout-cart-total">
                                <h4>Total:</h4>
                                <h4 id="tong_gia">$400</h4>
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
        var ship = $('#ship').html()
        var tong_gia_tien = tong_gia_tien_noship() - parseInt(ship.replace("-$", ""))
        console.log(tong_gia_tien);
        $('#tong_gia').html("$" + tong_gia_tien)
        
    </script>
</body>