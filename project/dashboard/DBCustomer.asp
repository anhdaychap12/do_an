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
                                <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Account</p> <i class="fa-solid fa-angle-right"></i></a></li>
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
                            <li class="dashboard-menu-item"><a href="#" class="dashboard-menu-item-link"><p><i class="fa-solid fa-users"></i> Account</p> <i class="fa-solid fa-angle-right"></i></a></li>
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
                                                            <th>Email</th>
                                                            <th>Address</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td>1</td>
                                                            <td>Hồ Xuân Thủy</td>
                                                            <td>0922908349</td>
                                                            <td>thuy@gmail.com</td>
                                                            <td>Ha Noi</td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <div class="page">
                                                <ul class="navigation">
                                                    <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li>
                                                    <li class="navigation-item"><a href="#" class="navigation-link actvie">1</a></li>
                                                    <li class="navigation-item"><a href="#" class="navigation-link">2</a></li>
                                                    <li class="navigation-item"><a href="#" class="navigation-link">3</a></li>
                                                    <li class="navigation-item"><a href="#" class="navigation-link">4</a></li>
                                                    <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
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