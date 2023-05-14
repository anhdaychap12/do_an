<!-- #include file="connect.asp" -->
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
        <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <form>
                                <div class="grid wide">
                                    <div class="row">
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <form action="Post">
                                                    <h4 class="add-text">Product info</h4>
                                                    <div class="row">
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">
                                                                <input type="text" id="ProductName" name="ProductName" placeholder="Product name">
                                                             </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">   
                                                                <input type="text" id="CategoryName" name="CategoryName" placeholder="Category Name">
                                                            </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">   
                                                                <input type="text" id="PromotionID" name="PromotionID" placeholder="PromotionID ">
                                                            </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">
                                                                <input type="text" id="Description" name="Description" placeholder="Description">
                                                            </div>
                                                        </div>
                                                    </div>  
                                               </form>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <form action="Post">
                                                    <h4 class="add-text">Product Details</h4>
                                                    <div class="row">
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">    
                                                                <input type="text" id="Size" name="Size" placeholder="Size">
                                                            </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">
                                                                <input type="text" id="Color" name="Color" placeholder="Color">
                                                            </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">
                                                                <input type="number" id="Quantity" name="Quantity" placeholder="Quantity">
                                                             </div>
                                                        </div>
                                                        <div class="col l-6 m-6 c-12">
                                                            <div class="add-input">
                                                                <input type="text" id="Price" name="Price" placeholder="Price">
                                                            </div>
                                                        </div>
                                                    </div>   
                                               </form>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content last">
                                                <form action="Post">
                                                    <h4 class="add-text">Product Imagine</h4>
                                                    <div class="row">
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-img">
                                                                <ul class="add-img-menu">
                                                                    <li><a href="" class="add-img-btn"><i class="fa-solid fa-plus"></i></a></li>
                                                                    <li><a href="" class="remove-img-btn"><i class="fa-solid fa-trash-can"></i></a></li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>   
                                               </form>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-setting last">
                                                <button class="add-btn" type="submit">Submit</button>
                                                <a href="Dashboard.asp" class="add-btn cancel">Cancel</a>
                                             </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal delete-box" tabindex="-1" id="confirm-delete">
        <div class="modal-dialog modal-form">
            <div class="modal-heading upload">
                <h3 class="">Upload file</h3>
            </div>
            <div class="modal-content">
                <form action="Post">
                    <div class="modal-upload">
                        <input type="file" id="file" name="file">
                        <label for="file" class="modal-upload-btn">Choose a file</label>
                    </div>
                </form>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear">Insert</a>
                <button type="button" class="modal-btn-cancel" data-bs-dismiss="modal">Close</button>
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