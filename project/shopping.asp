<!--#include file="connect.asp"-->
<!-- #include file="checkLogin.asp" -->

<%
    ' khai bao bien
    Dim totalPrice, check_cart, mycarts, totalProduct
    totalPrice = 0
    totalProduct = 0
    If IsEmpty(session("mycarts")) Then
        check_cart = "No products in your cart!"
    Else
        check_cart = ""
        set mycarts = session("mycarts")  
    End if

%>

<!--#include file="layout/header.asp"-->
<body>
    <div class="main">
        <div class="shopping">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>My Cart</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                        <p id="test"></p>
                    </div>
                </div>
                <h3><%=check_cart%></h3>
                <%
                    If check_cart = "" Then                   
                %>
                
                        <div class="row">
                            <div class="col l-9 m-12 c-12">
                                <div class="row">
                                    <div class="col l-12 m-12 c-12">
                                        <div class="shopping-cart">
                                            <a href="" class="shopping-cart-exit"><i class="fa-solid fa-arrow-left"></i></a>
                                            <div class="shopping-cart-item">
                                                <h4>My product</h4>
                                            </div>
                                            <div class="shopping-cart-item">
                                                <h4><span> </span></h4>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col l-12 m-12 c-12">
                                        <%
                                        
                                            Dim i
                                            connDB.Open()
                                            For each i in mycarts.keys
                                                set rs = connDB.execute("select Products.ProductID, Products.ProcductName, Sizes.Size, Colors.Color, ImagePrducts.Image1,  Products.Price from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID inner join ImagePrducts on ProductDetails.ProductID = ImagePrducts.ProductID where ProductDetailID = '"&i&"'")
                                                If not rs.EOF Then
                                        %>

                                                    <form action="" method="post" class="product_js">
                                                        <div class="row">
                                                            <div class="col l-12 m-12 c-12">
                                                                <div class="cart-content">
                                                                    <div class="row">
                                                                        <a href="removeCart.asp?ID_productDetail=<%=i%>" class="cart-item-delete">
                                                                            <i class="fa-regular fa-trash-can"></i>
                                                                        </a>
                                                                        <div class="col l-3 m-3 c-12">
                                                                            <div class="cart-item">
                                                                                <img src="<%=rs("Image1")%>" alt="">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-3 m-3 c-12">
                                                                            <div class="cart-item">
                                                                                <a href="/details.asp?productID=<%=rs("ProductID")%>"><%=rs("ProcductName")%></a>
                                                                                <p><%=rs("Size")%></p>
                                                                                
                                                                                <p><%=rs("Color")%></p>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-3 m-3 c-12">
                                                                            <div class="cart-item">
                                                                                <button type="button" class="cart-item-btn prev" id="btn-prev" onclick="prev(this, <%=i%>)">
                                                                                    <i class="fa-solid fa-minus"></i>
                                                                                </button>
                                                                                <input type="number" min="1" class="cart-item-number quantity_pro" 
                                                                                    value="<%=mycarts(i)%>" id="display-quantity"
                                                                                />
                                                                                <button type="button" class="cart-item-btn next" id="btn-next" onclick="next(this, <%=i%>)">
                                                                                    <i class="fa-solid fa-plus"></i>
                                                                                </button>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-3 m-3 c-12">
                                                                            <div class="cart-item">
                                                                                <div class="price">
                                                                                    <h4 class="price_pro"><%=rs("Price")%></h4><span>$</span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </form>
                                        <%            
                                                Else
                                                    ' false
                                                End if
                                                totalProduct = totalProduct + Clng(mycarts(i))
                                                totalPrice = totalPrice + Clng(mycarts(i)) * Clng(rs("Price"))
                                            Next
                                        %>
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col l-3 m-12 c-12">
                                <div class="shopping-cost">
                                    <h2>Invoice</h2>
                                    <div class="shopping-cost-info">
                                        <h4 id="display_quantity"></h4>
                                        <h4 id="display_price"></h4>
                                    </div>
                                    <div class="shopping-cost-discount">
                                        <h4>Discount:</h4>
                                        <h4>Black Friday</h4>
                                    </div>
                                    <div class="shopping-cost-total">
                                        <h4>Total:</h4>
                                        <h4>$<%=totalPrice%></h4>
                                    </div>
                                    <div class="shopping-cost-btn">
                                        <a href="checkout.asp">Pay</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                <%        ' true
                    Else
                        totalProduct = 0
                        totalPrice = 0
                    End if
                    
                %>
            </div>
        </div>
        
        <!--#include file="layout/footer.asp"-->
    </div>
    <div class="modal delete-box" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog modal-form">
            <div class="modal-heading">
                <i class="fa-regular fa-circle-check"></i>
            </div>
            <div class="modal-content">
                <h4> Pay Successfully!</h4>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear">Continue</a>
                <button type="button" class="modal-btn-cancel" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script>
        $(function()
        {
            $('#confirm-delete').on('show.bs.modal', function(e){
                $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
            });
        });
        var btn_prev = $('#btn-prev')
        var btn_next = $('#btn-next')
        var display_quantity = $('#display-quantity')
        function prev(e, i) {
            e.parentNode.querySelector('input[type=number]').stepDown();
            var data_prev = {
                ID_product: i,
                quantity: e.parentNode.querySelector('input[type=number]').value
            };
            $.ajax({
                url: 'updateCart.asp',
                data: data_prev,
                dataType: 'json',
                success: function (response) { 
                    $('#sl_sp').html(response.total_quantity)
                },
                error: function() {
                    alert('Lỗi AJAX');
                } 
            });
            $('#display_quantity').html(totalProduct() + " products");
            $('#display_price').html(totalPrice() + "$");

        }

        function next(e, i) {
            e.parentNode.querySelector('input[type=number]').stepUp();
            var data_next = {
                ID_product: i,
                quantity: e.parentNode.querySelector('input[type=number]').value
            };
            $.ajax({
                url: 'updateCart.asp',
                data: data_next,
                dataType: 'json',
                success: function (response) { 
                    $('#sl_sp').html(response.total_quantity)
                },
                error: function() {
                    alert('Lỗi AJAX');
                } 
            });
            $('#display_quantity').html(totalProduct() + " products");
            $('#display_price').html(totalPrice() + "$");

        }

        function totalProduct() {
            var total_quantity = 0;

            $('.product_js').each(function () {
                var quantity_pro = parseInt($(this).find('.quantity_pro').val());
                total_quantity += quantity_pro;
            });

            return total_quantity;

        }

        function totalPrice() {
            var total_price = 0;

            $('.product_js').each(function () {
                var price_pro = parseInt($(this).find('.price_pro').html());
                var quantity_pro = parseInt($(this).find('.quantity_pro').val());
                total_price += price_pro * quantity_pro;
            });

            return total_price;

        }

        $('#display_quantity').html(totalProduct() + " products");
        $('#display_price').html(totalPrice() + "$");
        
    </script> 
    <script src="main.js"></script>
</body>
</html>