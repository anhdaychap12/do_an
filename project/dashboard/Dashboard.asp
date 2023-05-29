<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->


<%
    connDB.open()
    Set cmdPrep = Server.CreateObject("ADODB.Command")
    cmdPrep.ActiveConnection = connDB
    cmdPrep.CommandType = 1
    cmdPrep.Prepared = True
    
    
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
        <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <div class="grid wide">
                                <%
                                    cmdPrep.CommandText = "SELECT COUNT(ProductID) AS countPro FROM Products  "
                                    Set Result = cmdPrep.execute
                                    do while not Result.EOF
                                %>
                                <div class="row">
                                    <div class="col l-3 m-6 c-12">
                                        <div class="dashboard-stats-item">
                                            <i class="fa-solid fa-box-open"></i>
                                            <div class="dashboard-stats-item-info">
                                                <h4><%= Result("countPro") %></h4>
                                                <p>Products</p>
                                            </div>
                                        </div>
                                        <%
                                        Result.MoveNext
                                        loop
                                        %>
                                    </div>
                                <%
                                        cmdPrep.CommandText = "SELECT COUNT(ProductDetailID) AS countProdet FROM OrderDetails  "
                                    Set Result2 = cmdPrep.execute
                                    do while not Result2.EOF
                                %>
                                    <div class="col l-3 m-6 c-12">
                                        <div class="dashboard-stats-item">
                                            <i class="fa-solid fa-cart-shopping"></i>
                                            <div class="dashboard-stats-item-info">
                                                <h4><%= Result2("countProdet") %></h4>
                                                <p>Products Sold</p>
                                            </div>
                                            <%
                                                Result2.MoveNext
                                                loop
                                            %>
                                        </div>
                                    </div>
                                    <%
                                        cmdPrep.CommandText = "SELECT COUNT(CustomerID) AS countCus FROM Customers "
                                        Set Result3 = cmdPrep.execute
                                        do while not Result3.EOF
                                    %>
                                    <div class="col l-3 m-6 c-12">
                                        <div class="dashboard-stats-item">
                                            <i class="fa-solid fa-users"></i>
                                            <div class="dashboard-stats-item-info">
                                                <h4><%= Result3("countCus") %></h4>
                                                <p>Customers</p>
                                            </div>
                                            <%
                                                Result3.MoveNext
                                                loop
                                            %>
                                        </div>
                                    </div>
                                    <%
                                            cmdPrep.CommandText = "select SUM(TotalAmount) as sum from Orders "
                                        Set Result4 = cmdPrep.execute
                                        do while not Result4.EOF
                                    %>
                                    <div class="col l-3 m-6 c-12">
                                        <div class="dashboard-stats-item">
                                            <i class="fa-solid fa-arrow-trend-up"></i>
                                            <div class="dashboard-stats-item-info">
                                                <h4><%= Result4("sum") %></h4>
                                                <p>Total revenue</p>
                                            </div>
                                        </div>
                                        <%
                                                Result4.MoveNext
                                                loop
                                        %>
                                    </div>
                                    
                                    <div class="col l-12 m-12 c-12 ">
                                        <div class="chart-title">
                                            <h3 class="chart-content">Total sales revenue (monthly)</h3>
                                        </div>
                                        <div class="chart-total">
                                            <canvas id="dashboard-map"> </canvas>
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
        });
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
    <%
        cmdPrep.CommandText = "SELECT MONTH(StartDate) AS month, SUM(DiscountRate) AS sum1 FROM Promotions WHERE YEAR(StartDate) = 2023 GROUP BY MONTH(StartDate);"
        Set Result5 = cmdPrep.execute
        
        Dim dataJSON
        dataJSON = "["
        
        do while not Result5.EOF
            dataJSON = dataJSON & "{"
            dataJSON = dataJSON & """month"": """ & Result5("month") & ""","
            dataJSON = dataJSON & """sum1"": """ & Result5("sum1") & """"
            dataJSON = dataJSON & "},"
            
            Result5.MoveNext
        loop
        
        ' Xóa dấu phẩy cuối cùng
        dataJSON = Left(dataJSON, Len(dataJSON) - 1)
        dataJSON = dataJSON & "]"
    %>

    <script>
    var data = JSON.parse('<%= dataJSON %>');

    var labels = [];
    var values = [];

    for (var i = 0; i < data.length; i++) {
        labels.push(data[i].month);
        values.push(data[i].sum1);
    }

    var ctx = document.getElementById('dashboard-map').getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels:labels ,
            datasets: [{
                label: 'Total revenue',
                data: values,
                backgroundColor: '#4f98c3',
                borderColor: '#4f98c3',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero: true
                    }
                }]
            }
        }
    });
</script>

</body>
</html>