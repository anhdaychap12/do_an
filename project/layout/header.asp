<%
    dim so_luong_sp_fav, ds_fav
    If not IsEmpty(session("fav")) Then
        set ds_fav = session("fav")
        so_luong_sp_fav = ds_fav.Count
    Else
        so_luong_sp_fav = 0
    End if
%>
<%
    dim so_luong_sp_cart, ds_cart
    If not IsEmpty(session("mycarts")) Then
        ' true
        set ds_cart = session("mycarts")
        dim sl
        so_luong_sp_cart = 0
        for each sl in ds_cart.keys
            so_luong_sp_cart = so_luong_sp_cart + Clng(ds_cart(sl))
        Next
    Else
        so_luong_sp_cart = 0
    End if
    
%>
<%  
    Dim connHead
    set connHead = Server.CreateObject("ADODB.Connection")
    Dim strConnectionHead
    strConnectionHead = "Provider=SQLOLEDB.1;Data Source=DESKTOP-NLBPS1S;Database=WEB_BQA1;User Id=sa ;Password=ducanh"
    connHead.ConnectionString = strConnectionHead
    Dim rs, stringSQL
    sqlString = "select * from Categories"
    connHead.Open()
    set rs = connHead.execute(sqlString)
    Dim dictMEN, dictWOMEN
    set dictMEN = CreateObject("Scripting.Dictionary")
    set dictWOMEN = CreateObject("Scripting.Dictionary")

    Do while not rs.EOF
        If rs("CategoryName") <> "Women" Then
            Dim x, y
            x = rs("CategoryID")
            y = rs("Description")
            dictMEN.add x, y
            ' true
        Else
            Dim a, b
            a = rs("CategoryID")
            b = rs("Description")
            dictWOMEN.add a, b
        End if
        
        rs.MoveNext
    Loop
    rs.Close()
    set rs = nothing
    connHead.Close()

    
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IT Store</title>
    <link rel="icon" type="image/png" href="./assets/img/favicon.jpg"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/responsove.css">
    <link rel="stylesheet" href="./assets/css/Grid.css">
    <link rel="stylesheet" href="./assets/fonts/fontawesome-free-6.2.0-web/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css" />
