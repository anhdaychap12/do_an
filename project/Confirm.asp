<!-- #include file="connect.asp" -->
<!--#include file="layout/header.asp"-->
<%
    ''Lấy OrderID
    Dim OrderID, nameCus, orderDate, orderAddress, subTotal, ship, ship_name
    OrderID = Request.QueryString("OrderID")
    ''Lấy ra tên khách hàng, Ngầy đặt hàng, địa chỉ giao hàng, Tổng hóa đơn, phí ship
    connDB.open()
    set rs = connDB.execute("select * from Orders inner join ShippingFrees on Orders.ShippingFreeID = ShippingFrees.ShippingFreeID where OrderID = '"&OrderID&"'")
    If not rs.EOF Then
        nameCus = rs("Fullname")
        orderDate = rs("OrderDate")
        orderAddress = rs("Address")
        subTotal = rs("TotalAmount")
        ship_name = rs("ShippingName")
        ship = rs("Price")
    Else
        Response.Write "Mã hóa đơn không chính xác!"
    End if
    rs.Close()
    set rs = nothing
    connDB.Close()

    ''Lấy danh sách id sản phẩm và số lượng tương ứng trong hóa đơn
    Dim dictProc, x1, y1, sql
    set dictProc = CreateObject("Scripting.Dictionary")
    connDB.Open()
    set rs = connDB.execute("select * from OrderDetails where OrderID = '"&OrderID&"'")
    Do While not rs.EOF
        x1 = rs("ProductDetailID")
        y1 = rs("Quantity")
        dictProc.add x1, y1
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing
    connDB.Close()

    

%>
<body>
    <div class="main">
        <div class="confirm">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Your order confirmed!</span></h2>
                        <p>Your order has been confirmed and will be shipping within next two days.</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-12 m-12 c-12">
                        <div class="confirm-content">
                            <div class="row">
                                <div class="col l-3 m-6 c-12">
                                    <div class="confirm-item">
                                        <p>Name:</p>
                                        <h4><%=nameCus%></h4>
                                    </div>
                                </div>
                                <div class="col l-3 m-6 c-12">
                                    <div class="confirm-item">
                                        <p>Order ID:</p>
                                        <h4><%=OrderID%></h4>
                                    </div>
                                </div>
                                <div class="col l-3 m-6 c-12">
                                    <div class="confirm-item">
                                        <p>Order date:</p>
                                        <h4><%=orderDate%></h4>
                                    </div>
                                </div>
                                <div class="col l-3 m-6 c-12">
                                    <div class="confirm-item">
                                        <p>Shipping Address:</p>
                                        <h4><%=orderAddress%></h4>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col l-12 m-12 c-12">
                            <%
                            ''Hiển thị danh sách sản phẩm
                            connDB.Open()
                            for each key in dictProc.keys
                                sql = "select Products.ProductID, Products.ProcductName, Sizes.Size, Colors.Color, ImagePrducts.Image1,  Products.Price"
                                sql = sql + " from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID"
                                sql = sql +" inner join Sizes on ProductDetails.SizeID = Sizes.SizeID "
                                sql = sql +"inner join Colors on Colors.ColorID = ProductDetails.ColorID"
                                sql = sql+" inner join ImagePrducts on ProductDetails.ProductID = ImagePrducts.ProductID"
                                sql = sql+" where ProductDetailID = '"&key&"'"
                                set rs = connDB.execute(sql) 
                                If not rs.EOF Then
                            %>
                        <div class="confirm-cart">
                            <div class="confirm-cart-item">
                                <img src="<%=rs("Image1")%>" alt="">
                                <div class="confirm-text">
                                    <h4><%=rs("ProcductName")%></h4>
                                    <p>Quanity: <span class="quan"><%=dictProc(key)%></span></p>
                                    <p>Size: <span><%=rs("Size")%></span></p>
                                    <p>Color: <span><%=rs("Color")%></span></p>
                                </div>
                            </div>
                            <div class="confirm-cart-item">
                                <p >Price: <span class="price">$<%=rs("Price")%></span></p>
                            </div>
                        </div>

                            <%
                                End if
                                rs.Close()
                                set rs = nothing
                            next
                            connDB.Close()
                            %>
                        
                    </div>
                    <div class="col l-12 m-12 c-12">
                        <div class="confirm-cart-cost">
                            <div class="confirm-cart-item-price">
                                <p>Subtotal:</p>
                                <h4><span id="rs_priceTotal"></span>$</h4>
                            </div>
                            <div class="confirm-cart-item-price">
                                <p>Shipping fee:</p>
                                <h4>+ <%=ship%>$</h4>
                            </div>
                            <div class="confirm-cart-item-price">
                                <p>Discount:</p>
                                <h4>- 0$</h4>
                            </div>
                            <div class="confirm-cart-item-price">
                                <h4>Total:</h4>
                                <h3><%=subTotal%>$</h3>
                            </div>
                        </div>
                    </div>
                    <div class="col l-12 m-12 c-12">
                        <div class="cart-item-footer">
                            <p>We will be sending a shipping confirmmation email when the items shipped successfully.</p>
                            <h4>Thank you for shopping with us!</h4>
                            <h2>Esser Team</h2>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- #include file="layout/footer.asp" -->
    </div>
    <script src="main.js"></script>
    <script>
        function priceTotal() {
            var kq = 0;
            $('.confirm-cart').each(function () {
                var str_price = $(this).find('.price').html();
                var quan =parseInt($(this).find('.quan').html()) ;
                var price = parseInt(str_price.replace("$", ""));
                kq += price * quan;
            });
            return kq;
        }
        $('#rs_priceTotal').html(priceTotal());
        
    </script>
</body>    