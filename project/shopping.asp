<!--#include file="connect.asp"-->
<!-- #include file="checkLogin.asp" -->

<%
    ' khai bao bien
    Dim totalPrice, check_cart, mycarts, totalProduct
    totalPrice = 0
    totalProduct = 0
    If IsEmpty(session("mycarts")) Then
        check_cart = "No products in your cart"
    Else
        check_cart = ""
        set mycarts = session("mycarts")
    End if

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
    
</head>
<body>
    <div class="main">
        <!--#include file="layout/header.asp"-->
        <div class="shopping">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span> Cart</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                        <p id="test"></p>
                        <p><%=check_cart%></p>
                    </div>
                </div>
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
                                        
                                    </div>
                                </div>
                            </div>
                            <div class="col l-12 m-12 c-12">
                                <%
                                    Dim i
                                    connDB.Open()
                                    For each i in mycarts.keys
                                        set rs = connDB.execute("select Products.ProcductName, Sizes.Size, Colors.Color, ImagePrducts.Image1,  Products.Price from ProductDetails inner join Products on ProductDetails.ProductID = Products.ProductID inner join Sizes on ProductDetails.SizeID = Sizes.SizeID inner join Colors on Colors.ColorID = ProductDetails.ColorID inner join ImagePrducts on ProductDetails.ProductID = ImagePrducts.ProductID where ProductDetailID = '"&i&"'")
                                        If not rs.EOF Then
                                %>

                                            <form action="" method="post">
                                                <div class="row">
                                                    <!-- <div class="col l-12 m-12 c-12">
                                                        <div class="shopping-no-cart">
                                                            <img src="./assets/img/no-cart.jpg.png" alt="">
                                                        </div>
                                                    </div> -->
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
                                                                        <h4><%=rs("ProcductName")%></h4>
                                                                        <p><%=rs("Size")%></p>
                                                                        
                                                                        <p><%=rs("Color")%></p>
                                                                    </div>
                                                                </div>
                                                                <div class="col l-3 m-3 c-12">
                                                                    <div class="cart-item">
                                                                        <button class="cart-item-btn prev">
                                                                            <i class="fa-solid fa-minus"></i>
                                                                        </button>
                                                                        <input type="number" class="cart-item-number" value="<%=mycarts(i)%>"/>
                                                                        <button class="cart-item-btn next">
                                                                            <i class="fa-solid fa-plus"></i>
                                                                        </button>
                                                                    </div>
                                                                </div>
                                                                <div class="col l-3 m-3 c-12">
                                                                    <div class="cart-item">
                                                                        <h4>$<%=rs("Price")%></h4>
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
                                <h4><%=totalProduct%> Products</h4>
                                <h4>$<%=totalPrice%></h4>
                            </div>
                            <div class="shopping-cost-ship">
                                <h4>Shipping:</h4>
                                <select class="select">
                                    <option value="1">Standard-Delivery- $5</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                                    <option value="4">Four</option>
                                    <option value="0">Free</option>
                                </select>
                            </div>
                            <div class="shopping-cost-discount">
                                <label for="Discount"><h4>Discount code:</h4></label>
                                <input type="text" id="Discount" placeholder="Discount...">
                            </div>
                            <div class="shopping-cost-total">
                                <h4>Total:</h4>
                                <h4>$<%=totalPrice%></h4>
                            </div>
                            <div class="shopping-cost-btn">
                                <button type="button">Pay</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!--#include file="layout/footer.asp"-->
    </div>
    <script src="main.js"></script>
</body>
</html>