</head>
<div id="header" class="header">
    <div class="header-top hide-on-mobile">
        <div class="grid wide">
            <div class="row store">
                <div class="header-top-left">
                    <p>PHONE: 0925973677</p>
                    <p>Email: anh1501865@nuce.edu.vn</p>
                </div>
                <div class="header-top-right hide-on-mobile-tablet">
                    <ul class="top-right-list hide-on-mobile-tablet">
                        <li class="top-right-item"><a href="" class="top-right-item-link">Card</a></li>
                        <li class="top-right-item"><a href="" class="top-right-item-link">Order</a></li>
                        <li class="top-right-item"><a href="" class="top-right-item-link">Contact Us</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <nav id="navbar" class="nav">
        <div class="grid wide">
            <div class="row store">
                <div class="nav-left">
                    <a href="" class="nav-left-brand">
                        <img src="./assets/img/logo.jpg" class="nav-left-brand-img" alt="">
                    </a>
                </div>
                <div class="nav-center hide-on-mobile-tablet">
                    <div class="nav-center-section">
                        <ul class="section-center-list">
                            <li class="section-center-item"><a href="/index.asp" class="section-center-item-link">HOME</a></li>
                            <li class="section-center-item">
                                <a href="/men.asp" class="section-center-item-link">MEN</a>
                                <ul class="sub-center">
                                    <%
                                        Dim key
                                        For each key in dictMEN.keys
                                    %>
                                            <li class="sub-center-item"><a href="/men.asp?CateID=<%=key%>" class="sub-center-item-link"><%=dictMEN(key)%></a></li>  
                                    <%    
                                        Next
                                    %>
                                </ul>
                            </li>
                            <li class="section-center-item">
                                <a href="/women.asp" class="section-center-item-link">WOMEN</a>
                                <ul class="sub-center">
                                    <%
                
                                        For each key in dictWOMEN.keys
                                    %>
                                            <li class="sub-center-item"><a href="/women.asp?CateID=<%=key%>" class="sub-center-item-link"><%=dictWOMEN(key)%></a></li>
                                    
                                    <%
                                        Next
                                    %>
                                </ul>
                            </li>
                            <li class="section-center-item">
                                <a href="" class="section-center-item-link">BLOG</a>
                                <ul class="sub-center">
                                    <li class="sub-center-item"><a href="" class="sub-center-item-link">Blog</a></li>
                                    <li class="sub-center-item"><a href="" class="sub-center-item-link">Blog details</a></li>
                                </ul>
                            </li>
                            <li class="section-center-item"><a href="" class="section-center-item-link">CONTACT</a></li>
                        </ul>
                    </div>
                </div>
                <div class="nav-right hide-on-mobile-tablet">
                    <div class="nav-right-section">
                        <ul class="section-right-list">

                            <li class="section-right-item">
                                <a class="section-right-item-link">
                                    <div class="search-section">
                                        <input id="Search" onkeydown="showResult(event)" type="text" class="search-text" placeholder="Search...">
                                        <div class="search-icon js-click">
                                            <i class="nav-icon fa-solid fa-magnifying-glass"></i>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="section-right-item"><a href="shopping.asp" class="section-right-item-link"><i class="nav-icon fa-solid fa-cart-shopping"><span class="quantity"><p id ="sl_sp"><%=so_luong_sp_cart%></p></span></i></a></li>
                            <li class="section-right-item"><a href="favorite.asp" class="section-right-item-link"><i class="nav-icon fa-solid fa-heart"><span class="quantity"><p id ="sl_fav"><%=so_luong_sp_fav%></p></span></i></a></li>
                            
                            <%
                                If Session("user") <> "" and trim(Session("user")) <> "" Then
                            %>    
                                <li class="section-right-item">
                                    <img src="../assets/img/customer.jpg" alt="" class="avatar">
                                    <ul class="section-right-list-sub">
                                        <li class="section-right-item-sub"><p><%=Session("user")%></p></li>
                                        <li class="section-right-item-sub"><a href="profile.asp" class="section-right-item-link-sub"><i class="fa-solid fa-pen-to-square"></i> Profile</a></li>
                                        <li class="section-right-item-sub"><a href="shopping.asp" class="section-right-item-link-sub"><i class="fa-solid fa-cart-shopping"></i> My cart</a></li>
                                        <li class="section-right-item-sub"><a href="favorite.asp" class="section-right-item-link-sub"><i class="fa-solid fa-heart"></i> My favorite</a></li>
                                        <li class="section-right-item-sub"><a href="history.asp" class="section-right-item-link-sub"><i class="fa-solid fa-clock-rotate-left"></i> My history</a></li>
                                        <li class="section-right-item-sub"><a href="logout.asp" class="section-right-item-link-sub"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
                                    </ul>
                                </li>
                            <%        
                                Else
                            %>
                                <li class="section-right-item"><a href="login.asp" class="section-right-item-link"><i class="nav-icon fa-solid fa-user"></i></a></li>
                            <%    
                                End if
                            %>
                        </ul>
                    </div>
                    <div id="search" class="search-modal">
                        <div class="search-box">
                            <div class="item-box">
                                <div class="item-img">
                                    <img src="../assets/img/replace.jpg" alt="">
                                </div>
                                <div class="item-text">
                                    <a href=""><h4>Jeans Baggy</h4></a>
                                    <p>400$</p>
                                </div>
                            </div>
                            <div class="item-box">
                                <div class="item-img">
                                    <img src="../assets/img/replace.jpg" alt="">
                                </div>
                                <div class="item-text">
                                    <a href=""><h4>Jeans Baggy</h4></a>
                                    <p>400$</p>
                                </div>
                            </div>
                            <div class="item-box">
                                <div class="item-img">
                                    <img src="../assets/img/replace.jpg" alt="">
                                </div>
                                <div class="item-text">
                                    <a href=""><h4>Jeans Baggy</h4></a>
                                    <p>400$</p>
                                </div>
                            </div>
                            <div class="item-box">
                                <div class="item-img">
                                    <img src="../assets/img/replace.jpg" alt="">
                                </div>
                                <div class="item-text">
                                    <a href=""><h4>Jeans Baggy</h4></a>
                                    <p>400$</p>
                                </div>
                            </div>
                            <p class="title-search">No more result!</p>
                        <button class="close-box js-shut">Close</button>
                        </div>
                    </div>
                </div>
                <div id="mobile-menu" class="nav-mobile">
                    <label for="mobile-input">
                        <div class="nav-mobile-link">
                            <i class="nav-icon fa fa-bars"></i>
                        </div>
                    </label>
                </div>
            </div>
        </div>
    </nav>
    <input type="checkbox" hidden id="mobile-input" class="mobile-check">
    <div class="mobile-menu">
        <div class="mobile nav-center">
            <div class="nav-center-section">
                <ul class="section-center-list">
                    <li class="section-center-item">
                        <div class="search-mobile">
                            <input id="SearchM" type="text" class="search-mobile-text" placeholder="Search...">
                            <button id="btnM" type="button" class="search-mobile-btn">
                                <i class="nav-icon fa-solid fa-magnifying-glass"></i>
                            </button>
                            <div id="searchM" class="search-modal">
                                <div class="search-box">
                                    <div class="item-box">
                                        <div class="item-img">
                                            <img src="../assets/img/replace.jpg" alt="">
                                        </div>
                                        <div class="item-text">
                                            <a href=""><h4>Jeans Baggy</h4></a>
                                            <p>400$</p>
                                        </div>
                                    </div>
                                    <div class="item-box">
                                        <div class="item-img">
                                            <img src="../assets/img/replace.jpg" alt="">
                                        </div>
                                        <div class="item-text">
                                            <a href=""><h4>Jeans Baggy</h4></a>
                                            <p>400$</p>
                                        </div>
                                    </div>
                                    <div class="item-box">
                                        <div class="item-img">
                                            <img src="../assets/img/replace.jpg" alt="">
                                        </div>
                                        <div class="item-text">
                                            <a href=""><h4>Jeans Baggy</h4></a>
                                            <p>400$</p>
                                        </div>
                                    </div>
                                    <div class="item-box">
                                        <div class="item-img">
                                            <img src="../assets/img/replace.jpg" alt="">
                                        </div>
                                        <div class="item-text">
                                            <a href=""><h4>Jeans Baggy</h4></a>
                                            <p>400$</p>
                                        </div>
                                    </div>
                                    <p class="title-search">No more result!</p>
                                <button class="close-box js-shutM">Close</button>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li class="section-center-item">
                    <%
                        If Session("user") <> "" and trim(Session("user")) <> "" Then
                    %>  
                        <img src="../assets/img/customer.jpg" alt="" class="avatar avatar-mobile">
                        <ul class="mobile sub-center">
                            <li class="sub-center-item"><p><%=Session("user")%></p></li>
                            <li class="sub-center-item"><a href="profile.asp" class="sub-center-item-link"><i class="fa-solid fa-pen-to-square"></i> Profile</a></li>
                            <li class="sub-center-item"><a href="shopping.asp" class="sub-center-item-link"><i class="fa-solid fa-cart-shopping"></i> My cart</a></li>
                            <li class="sub-center-item"><a href="favorite.asp" class="sub-center-item-link"><i class="fa-solid fa-heart"></i> My Favorite</a></li>
                            <li class="sub-center-item"><a href="history.asp" class="sub-center-item-link"><i class="fa-solid fa-clock-rotate-left"></i> My history</a></li>
                            <li class="sub-center-item"><a href="logout.asp" class="sub-center-item-link"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
                        </ul>
                    <%
                        else
                    %>    
                        <a href="login.asp" class="section-center-item-link"><i class="nav-icon fa-solid fa-user"></i></a>
                    <%
                        end if
                    %>    
                    </li>
                    <li class="section-center-item"><a href="/index.asp" class="section-center-item-link">HOME</a></li>
                    <li class="section-center-item">
                        <a href="/men.asp" class="section-center-item-link">MEN</a>
                        <ul class="mobile sub-center">
                            <%
                                
                                For each key in dictMEN.keys
                            %>
                                    <li class="sub-center-item"><a href="/men.asp?CateID=<%=key%>" class="sub-center-item-link"><%=dictMEN(key)%></a></li>  
                            <%    
                                Next
                            %>                            
                        </ul>
                    </li>
                    <li class="section-center-item">
                        <a href="/women.asp" class="section-center-item-link">WOMEN</a>
                        <ul class="mobile sub-center">
                            <%
        
                                For each key in dictWOMEN.keys
                            %>
                                    <li class="sub-center-item"><a href="/women.asp?CateID=<%=key%>" class="sub-center-item-link"><%=dictWOMEN(key)%></a></li>
                            
                            <%
                                Next
                            %>
                        </ul>
                    </li>
                    <li class="section-center-item">
                        <a href="#" class="section-center-item-link">BLOG</a>
                        <ul class="mobile sub-center">
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link">Blog</a></li>
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link">Blog details</a></li>
                        </ul>
                    </li>
                    <li class="section-center-item"><a href="#" class="section-center-item-link">CONTACT</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
<div id="toast" class="toast">
    <p id="notify_success"><%=session("success")%></p>
</div>
<script>
    // search modal PC
    var result = document.getElementById("search")
    var shut = document.querySelector(".js-shut")

    function showResult(event) {
        if(event.keyCode === 13) {
            result.classList.add("open-search")
        }
    }

    window.addEventListener("click", hideResult)

    result.addEventListener('click', function (event) {
            event.stopPropagation()
    })

    function hideResult() {
        result.classList.remove("open-search")
    } 

    shut.addEventListener("click", hideResult)

    // Tablet and mobile
    var btnM = document.getElementById("btnM")
    var resultM = document.getElementById("searchM")
    var shutM = document.querySelector(".js-shutM")

    btnM.addEventListener("click", function() {
        resultM.classList.add("open-search")
    })

    document.getElementById("SearchM").addEventListener("keypress", function(event){
    if (event.keyCode === 13) { 
       resultM.classList.add("open-search") 
    }
    });

    function hideResultM() {
        resultM.classList.remove("open-search")
    }
    shutM.addEventListener("click",hideResultM)
    resultM.addEventListener('click', function (event) {
            event.stopPropagation()
    })
</script>
