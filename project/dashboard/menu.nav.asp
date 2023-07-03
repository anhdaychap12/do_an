
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

<div class="main">
        <div class="dashboard">
            <div class="row no-gutters">
                <div class="col l-2 m-0 c-0">
                    <div class="dashboard-nav">
                        <div class="dashboard-logo">
                            <img src="./assets/img/logo.jpg" alt="">
                        </div>
                        <div class="dashboard-menu">
                            <ul class="dashboard-menu-list">
                                <li class="dashboard-menu-item"><a href="Dashboard.asp" class="dashboard-menu-item-link active"><p><i class="fa-solid fa-house"></i> Home</p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item">
                                    <a  class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Men Product</p> <i id="icon" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                    </a>
                                    <ul class="dashboard-menu-list-sub">
                                        <%
                                            Dim key
                                            For each key in dictMEN.keys
                                        %>
                                                <li class="dashboard-menu-item-sub"><a href="DBMen.asp?CateID=<%=key%>" class="dashboard-menu-item-link-sub"><%=dictMEN(key)%><i class="sub-icon fa-solid fa-angle-right"></i></a></li>  
                                        <%    
                                            Next
                                        %>
                                    </ul>
                                </li>
                                <li class="dashboard-menu-item">
                                    <a  class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Women Product</p> <i id="icon1" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                    </a>
                                    <ul class="dashboard-menu-list-sub">
                                    <%
                                        
                                        For each key in dictWOMEN.keys
                                    %>
                                            <li class="dashboard-menu-item-sub"><a href="DBWomen.asp?CateID=<%=key%>" class="dashboard-menu-item-link-sub"><%=dictWOMEN(key)%><i class="sub-icon fa-solid fa-angle-right"></i></a></li>  
                                    <%    
                                        Next
                                    %>
                                    </ul>
                                </li>
                                <li class="dashboard-menu-item"><a href="DBCustomer.asp" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Customer</p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="DBOrder.asp" class="dashboard-menu-item-link"><p><i class="fa-solid fa-bag-shopping"></i> Order </p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="DBDiscount.asp" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Discount </p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="DBAccount.asp" class="dashboard-menu-item-link"><p><i class="fa-solid fa-user"></i> Account </p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="DBCategory.asp" class="dashboard-menu-item-link"><p><i class="fa-solid fa-list"></i> Category </p> <i class="fa-solid fa-angle-right"></i></a></li>

                            </ul>
                        </div>
                    </div>
                </div>
                <div class="dashboard-nav dashboard-nav-mobile js-nav">
                    <button class="dashboard-close-mobile js-close">
                        <i class="fa-solid fa-xmark"></i>
                    </button>
                    <div class="dashboard-logo">
                        <img src="./assets/img/logo.jpg" alt="">
                    </div>
                    <div class="dashboard-menu">
                        <ul class="dashboard-menu-list">
                            <li class="dashboard-menu-item"><a href="Dashboard.asp" class="dashboard-menu-item-link active"><p><i class="fa-solid fa-house"></i> Home</p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item">
                                <a  class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Men Product</p> <i id="icon" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                </a>
                                <ul class="dashboard-menu-list-sub">
                                    <%
                                        ' Dim key
                                        For each key in dictMEN.keys
                                    %>
                                            <li class="dashboard-menu-item-sub"><a href="DBMen.asp?CateID=<%=key%>" class="dashboard-menu-item-link-sub"><%=dictMEN(key)%><i class="sub-icon fa-solid fa-angle-right"></i></a></li>  
                                    <%    
                                        Next
                                    %>
                                </ul>
                            </li>
                            <li class="dashboard-menu-item">
                                <a  class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Women Product</p> <i id="icon1" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                </a>
                                <ul class="dashboard-menu-list-sub">
                                     <%
                                        
                                        For each key in dictWOMEN.keys
                                    %>
                                            <li class="dashboard-menu-item-sub"><a href="DBWomen.asp?CateID=<%=key%>" class="dashboard-menu-item-link-sub"><%=dictWOMEN(key)%><i class="sub-icon fa-solid fa-angle-right"></i></a></li>  
                                    <%    
                                        Next
                                    %>
                                </ul>
                            </li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Customer</p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-bag-shopping"></i> Order </p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Discount </p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Account </p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Category </p> <i class="fa-solid fa-angle-right"></i></a></li>

                        </ul>
                    </div>
                </div>
                <div class="col l-10 m-12 c-12">
                    <div class="dashboard-main">
                        <div class="dashboard-main-header">
                            <button class="dashboard-main-mobile js-btn">
                                <i class="nav-icon fa fa-bars"></i>
                            </button>
                            <div class="dashboard-main-header-search hide-on-mobile-tablet">
                                <form  role="search" action="">
                                <input type="text" placeholder="Search..." name="search">
                                <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                                </form>
                            </div>
                            <div class="dashboard-main-header-login">
                            <%
                                If Session("user") <> "" and trim(Session("user")) <> "" Then
                            %>
                                <h4>
                                <%=session("user")%>
                                </h4>
                                <img src="./assets/img/admin.jpg" alt="" class="admin-avatar">
                                <a href="../logout.asp" class="dashboard-main-header-login-link">
                                    <i class="nav-icon fa-solid fa-arrow-right-from-bracket"></i>
                                </a>    
                            <%  
                                Else
                            %>
                                <a href="../login.asp" class="dashboard-main-header-login-link">
                                    <i class="fa-solid fa-user"></i>
                                    Login
                                </a> 
                            <%
                                End if
                            %>
                            </div>
                        </div>                        