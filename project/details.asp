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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IT Store</title>
    <link rel="icon" type="image/png" href="./assets/img/favicon.jpg"/>
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/responsove.css">
    <link rel="stylesheet" href="./assets/css/Grid.css">
    <link rel="stylesheet" href="./assets/fonts/fontawesome-free-6.2.0-web/css/all.min.css">
    <script>
        function LoadData(){
            var xmlhttp;
            xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function(){
                
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
                    document.getElementById('messenger').innerHTML = "Product has been added to your cart.";
                    document.getElementById('sl_sp').innerHTML = xmlhttp.responseText;
                    document.getElementById('confirm-delete').style.display = "block";
                }
            }
            xmlhttp.open("POST", "addCart.asp?ID_productDetail=<%=ID_productDetail%>", true);
            xmlhttp.send();
        }

        function CloseConfirm(){
                    document.getElementById('confirm-delete').style.display = "none";

        }

    </script>
</head>
<body>
    <div class="main">
        <!-- #include file="layout/header.asp" -->
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
                                    <img src="<%=rs("Image1")%>" alt="">
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
                                                <li><a href="details.asp?productID=<%=ID_product%>&ColorCode=<%=i%>&SizeCode=<%=SizeCode%>" class="details-color-link <%=check(i = ColorCode, "active")%>"><%=i%></a></li>
                                        <%
                                            Next
                                        %>
                                    </ul>
                                    <ul class="details-size-list">
                                        <li><p>Select size:</p></li>
                                        <%
                                            For each i in dictSize.keys
                                        %>
                                                <li><a href="details.asp?productID=<%=ID_product%>&ColorCode=<%=ColorCode%>&SizeCode=<%=i%>" class="details-size-link <%=check(i = SizeCode, "active")%>"><%=i%></a></li>
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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script>
        $(function()
        {
            $('#confirm-delete').on('show.bs.modal', function(e){
                $(this).find('.btn-delete').attr('href', $(e.relatedTarget).data('href'));
            });
        });
    </script>
</body>
</html>
