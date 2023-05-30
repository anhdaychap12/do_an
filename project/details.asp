<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->

<%
    ''Hàm check
    Function check(con, ret)
        If con = true Then
            Response.Write ret
        Else
            Response.Write ""
        End if
    End function
    ' Lấy id sản phẩm
    Dim ID_product
    ID_product = Request.QueryString("productID")
    ColorCode = Request.QueryString("ColorCode")
    SizeCode = Request.QueryString("SizeCode")


    connDB.open()
    Dim dictSize, dictColor, i
    set dictSize = Server.CreateObject("Scripting.dictionary")
    set dictColor = Server.CreateObject("Scripting.dictionary")

    ' lấy danh sách color
    set rs = connDB.execute("select Colors.Color, SUM(ProductDetails.Quantity) as SoLuong from ProductDetails inner join Colors on ProductDetails.ColorID = Colors.ColorID where ProductDetails.ProductID = '"&ID_product&"' group by Colors.Color")
    Do While not rs.EOF
        Dim color, quantity_c
        color = rs("Color")
        quantity = rs("SoLuong")
        dictColor.Add color, quantity
        rs.MoveNext
    Loop
    rs.Close()
    set rs = nothing

    ' lấy danh sách size
    set rs = connDB.execute("select Sizes.Size, SUM(ProductDetails.Quantity) as SoLuong from ProductDetails inner join Sizes on ProductDetails.SizeID = Sizes.SizeID where ProductDetails.ProductID = '"&ID_product&"' group by Sizes.Size")
    Do While not rs.EOF
        Dim size, quantity_s
        size = rs("Size")
        quantity_s = rs("SoLuong")
        dictSize.Add size, quantity_s
        rs.MoveNext

    Loop
    rs.Close()
    set rs = nothing

    Dim ColorKeys
    ColorKeys = dictColor.keys
    If isnull(ColorCode) or isnull(trim(ColorCode)) or ColorCode ="" or trim(ColorCode) = "" Then
        ColorCode = ColorKeys(0)
    End if

    Dim SizeKeys
    SizeKeys = dictSize.keys
    If isnull(SizeCode) or isnull(trim(SizeCode)) or SizeCode ="" or trim(SizeCode) = "" Then
        SizeCode = SizeKeys(0)
    End if
    
    ''Lấy ProductdetailID
    Dim ID_productDetail
    set rs = connDB.execute("select ProductDetails.ProductDetailID from ProductDetails inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID where ProductDetails.ProductID = '"&ID_product&"' and Sizes.Size = '"&SizeCode&"' and Colors.Color = '"&ColorCode&"'")
    If not rs.EOF Then
        ID_productDetail = rs("ProductDetailID")
    End if
    rs.Close()
    set rs = nothing
%>

<!-- #include file="layout/header.asp" -->
<body>
    <div class="main">
        <%
            set rs = connDB.execute("select * from Products inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID where Products.ProductID = '"&ID_product&"'")
            If not rs.EOF Then
        %>
                <div class="details">
                    <div class="grid wide">
                        <div class="row product-wrap">
                            <div class="product-title">
                                <h2><span>Details Product</span></h2>
                                <p>Bring called seed first of third give itself now ment</p>
                                <h6 id="test"></h6>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col l-4 m-12 c-12">
                                <div class="details-img">
                                    <!-- Swiper -->
                                    <div class="swiper mySwiper">
                                        <div class="swiper-wrapper">
                                            <div class="swiper-slide"><img src="<%=rs("Image1")%>" onerror="this.src='/assets/img/replace.jpg'"></div>
                                            <div class="swiper-slide"><img src="<%=rs("Image2")%>" onerror="this.src='/assets/img/replace.jpg'"></div>
                                        </div>
                                        <div class="swiper-button-next my-slide"></div>
                                        <div class="swiper-button-prev my-slide"></div>
                                        <div class="swiper-pagination slide"></div>
                                    </div>  
                                </div>
                            </div>
                            <div class="col l-8 m-12 c-12">
                                <div class="details-text">
                                    <a href="" class="details-cancel"><i class="fa-solid fa-xmark"></i></a>
                                    <div class="details-heading">
                                        <p>Details Product</p>
                                        <h1><%=rs("ProcductName")%></h1>
                                        <span>Men Jeans</span>
                                        <h4>$<%=rs("Price")%></h4>
                                    </div>
                                    <ul class="details-color-list">
                                        <li><p>Select color:</p></li>
                                        <%
                                            For each i in dictColor.keys
                                        %>
                                                <li><a href="details.asp?productID=<%=ID_product%>&ColorCode=<%=i%>&SizeCode=<%=SizeCode%>" class="details-color-link <%=check(i = ColorCode, "active1")%>"><%=i%></a></li>
                                        <%
                                            Next
                                        %>
                                    </ul>
                                    <ul class="details-size-list">
                                        <li><p>Select size:</p></li>
                                        <%
                                            For each i in dictSize.keys
                                        %>
                                                <li><a href="details.asp?productID=<%=ID_product%>&ColorCode=<%=ColorCode%>&SizeCode=<%=i%>" class="details-size-link <%=check(i = SizeCode, "active1")%>"><%=i%></a></li>
                                        <%
                                            Next
                                        %>
                                
                                    </ul>
                                    <a class="details-buy" onclick="LoadData()">Add to cart <i class="fa-solid fa-cart-shopping"></i></a>
                                    <p class="details-review-text"><%=rs("Description")%></p>
                                    <div class="details-view">
                                        <ul class="details-star-list">
                                            <li><p>Rate:</p></li>
                                            <li><a href="#" class="details-star-link"><i class="fa-solid fa-star"></i></a></li>
                                            <li><a href="#" class="details-star-link"><i class="fa-solid fa-star"></i></a></li>
                                            <li><a href="#" class="details-star-link"><i class="fa-solid fa-star"></i></a></li>
                                            <li><a href="#" class="details-star-link"><i class="fa-solid fa-star"></i></a></li>
                                            <li><a href="#" class="details-star-link"><i class="fa-solid fa-star"></i></a></li>
                                        </ul>
                                        <a href="#">Comments(0) <i class="fa-solid fa-angle-down"></i></a>
                                    </div>
                                    <input type="text" placeholder="Comments....">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        <%
            End if
        %>        
    </div>
    <!-- #include file="layout/footer.asp" -->
    <div class="modal delete-box" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog modal-form">
            <div class="modal-heading">
                <i class="fa-regular fa-circle-check"></i>
            </div>
            <div class="modal-content">
                <h4>Success!</h4>
                <p id = "messenger"></p>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear" onclick="CloseConfirm()">Continue</a>
                <a class="modal-btn modal-btn-cancel" href="shopping.asp">View Cart</a>

            </div>
        </div>
    </div> 
    <script src="main.js"></script>
    <!-- Swiper JS -->
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>

    <!-- Initialize Swiper -->
    <script>
        var swiper = new Swiper(".mySwiper", {
        slidesPerView: 1,
        spaceBetween: 30,
        loop: true,
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script>
        function LoadData(){
            document.getElementById('confirm-delete').style.display = "block";
            var data = {ID_productDetail: <%=ID_productDetail%>};
            console.log(data);
            $.ajax({
                url: 'addCart.asp',
                data: data,
                dataType: 'json',
                success: function (response) {
                    $('#sl_sp').html(response.totalProduct)
                    $('#messenger').html(response.messenger)
                },
                error: function (response){
                    alert('Lỗi AJAX');
                }
            });
        }

        function CloseConfirm(){
                    document.getElementById('confirm-delete').style.display = "none";

        }

    </script>
</body>
</html>
