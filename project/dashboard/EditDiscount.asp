<!-- #include file="connect.asp" -->
<%
On Error Resume Next
' handle Error
Sub handleError(message)
    Session("Error") = message
    'send an email to the admin
    'Write the error message in an application error log file
End Sub
    If (isnull(Session("user")) OR TRIM(Session("user")) = "") Then
        Response.redirect("/login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Promotions WHERE PromotionID=?"
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                PromotionName = Result("PromotionName")
                DiscountRate = Result("DiscountRate")
                StartDate = Result("StartDate")
                EndDate = Result("EndDate")
            End If

            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        PromotionName = Request.form("PromotionName")
        DiscountRate = Request.form("DiscountRate")
        StartDate = Request.form("StartDate")
        EndDate = Request.form("EndDate")


        if (isnull (id) OR trim(id) = "") then id=0 end if

        if (cint(id)=0) then
            if (NOT isnull(name) and name<>"" and NOT isnull(hometown) and hometown<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "INSERT INTO Promotions(PromotionName,DiscountRate,StartDate,EndDate) VALUES(?,?,?,?)"
                cmdPrep.parameters.Append cmdPrep.createParameter("PromotionName",202,1,50,PromotionName)
                cmdPrep.parameters.Append cmdPrep.createParameter("DiscountRate",14,1, ,DiscountRate)
                cmdPrep.parameters.Append cmdPrep.createParameter("StartDate",7,1, ,StartDate)
                cmdPrep.parameters.Append cmdPrep.createParameter("EndDate",7,1, ,EndDate)

                cmdPrep.execute               
                
                If Err.Number = 0 Then  
                    Session("Success") = "New Promotion added!"                    
                    Response.redirect("DBDiscount.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
        else
            if (NOT isnull(name) and name<>"" and NOT isnull(hometown) and hometown<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                cmdPrep.ActiveConnection = connDB
                cmdPrep.CommandType = 1
                cmdPrep.Prepared = True
                cmdPrep.CommandText = "UPDATE Promotions SET PromotionName=?,DiscountRate=?,StartDate=?,EndDate=? WHERE PromotionID=?"
                cmdPrep.parameters.Append cmdPrep.createParameter("PromotionName",202,1,50,PromotionName)
                cmdPrep.parameters.Append cmdPrep.createParameter("DiscountRate",14,1, ,DiscountRate)
                cmdPrep.parameters.Append cmdPrep.createParameter("StartDate",7,1, ,StartDate)
                cmdPrep.parameters.Append cmdPrep.createParameter("EndDate",7,1, ,EndDate)
                cmdPrep.parameters.Append cmdPrep.createParameter("PromotionID",3,1, ,id)

                cmdPrep.execute
                If Err.Number=0 Then
                    Session("Success") = "The promtion was edited!"
                    Response.redirect("DBDiscount.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "You have to input enough info"
            end if
        end if
    End If    
%>
<!DOCTYPE html>
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
                                <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link active"><p><i class="fa-solid fa-house"></i> Home</p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item">
                                    <a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Men Product</p> <i id="icon" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                    </a>
                                    <ul class="dashboard-menu-list-sub">
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Jeans <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">T-Shirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Polo <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Underwear <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    </ul>
                                </li>
                                <li class="dashboard-menu-item">
                                    <a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Women Product</p> <i id="icon1" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                    </a>
                                    <ul class="dashboard-menu-list-sub">
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Jeans <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">T-Shirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Skirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                        <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Underwear <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    </ul>
                                </li>
                                <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Customer</p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-bag-shopping"></i> Order </p> <i class="fa-solid fa-angle-right"></i></a></li>
                                <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Discount </p> <i class="fa-solid fa-angle-right"></i></a></li>
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
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link active"><p><i class="fa-solid fa-house"></i> Home</p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item">
                                <a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Men Product</p> <i id="icon" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                </a>
                                <ul class="dashboard-menu-list-sub">
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Jeans <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">T-Shirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Polo <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Underwear <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                </ul>
                            </li>
                            <li class="dashboard-menu-item">
                                <a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-box-open"></i> Women Product</p> <i id="icon1" class="dashboard-menu-item-link-icon fa-solid fa-angle-right"></i>
                                </a>
                                <ul class="dashboard-menu-list-sub">
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Jeans <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">T-Shirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Skirt <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                    <li class="dashboard-menu-item-sub"><a href="#" class="dashboard-menu-item-link-sub">Underwear <i class="sub-icon fa-solid fa-angle-right"></i></a></li>
                                </ul>
                            </li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Customer</p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-bag-shopping"></i> Order </p> <i class="fa-solid fa-angle-right"></i></a></li>
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-tag"></i> Discount </p> <i class="fa-solid fa-angle-right"></i></a></li>
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
                                <input type="text" placeholder="Search...">
                                <button><i class="fa-solid fa-magnifying-glass"></i></button>
                            </div>
                            <div class="dashboard-main-header-login">
                                <h4>Admin</h4>
                                <img src="./assets/img/admin.jpg" alt="" class="admin-avatar">
                                <a href="./website/logout.asp" class="dashboard-main-header-login-link">
                                    <i class="nav-icon fa-solid fa-arrow-right-from-bracket"></i>
                                </a>    
                                <!-- <a href="./website/login.asp" class="dashboard-main-header-login-link">
                                    <i class="fa-solid fa-user"></i>
                                    Login
                                </a> -->
                            </div>
                        </div>
                        <div class="dashboard-main-body">
                            <div class="grid wide">
                                <div class="row">
                                    <div class="col l-12 c-12 c-12">
                                        <div class="add-content">
                                            <form method="post">
                                                <h4 class="add-text class="add-description"">Discount info</h4>
                                                <div class="row">
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <input type="text" id="PromotionName" name="PromotionName" placeholder="Discount name" value="<%=PromotionName%>">
                                                         </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">    
                                                            <input type="text" id="DiscountRate" name="DiscountRate" placeholder="Promotion" value="<%=DiscountRate%>">
                                                        </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <p class="add-description">From</p>
                                                            <input type="text" id="StartDate" name="StartDate"placeholder="1/1/2023" value="<%=StartDate%>">
                                                        </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <p class="add-description">To</p>
                                                            <input type="text" id="EndDate" name="EndDate" placeholder="1/12/2023"value="<%=EndDate%>">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="add-setting">
                                                   <button class="add-btn" type="submit">
                                                   <%
                                                        if (id=0) then
                                                            Response.write("Add")
                                                        else
                                                            Response.write("Edit")
                                                        end if
                                                    %>       
                                                   </button>
                                                   <a href="DBDiscount.asp" class="add-btn cancel">Cancel</a>
                                                </div>   
                                           </form>
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
                $(this).toggleClass('click');
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