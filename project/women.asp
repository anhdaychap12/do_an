<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->

<%
    Function Ceil(Number)
        Ceil = Int(Number)
        If Ceil<>Number Then
            Ceil = ceil + 1
        End if  
    End Function

    Function checkPage(con, ret)
        If con = true Then
            Response.Write ret
        Else
            Response.Write ""
        End if
    End function

    page = Request.QueryString("page")
    limit = 3

    If (trim(page) = "") or (isnull(page)) Then
        page = 1
    End if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    CateID = Request.QueryString("CateID")
    
    If (trim(CateID) = "") or (isnull(CateID)) Then
        CateID = 5
    End if

    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = true
    cmdPrep.CommandText = "select COUNT(Products.ProductID) as [count] from Products where CategoryID = ?"
    cmdPrep.parameters(0) = CateID
    set rs = cmdPrep.execute()
    totalRows = Clng(rs("count"))
    rs.Close()
    connDB.Close()
    set rs = Nothing
    
    'lấy về tổng số trang
    pages = Ceil(totalRows/limit)
    'giới hạn tổng số trang là 4
    Dim range
    If (pages <= 4) Then
        range = pages
    Else
        range = 4
    End if
    
%>

<!--#include file="layout/header.asp"-->
<body>
    <div class="main">
        <div class="men">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>Women Fashion</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-2 m-12 c-12">
                        <div class="men-menu">
                            <h4>Category</h4>
                            <ul class="men-menu-list">
                                <%
                                    Dim i
                                    For each i in dictWOMEN.keys
                                %>
                                        <li class="men-menu-item"><a href="/women.asp?CateID=<%=i%>" class="men-menu-item-link"><%=dictWOMEN(i)%></a></li>
                                <%    
                                    Next
                                %>
                            </ul>
                        </div>
                    </div>
                    <div class="col l-10 m-12 c-12">
                        <div class="row">
                            <div class="col l-12 m-12 c-12">
                                <h4 class="men-text">Women <%=dictWOMEN(int(CateID))%></h4>
                            </div>
                            <%
                                    set cmdPrep = Server.CreateObject("ADODB.Command")
                                    connDB.Open()
                                    cmdPrep.ActiveConnection = connDB
                                    cmdPrep.CommandType = 1
                                    cmdPrep.Prepared = true
                                    cmdPrep.CommandText = "select * from Products inner join ImagePrducts on ImagePrducts.ProductID = Products.ProductID where CategoryID = ? order by Products.ProductID offset ? rows fetch next ? rows only"
                                    cmdPrep.parameters.Append cmdPrep.createParameter("CateID", 3, 1, ,CateID)
                                    cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, ,offset)
                                    cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, ,limit)

                                    Set rs = cmdPrep.execute

                                    do While not rs.EOF
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
                                                            <li class="product-setting-item" onclick="addFav(<%=rs("ProductID")%>)">
                                                                <a  class="product-setting-link">
                                                                    <i class="fa-solid fa-heart"></i>
                                                                </a>
                                                            </li>
                                                        </ul>
                                                    </div>
                                                </div>
                                                <div class="product-text">
                                                    <a href="/details.asp?productID=<%=rs("ProductID")%>" class="product-heading">
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
                                        rs.MoveNext
                                    Loop

                                    rs.Close()
                                    set rs = nothing
                                    connDB.Close()
                            %>
                            
                            <div class="col l-12 m-12 c-12">
                                <ul class="navigation">
                                    <%
                                        If (pages > 1) Then
                                            If (Clng(page) >= 2) Then
                                    %>
                                                <li class="navigation-item"><a href="/men.asp?CateID=<%=CateID%>&page=<%=Clng(page) - 1%>" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li> 
                                    <%
                                            End If

                                            for i = 1 to range
                                    %>
                                                <li class="navigation-item "><a href="/men.asp?CateID=<%=CateID%>&page=<%=i%>" class="navigation-link <%=checkPage(Clng(i)=Clng(page),"active")%>"><%=i%></a></li>
                                    <%
                                            Next

                                            If (Clng(page) < pages) Then
                                    %>
                                                <li class="navigation-item"><a href="/men.asp?CateID=<%=CateID%>&page=<%=Clng(page) + 1%>" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
                                    <%      
                                            End If  
                                        End if
                                    %>
                                </ul>
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
        function addFav(id) {
            $.ajax({
                url: 'addFavorite.asp',
                data: {ID_product: id},
                dataType: 'json',
                success: function (response) {
                    $('#notify_success').html(response.messenger);
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