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
                        <a href="" class="header-admin-login-link">
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
        <div class="add">
            <div class="grid wide">
                <div class="row">
                    <div class="col l-12 m-12 c-12">
                        <div class="body-admin-title">
                            <h2>Service</h2>
                        </div>
                    </div>
                    <div class="col l-12 c-12 c-12">
                        <div class="add-content">
                            <form action="Post" class="add-text">
                                <h4>Create / Update</h4>
                                <div class="add-input">
                                   <p>Name:</p>
                                   <input type="text" id="name" name="name">
                                </div>
                                <div class="add-input">
                                    <p>Brand:</p>
                                    <input type="text" id="brand" name="brand">
                                </div>
                                <div class="add-input">
                                    <p>Price:</p>
                                    <input type="text" id="price" name="price">
                                </div>
                                <div class="add-input">
                                    <p>Sold:</p>
                                    <input type="number" id="sold" name="sold">
                                </div>
                                <div class="add-input">
                                    <p>Stock:</p>
                                    <input type="number" id="stock" name="stock">
                                </div>
                                <div class="add-input">
                                    <p>Total:</p>
                                    <input type="text" id="total" name="total">
                            </div>
                               <div class="add-setting">
                                   <button class="add-btn" type="submit">Submit       
                                   </button>
                                   <a href="database.asp" class="add-btn cancel">Cancel</a>
                               </div>   
                           </form>
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
</body>
</html>