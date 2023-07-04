 <!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->
 <%
    ''check
    

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
    limit = 10

    If (trim(page) = "") or (isnull(page)) Then
        page = 1
    End if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    search = Request.QueryString("search")
    dim sql2 
    sql2= " WHERE Orders.OrderID LIKE '"& search &"'  "
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = true
    If (NOT isnull(search) and search<>"") Then
    cmdPrep.CommandText = "select COUNT(Orders.OrderID) as [count] from Orders " & sql2
    Else
    cmdPrep.CommandText = "select COUNT(Orders.OrderID) as [count] from Orders"
    End If
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
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>IT Store</title>
    <link rel="icon" type="image/png" href="./assets/img/favicon.jpg"/>
    <link rel="stylesheet" href="./assets/css/DBstyle.css">
    <link rel="stylesheet" href="./assets/css/responsove.css">
    <link rel="stylesheet" href="./assets/css/Grid.css">
    <link rel="stylesheet" href="./assets/fonts/fontawesome-free-6.2.0-web/css/all.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
</head>
<body>
        <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <div class="grid wide">
                                <div class="row">
                                    <div class="col l-12 m-12 c-12">
                                        <div class="dashboard-order">
                                            <div class="dashboard-text">
                                                <h4>Order</h4>
                                            </div>
                                            <div class="form">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Customer Name</th>
                                                            <th>Customer Type</th>
                                                            <th>Email</th>                                                           
                                                            <th>Address</th>
                                                            <th>Phone</th>
                                                            <th>Order Date</th>
                                                            <th>Shipping fee</th>
                                                            <th>Total</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                        connDB.open()
                                                        
                                                        If isnull(search) Then
                                                            ' true
                                                            sql = "select OrderID, OrderDate, TotalAmount, IIF(CustomerID > 0, 'Khach vang lai', 'Thanh vien') as LoaiKhachHang, ShippingFrees.Price as Price_ship, [Address], Email, Phone, Fullname from Orders"
                                                            sql = sql & " inner join ShippingFrees on ShippingFrees.ShippingFreeID = Orders.ShippingFreeID"
                                                            sql = sql & " order by Orders.OrderID offset "&offset&" rows fetch next "&limit&" rows only"
                                                        Else
                                                            ' false
                                                            sql = "select OrderID, OrderDate, TotalAmount, IIF(CustomerID > 0, 'Khach vang lai', 'Thanh vien') as LoaiKhachHang, ShippingFrees.Price as Price_ship, [Address], Email, Phone, Fullname from Orders"
                                                            sql = sql & " inner join ShippingFrees on ShippingFrees.ShippingFreeID = Orders.ShippingFreeID"
                                                            sql = sql & " where Orders.OrderID like '%"&search&"%'"
                                                            sql = sql & " order by Orders.OrderID offset "&offset&" rows fetch next "&limit&" rows only"
                                                        End if
                                                        set rs = connDB.execute(sql)
                                                        Do While not rs.EOF
                                                    %>
                                                            <tr>
                                                            <td><%=rs("OrderID")%></td>
                                                            <td><%=rs("Fullname")%></td>
                                                            <td><%=rs("LoaiKhachHang")%></td>
                                                            <td><%=rs("Email")%></td>                                                           
                                                            <td><%=rs("Address")%></td>
                                                            <td><%=rs("Phone")%></td>
                                                            <td><%=rs("OrderDate")%></td>
                                                            <td><%=rs("Price_ship")%></td>
                                                            <td><%=rs("TotalAmount")%></td>
                                                            </tr>
                                                    <%
                                                        rs.MoveNext
                                                        Loop
                                                        rs.Close
                                                        set rs = nothing
                                                        connDB.Close()
                                                    %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="page">
                                                <ul class="navigation">
                                                    <%
                                                        If (pages > 1) Then
                                                            If (Clng(page) >= 2) Then
                                                    %>
                                                                <li class="navigation-item"><a href="/dashboard/DBOrder.asp?page=<%=Clng(page) - 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li> 
                                                    <%
                                                            End If

                                                            for i = 1 to range
                                                    %>
                                                                <li class="navigation-item "><a href="/dashboard/DBOrder.asp?page=<%=i%>&search=<%=search%>" class="navigation-link <%=checkPage(Clng(i)=Clng(page),"active")%>"><%=i%></a></li>
                                                    <%
                                                            Next

                                                            If (Clng(page) < pages) Then
                                                    %>
                                                                <li class="navigation-item"><a href="/dashboard/DBOrder.asp?page=<%=Clng(page) + 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
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
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function(){
            $('.dashboard-menu-item-link').click(function(){
                $(this).next('.dashboard-menu-list-sub').slideToggle('');
                $(this).find('.dashboard-menu-item-link-icon').toggleClass('rotate');
            })
        })
        const Open = document.querySelector(".js-btn");
        const nav = document.querySelector(".js-nav");
        const Close = document.querySelector(".js-close");
        function showNav() {
            nav.classList.add("Open");
        }
        function hideNav() {
            nav.classList.remove("Open");
        }
        Open.addEventListener("click", showNav);
        Close.addEventListener("click", hideNav);
        nav.addEventListener("click",function(e){
            e.stopPropagation();
        })
    </script>
</body>
</html>