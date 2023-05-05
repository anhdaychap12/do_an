<%
    If Session("user") = "" or trim(Session("user")) = "" or Session("Role") <> "admin" Then
        Response.redirect("login.asp")
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
    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="./assets/css/responsove.css">
    <link rel="stylesheet" href="./assets/css/Grid.css">
    <link rel="stylesheet" href="./assets/fonts/fontawesome-free-6.2.0-web/css/all.min.css">
</head>
<body>
    <div class="main">
        <div class="header-admin">
            <div class="grid wide">
                <div class="row">
                    <div class="header-admin-logo">
                        <img src="./assets/img/logo.jpg" alt="">
                    </div>
                    <div class="header-admin-login">
                        <img src="./assets/img/admin.jpg" alt="" class="admin-avatar">
                        <a href="logout.asp" class="header-admin-login-link">
                            <i class="nav-icon fa-solid fa-arrow-right-from-bracket"></i>
                        </a>
                        <!-- <a href="" class="header-admin-login-link">
                            <i class="fa-solid fa-user"></i>
                            Login
                        </a> -->
                    </div>
                </div>
            </div>
        </div>
        <div class="body-admin">
            <div class="grid wide">
                <div class="row">
                    <div class="col l-12 m-12 c-12">
                        <div class="body-admin-title">
                            <h2>Database Manager</h2>
                        </div>
                    </div>
                    <div class="col l-3 m-12 c-12">
                        <div class="admin-menu">
                            <h4><i class="fa-solid fa-bars"></i> <span>Menu</span></h4>
                            <ul class="admin-menu-list">
                                <li class="admin-menu-item">
                                    <a href="#" class="admin-menu-item-link demo">Product Manager</a>
                                    <ul class="sub-admin-list">
                                        <li class="sub-admin-item"><a href="#" class="sub-admin-item-link" onclick="filterObjects('Men')">Men</a>
                                            <ul class="sub-admin-menu">
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Men')">Jeans</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Men')">T-Shirt</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Men')">Polo</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Men')">Underwear</a>
                                                </li>
                                            </ul>
                                        </li>
                                        <li class="sub-admin-item">
                                            <a href="#" class="sub-admin-item-link" onclick="filterObjects('Women')">Women</a>
                                            <ul class="sub-admin-menu">
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Women')">Jeans</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Women')">T-Shirt</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Women')">Skirt</a>
                                                </li>
                                                <li class="sub-admin-menu-item">
                                                    <a href="#" class="sub-admin-menu-item-link" onclick="filterObjects('Women')">Underwear</a>
                                                </li>
                                            </ul>
                                        </li>
                                    </ul>
                                </li>
                                <li class="admin-menu-item"><a href="#" class="admin-menu-item-link demo" onclick="filterObjects('Customer')">Customer Manager</a></li>
                                <li class="admin-menu-item"><a href="#" class="admin-menu-item-link demo" onclick="filterObjects('Order')">Order Manager</a></li>
                                <li class="admin-menu-item"><a href="#" class="admin-menu-item-link demo" onclick="filterObjects('Discount')">Discount and Sales</a></li>
                            </ul>
                        </div>
                    </div>
                    <div class="col l-9 m-12 c-12">
                        <div class="row">
                            <div class="col l-12 m-12 c-12 Box Men">
                                <div class="admin-content-product">
                                    <div class="admin-content-text">
                                        <h4>Men</h4>
                                        <a href="" class="admin-option-btn admin-create">Create</a>
                                    </div>
                                    <div class="form">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Brand</th>
                                                    <th>Price</th>
                                                    <th>Sold</th>
                                                    <th>Stock</th>
                                                    <th>Total</th>
                                                    <th>Option</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Jeans Cowboy</td>
                                                    <td>Eiser</td>
                                                    <td>100000</td>
                                                    <td>12</td>
                                                    <td>6</td>
                                                    <td>600000</td>
                                                    <td>
                                                        <div class="admin-option">
                                                            <a href="" class="admin-option-btn admin-update">Update</a>
                                                            <a href="" class="admin-option-btn admin-delete">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="page">
                                        <ul class="navigation">
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">1</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">2</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">3</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">4</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
                                        </ul>
                                    </div>
                                </div>                                
                            </div>
                            <div class="col l-12 m-12 c-12 Box Women">
                                <div class="admin-content-product">
                                    <div class="admin-content-text">
                                        <h4>Women</h4>
                                        <a href="" class="admin-option-btn admin-create">Create</a>
                                    </div>
                                    <div class="form">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Brand</th>
                                                    <th>Price</th>
                                                    <th>Sold</th>
                                                    <th>Stock</th>
                                                    <th>Total</th>
                                                    <th>Option</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Jeans Cowboy</td>
                                                    <td>Eiser</td>
                                                    <td>100000</td>
                                                    <td>12</td>
                                                    <td>6</td>
                                                    <td>600000</td>
                                                    <td>
                                                        <div class="admin-option">
                                                            <a href="" class="admin-option-btn admin-update">Update</a>
                                                            <a href="" class="admin-option-btn admin-delete">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="page">
                                        <ul class="navigation">
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">1</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">2</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">3</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">4</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
                                        </ul>
                                    </div>
                                </div>                                
                            </div>
                            <div class="col l-12 m-12 c-12 Box Customer">
                                <div class="admin-content-customer">
                                    <div class="admin-content-text">
                                        <h4>Customer</h4>
                                    </div>
                                    <div class="form">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Phone</th>
                                                    <th>Country</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Hồ Xuân Thủy</td>
                                                    <td>0922908349</td>
                                                    <td>Viet Nam</td>
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
                            <div class="col l-12 m-12 c-12 Box Order">
                                <div class="admin-content-order">
                                    <div class="admin-content-text">
                                        <h4>Order</h4>
                                    </div>
                                    <div class="form">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Brand</th>
                                                    <th>Price</th>
                                                    <th>Sold</th>
                                                    <th>Stock</th>
                                                    <th>Total</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Jeans Cowboy</td>
                                                    <td>Eiser</td>
                                                    <td>100000</td>
                                                    <td>12</td>
                                                    <td>6</td>
                                                    <td>600000</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="page">
                                        <ul class="navigation">
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">1</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">2</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">3</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">4</a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-right"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                            <div class="col l-12 m-12 c-12 Box Discount">
                                <div class="admin-content-product">
                                    <div class="admin-content-text">
                                        <h4>Discount</h4>
                                        <a href="" class="admin-option-btn admin-create">Create</a>
                                    </div>
                                    <div class="form">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Card</th>
                                                    <th>Sales</th>
                                                    <th>Date</th>
                                                    <th>Apply</th>
                                                    <th>Option</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>1</td>
                                                    <td>Black Friday</td>
                                                    <td>40%</td>
                                                    <td>30/4/2023-1/5/2023</td>
                                                    <td>All</td>
                                                    <td>
                                                        <div class="admin-option">
                                                            <a href="" class="admin-option-btn admin-update">Update</a>
                                                            <a href="" class="admin-option-btn admin-delete">Delete</a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="page">
                                        <ul class="navigation">
                                            <li class="navigation-item"><a href="#" class="navigation-link"><i class="fa-solid fa-chevron-left"></i></a></li>
                                            <li class="navigation-item"><a href="#" class="navigation-link">1</a></li>
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
        <div class="footer">
            <div class="grid wide">
                <div class="row">
                    <div class="col l-2 m-6 c-12">
                        <h4>Top Products</h4>
                        <ul class="footer-content-list">
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Managed Website</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Manage Reputation</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Power Tools</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Marketing Service</a></li>
                        </ul>
                    </div>
                    <div class="col l-2 m-6 c-12">
                        <h4>Quick Links</h4>
                        <ul class="footer-content-list">
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Jobs</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Brand Assets</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Investor Relations</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Terms of Service</a></li>
                        </ul>
                    </div>
                    <div class="col l-2 m-6 c-12">
                        <h4>Features</h4>
                        <ul class="footer-content-list">
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Jobs</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Brand Assets</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Investor Relations</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Terms of Service</a></li>
                        </ul>
                    </div>
                    <div class="col l-2 m-6 c-12">
                        <h4>Resources</h4>
                        <ul class="footer-content-list">
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Guides</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Research</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Experts</a></li>
                            <li class="footer-content-item"><a href="" class="footer-content-item-link">Agencies</a></li>
                        </ul>
                    </div>
                    <div class="col l-4 m-12 c-12">
                        <h4>Newsletter</h4>
                        <p class="footer-heading">You can trust us, we only send promo offers.</p>
                        <div class="footer-text">
                            <form>
                                <input type="text" placeholder="Your Email Address" required>
                                <button>Subscribe</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col l-8 m-12 c-12">
                        <p class="footer-text-social">
                            Copyright © <script>document.write(new Date().getFullYear());</script>
                            All rights reserved | This template is made with 
                            <i class="fa-solid fa-heart"></i>                         
                            by 
                            <a href="https://colorlib.com" target="_blank">Colorlib</a>
                        </p> 
                    </div>
                    <div class="col l-4 m-12 c-12">
                        <ul class="footer-social-list">
                            <li class="footer-social-item"><a href="" class="footer-social-item-link"><i class="fa-brands fa-facebook"></i></a></li>
                            <li class="footer-social-item"><a href="" class="footer-social-item-link"><i class="fa-brands fa-twitter"></i></a></li>
                            <li class="footer-social-item"><a href="" class="footer-social-item-link"><i class="fa-brands fa-dribbble"></i></a></li>
                            <li class="footer-social-item"><a href="" class="footer-social-item-link"><i class="fa-brands fa-behance"></i></a></li>
                        </ul>
                    </div>   
                </div>
            </div>
        </div>
    </div>
    <div class="modal delete-box" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog modal-form">
            <div class="modal-heading">
                <h3 class="">Delete Confirmation</h3>
            </div>
            <div class="modal-content">
                <p>Are you sure ?</p>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear">Delete</a>
                <button type="button" class="modal-btn-cancel" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
    <script src="main.js"></script>
</body>
</html>