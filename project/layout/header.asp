<%  
    Dim connHead
    set connHead = Server.CreateObject("ADODB.Connection")
    Dim strConnectionHead
    strConnectionHead = "Provider=SQLOLEDB.1;Data Source=PHUC\SQLEXPRESS;Database=WEB_BQA1;User Id=sa;Password=01052002"
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
                                        <input type="text" class="search-text" placeholder="Search...">
                                        <div class="search-icon js-click">
                                            <i class="nav-icon fa-solid fa-magnifying-glass"></i>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="section-right-item"><a href="shopping.asp" class="section-right-item-link"><i class="nav-icon fa-solid fa-cart-shopping"><span class="quantity"><p><%=session("totalProduct")%></p></span></i></a></li>

                            <li class="section-right-item"><a href="favorite.asp" class="section-right-item-link"><i class="nav-icon fa-solid fa-heart"></i></a></li>
                            
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
                            <input type="text" class="search-mobile-text" placeholder="Search...">
                            <button class="search-mobile-btn">
                                <i class="nav-icon fa-solid fa-magnifying-glass"></i>
                            </button>
                        </div>
                    </li>
                    <li class="section-center-item">
                        <img src="../assets/img/customer.jpg" alt="" class="avatar avatar-mobile">
                        <ul class="mobile sub-center">
                            <li class="sub-center-item"><p>AnhCus</p></li>
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link"><i class="fa-solid fa-pen-to-square"></i> Profile</a></li>
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link"><i class="fa-solid fa-cart-shopping"></i> My cart</a></li>
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link"><i class="fa-solid fa-heart"></i> My Favorite</a></li>
                            <li class="sub-center-item"><a href="#" class="sub-center-item-link"><i class="fa-solid fa-arrow-right-from-bracket"></i> Logout</a></li>
                        </ul>
                        <!-- <a href="#" class="section-center-item-link"><i class="nav-icon fa-solid fa-user"></i></a> -->
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
