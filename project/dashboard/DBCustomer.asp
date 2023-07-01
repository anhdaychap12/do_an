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
    limit = 3

    If (trim(page) = "") or (isnull(page)) Then
        page = 1
    End if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    search = Request.QueryString("search")
    dim sql2 
    sql2= "WHERE Fullname LIKE '"&search&"'"
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = true
    If Not IsEmpty(search) Then
    cmdPrep.CommandText = "select COUNT(Customers.CustomerID) as [count] from Customers " & sql2
    Else
        cmdPrep.CommandText = "select COUNT(Customers.CustomerID) as [count] from Customers"
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
                                        <div class="dashboard-customer">
                                            <div class="dashboard-text">
                                                <h4>Customer</h4>
                                            </div>
                                            <div class="form">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Name</th>
                                                            <th>Phone</th>
                                                            <th> Address</th>
                                                            <th>Email</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <%
                                                            search = Request.QueryString("search")
                                                            dim sql 
                                                            sql = "SELECT * FROM Customers  "
                                                            sql1= " ORDER BY CustomerID  offset ? rows fetch next ? rows only"
                                                            connDB.open()
                                                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                                                            cmdPrep.ActiveConnection = connDB
                                                            cmdPrep.CommandType = 1
                                                            cmdPrep.Prepared = True
                                                            'tim kiem
                                                            If Not IsEmpty(search) Then
                                                                sql = sql & " WHERE Fullname LIKE ?" & sql1
                                                                cmdPrep.Parameters.Append(cmdPrep.CreateParameter("search", 200, 1, 255, "%" & search & "%"))
                                                            Else 
                                                                sql = sql & sql1
                                                            End If
                                                            cmdPrep.CommandText = sql
                                                            cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, ,offset)
                                                            cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, ,limit)

                                                            Set Result = cmdPrep.execute
                                                            do while not Result.EOF
                                                        %>
                                                        <tr>
                                                            <td><%=Result("CustomerID")%></td>
                                                            <td><%=Result("Fullname")%></td>
                                                            <td><%=Result("PhoneNumber")%></td>
                                                            <td><%=Result("Address")%></td>
                                                            <td><%=Result("Email")%></td>
                                                        </tr>
                                                        <%
                                                            Result.MoveNext
                                                            loop
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
                                                                <li class="navigation-item"><a href="/dashboard/DBCustomer.asp?page=<%=Clng(page) - 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li> 
                                                    <%
                                                            End If

                                                            for i = 1 to range
                                                    %>
                                                                <li class="navigation-item "><a href="/dashboard/DBCustomer.asp?page=<%=i%>&search=<%=search%>" class="navigation-link <%=checkPage(Clng(i)=Clng(page),"active")%>"><%=i%></a></li>
                                                    <%
                                                            Next

                                                            If (Clng(page) < pages) Then
                                                    %>
                                                                <li class="navigation-item"><a href="/dashboard/DBCustomer.asp?page=<%=Clng(page) + 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
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