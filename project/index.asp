<!--#include file="connect.asp"-->
<!-- #include file="checkLogin.asp" -->

<!--#include file="layout/header.asp"-->

<body>
    <div class="main">
        <div id="banner" class="banner">
            <div class="grid wide">
                <div class="row">
                    <div class="col l-12 m-12 c-12">
                        <div class="banner-title">
                            <p>Men Collection</p>
                            <h3>
                                <span>Show</span>
                                Your
                                <br>
                                Personal
                                <span>Style</span>
                            </h3>
                            <h4>Fowl saw dry which a above together place.</h4>
                            <a href="" class="banner-view">View Collection</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="content">
            <div class="grid wide">
                <div class="row">
                    <div class="col l-3 m-6 c-12">
                        <div class="content-item">
                            <a href="" class="content-item-link">
                                <i class="content-item-icon fa-solid fa-building-columns"></i>
                                <h3>Money back gurantee</h3>
                            </a>
                            <p>Shall open divide a one</p>
                        </div>
                    </div>
                    <div class="col l-3 m-6 c-12">
                        <div class="content-item">
                            <a href="" class="content-item-link">
                                <i class="content-item-icon fa-solid fa-truck-fast"></i>
                                <h3>Free delivery</h3>
                            </a>
                            <p>Shall open divide a one</p>
                        </div>
                    </div>
                    <div class="col l-3 m-6 c-12">
                        <div class="content-item">
                            <a href="" class="content-item-link">
                                <i class="content-item-icon fa-solid fa-phone"></i>
                                <h3>Always support</h3>
                            </a>
                            <p>Shall open divide a one</p>
                        </div>
                    </div>
                    <div class="col l-3 m-6 c-12">
                        <div class="content-item">
                            <a href="" class="content-item-link">
                                <i class="content-item-icon fa-solid fa-shield-halved"></i>
                                <h3>Secure payment</h3>
                            </a>
                            <p>Shall open divide a one</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Men Product</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <%
                        connDB.Open()
                        sql = "select Top 3 * from Products"
                        sql = sql & " inner join Categories on Categories.CategoryID = Products.CategoryID"
                        sql = sql & " inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID"
                        sql = sql & " where Categories.CategoryName = 'Men'"
                        set rs = connDB.execute(sql)
                        Do While not rs.EOF
                    %>
                    <div class="col l-4 m-6 c-12">
                        <div class="product-container">
                            <div class="product-picture">
                                <img src="<%=rs("Image1")%>" alt="" class="product-img">
                                <div class="product-setting">
                                    <ul class="product-setting-list">
                                        <li class="product-setting-item">
                                            <a href="/details.asp?productID=<%=rs("ProductID")%>" class="product-setting-link">
                                                <i class="fa-solid fa-eye"></i>
                                            </a> 
                                        </li>
                                        <li class="product-setting-item">
                                            <a class="product-setting-link" onclick="addFav(<%=rs("ProductID")%>)">
                                                <i class="fa-solid fa-heart"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="product-text">
                                <a class="product-heading">
                                    <h4><%=rs("ProcductName")%></h4>
                                </a>
                                <div class="product-description">
                                    <span>$<%=rs("Price")%></span>
                                    <del>$35.00</del>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                            rs.MoveNext()
                        Loop
                        rs.Close()
                        set rs = nothing
                        connDB.Close()
                    %>
                    
                    
                </div>
            </div>
        </div>
        <div class="offer">
            <div class="grid wide">
                <div class="row offer-wrap">
                    <div class="offer-text">
                        <div class="offer-content">
                            <h3>all special collection</h3>
                            <h2>50% off</h2>
                            <a href="#">Discover Now</a>
                            <p>Limited Time Offer</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product-new">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>New products</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-6 m-12 c-12">
                        <div class="product-new-box">
                            <h5>collection of 2023</h5>
                            <h3>Our summer collection</h3>
                            <div class="product-new-box-img">
                                <img src="./assets/img/product-new.jpg" alt="">
                            </div>
                            <h4>$120.70</h4>
                            <a href="#" class="main_btn">Add to cart</a>
                        </div>
                    </div>
                    <div class="col l-6 ">
                        <div class="row">
                        <%
                            connDB.open()
                            sql = "select top 4 * from Products"
                            sql = sql & " inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID"
                            sql = sql & " order by Products.createdAt desc"
                            set rs = connDB.execute(sql)
                            Do While not rs.EOF
                        %>
                            <div class="col l-6 m-6 c-12">
                                <div class="product-container">
                                    <div class="product-picture">
                                        <img src="<%=rs("Image1")%>" alt="" class="product-img">
                                        <div class="product-setting">
                                            <ul class="product-setting-list">
                                                <li class="product-setting-item">
                                                    <a href="/details.asp?productID=<%=rs("ProductID")%>" class="product-setting-link">
                                                        <i class="fa-solid fa-eye"></i>
                                                    </a> 
                                                </li>
                                                <li class="product-setting-item">
                                                    <a  class="product-setting-link" onclick="addFav(<%=rs("ProductID")%>)">
                                                        <i class="fa-solid fa-heart"></i>
                                                    </a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="product-text">
                                        <a class="product-heading">
                                            <h4><%=rs("ProcductName")%></h4>
                                        </a>
                                        <div class="product-description">
                                            <span>$<%=rs("Price")%></span>
                                            <del>$35.00</del>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%
                                rs.MoveNext()
                            Loop
                            rs.Close()
                            set rs = nothing
                            connDB.Close()
                        %>
                            
                            
                            
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="product-inspired">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Jeans products</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                <%
                    connDB.open()
                    sql = "select Top 8 * from Products"
                    sql = sql & " inner join Categories on Categories.CategoryID = Products.CategoryID"
                    sql = sql & " inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID"
                    sql = sql & " where Categories.[Description] = 'Jeans'"
                    sql = sql & " order by Products.createdAt desc"
                    set rs = connDB.execute(sql)
                    Do While not rs.EOF
                %>

                    <div class="col l-3 m-6 c-12">
                        <div class="product-container">
                            <div class="product-picture">
                                <img src="<%=rs("Image1")%>" alt="" class="product-img">
                                <div class="product-setting">
                                    <ul class="product-setting-list">
                                        <li class="product-setting-item">
                                            <a href="/details.asp?productID=<%=rs("ProductID")%>" class="product-setting-link">
                                                <i class="fa-solid fa-eye"></i>
                                            </a> 
                                        </li>
                                        <li class="product-setting-item">
                                            <a  class="product-setting-link" onclick="addFav(<%=rs("ProductID")%>)">
                                                <i class="fa-solid fa-heart"></i>
                                            </a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                            <div class="product-text">
                                <a class="product-heading">
                                    <h4><%=rs("ProcductName")%></h4>
                                </a>
                                <div class="product-description">
                                    <span>$<%=rs("Price")%></span>
                                    <del>$35.00</del>
                                </div>
                            </div>
                        </div>
                    </div>
                <%
                        rs.MoveNext()
                    Loop
                    rs.Close()
                    set rs = nothing
                    connDB.Close()
                %>
                </div>
            </div>
        </div>
        <div class="blog">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Latest blog</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-4 m-6 c-12">
                        <div class="blog-content">
                            <div class="blog-content-picture">
                                <img src="./assets/img/blog1.jpg" alt="" class="blog-content-img">
                            </div>
                            <div class="blog-content-text">
                                <div class="blog-content-text-cmt">
                                    <ul class="content-text-cmt-list">
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link">By Admin</a></li>
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link"><i class="fa-solid fa-comment"></i> 2 Comments</a></li>
                                    </ul>
                                </div>
                                <a href="" class="blog-content-text-title">
                                    <h4>Ford clever bed stops your sleeping partner hogging the whole</h4>
                                </a>
                                <div class="blog-content-text-heading">
                                    <p>
                                        Let one fifth i bring fly to divided face for bearing the divide unto seed winged divided light Forth.
                                    </p>
                                </div>
                                <a href="" class="blog-content-text-btn">
                                    Learn more
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col l-4 m-6 c-12">
                        <div class="blog-content">
                            <div class="blog-content-picture">
                                <img src="./assets/img/blog1.jpg" alt="" class="blog-content-img">
                            </div>
                            <div class="blog-content-text">
                                <div class="blog-content-text-cmt">
                                    <ul class="content-text-cmt-list">
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link">By Admin</a></li>
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link"><i class="fa-solid fa-comment"></i> 2 Comments</a></li>
                                    </ul>
                                </div>
                                <a href="" class="blog-content-text-title">
                                    <h4>Ford clever bed stops your sleeping partner hogging the whole</h4>
                                </a>
                                <div class="blog-content-text-heading">
                                    <p>
                                        Let one fifth i bring fly to divided face for bearing the divide unto seed winged divided light Forth.
                                    </p>
                                </div>
                                <a href="" class="blog-content-text-btn">
                                    Learn more
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col l-4 m-6 c-12">
                        <div class="blog-content">
                            <div class="blog-content-picture">
                                <img src="./assets/img/blog1.jpg" alt="" class="blog-content-img">
                            </div>
                            <div class="blog-content-text">
                                <div class="blog-content-text-cmt">
                                    <ul class="content-text-cmt-list">
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link">By Admin</a></li>
                                        <li class="content-text-cmt-item"><a href="" class="content-text-cmt-link"><i class="fa-solid fa-comment"></i> 2 Comments</a></li>
                                    </ul>
                                </div>
                                <a href="" class="blog-content-text-title">
                                    <h4>Ford clever bed stops your sleeping partner hogging the whole</h4>
                                </a>
                                <div class="blog-content-text-heading">
                                    <p>
                                        Let one fifth i bring fly to divided face for bearing the divide unto seed winged divided light Forth.
                                    </p>
                                </div>
                                <a href="" class="blog-content-text-btn">
                                    Learn more
                                    <i class="fa-solid fa-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--#include file="layout/footer.asp"-->
    </div>
    <script src="main.js"></script>
    <script>
        console.log(document.getElementById("notify_success").textContent);
        if (document.getElementById("notify_success").textContent != "") {
            showToast();
        }

        function addFav(id) {
            $.ajax({
                url: 'addFavorite.asp',
                data: {ID_product: id},
                dataType: 'json',
                success: function (response) {
                    $('#notify_success').html(response.messenger);
                    $('#sl_fav').html(response.sl_fav);
                    console.log(response.messenger);
                    showToast();
                },
                error: function () {
                    alert('Lỗi AJAX');
                }
            });
        }
    
    </script>
    
    
</body>
</html>