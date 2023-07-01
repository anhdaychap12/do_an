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
    limit = 5

    If (trim(page) = "") or (isnull(page)) Then
        page = 1
    End if

    offset = (Clng(page) * Clng(limit)) - Clng(limit)

    search = Request.QueryString("search")
    dim sql2 
    sql2= " AND Username LIKE '"&search&"'"
    set cmdPrep = Server.CreateObject("ADODB.Command")
    connDB.Open()
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = true
    If Not IsEmpty(search) Then
    cmdPrep.CommandText = "select COUNT(Accounts.AccountID) as [count] from Accounts where Role = 'admin' " & sql2
    Else
        cmdPrep.CommandText = "select COUNT(Accounts.AccountID) as [count] from Accounts where Role = 'admin'"
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
                                        <div class="dashboard-product">
                                            <div class="dashboard-text">
                                                <h4>Account</h4>
                                                <a href="EditAccount.asp" class="dashboard-option-btn dashboard-create">Create</a>
                                            </div>
                                            <div class="form">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Username</th>
                                                            <th>Password</th>
                                                            <th>Role</th>
                                                            <th>Option</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    <%
                                                            search = Request.QueryString("search")
                                                            dim sql 
                                                            sql = "SELECT * FROM Accounts  "
                                                            sql1= " role ='admin' ORDER BY AccountID  offset ? rows fetch next ? rows only"
                                                            connDB.open()
                                                            Set cmdPrep = Server.CreateObject("ADODB.Command")
                                                            cmdPrep.ActiveConnection = connDB
                                                            cmdPrep.CommandType = 1
                                                            cmdPrep.Prepared = True
                                                            'tim kiem
                                                            If Not IsEmpty(search) Then
                                                                sql = sql & " WHERE Username LIKE ? AND" & sql1
                                                                cmdPrep.Parameters.Append(cmdPrep.CreateParameter("search", 200, 1, 255, "%" & search & "%"))
                                                            Else 
                                                                sql = sql & " WHERE " & sql1
                                                            End If

                                                            cmdPrep.CommandText = sql
                                                            cmdPrep.parameters.Append cmdPrep.createParameter("offset", 3, 1, ,offset)
                                                            cmdPrep.parameters.Append cmdPrep.createParameter("limit", 3, 1, ,limit)

                                                            Set Result = cmdPrep.execute
                                                            do while not Result.EOF
                                                        %>
                                                        <tr>
                                                            <td><%=Result("AccountID")%></td>
                                                            <td><%=Result("Username")%></td>
                                                            <td><%=Result("Password")%></td>
                                                            <td><%=Result("Role")%></td>
                                                            <td>
                                                                <div class="dashboard-option">
                                                                    <a href="EditAccount.asp?id=<%=Result("AccountID")%>" class="dashboard-option-btn dashboard-update"><i class="fa-solid fa-pen"></i></a>
                                                                    <a data-href="deleteAccount.asp?id=<%=Result("AccountID")%>" class="dashboard-option-btn dashboard-delete" data-bs-toggle="modal" data-bs-target="#confirm-delete" title="Delete"><i class="fa-solid fa-trash-can"></i></a>
                                                                </div>
                                                            </td>
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
                                                                <li class="navigation-item"><a href="/dashboard/DBAccount.asp?page=<%=Clng(page) - 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li> 
                                                    <%
                                                            End If

                                                            for i = 1 to range
                                                    %>
                                                                <li class="navigation-item "><a href="/dashboard/DBAccount.asp?page=<%=i%>&search=<%=search%>" class="navigation-link <%=checkPage(Clng(i)=Clng(page),"active")%>"><%=i%></a></li>
                                                    <%
                                                            Next

                                                            If (Clng(page) < pages) Then
                                                    %>
                                                                <li class="navigation-item"><a href="/dashboard/DBAccount.asp?page=<%=Clng(page) + 1%>&search=<%=search%>" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
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
    <div class="modal delete-box" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog modal-form">
            <div class="modal-heading">
                <i class="fa-solid fa-circle-exclamation"></i>
            </div>
            <div class="modal-content">
                <h4>Are you sure ?</h4>
                <p>Do you really want to delete these records ? This process cannot be undone.</p>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear">Delete</a>
                <button type="button" class="modal-btn-cancel" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>  
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script type="text/javascript">
        // click menu
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
        // alert modal
        $(function()
        {
            $('#confirm-delete').on('show.bs.modal', function(e){
                $(this).find('.modal-btn-clear').attr('href', $(e.relatedTarget).data('href'));
            });
        });
    </script>
</body>
</html>