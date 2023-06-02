<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->
<%
On Error Resume Next
Sub handleError(message)
    Session("Error") = message
End Sub
    If (isnull(Session("user")) OR TRIM(Session("user")) = "") Then
        Response.redirect("../login.asp")
    End If
    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        id = Request.QueryString("id")
        If (isnull(id) OR trim(id) = "" ) then 
            id=0 
        End if
        If (cint(id)<>0 ) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "select Products.*, ProductDetails.*, ImagePrducts.*,Sizes.*,Colors.* " &_
            "from (((Products inner join ProductDetails on Products.ProductID = ProductDetails.ProductID) inner join ImagePrducts on Products.ProductID = ImagePrducts.ProductID) inner join Sizes on ProductDetails.SizeID = Sizes.SizeID) inner join Colors on ProductDetails.ColorID = Colors.ColorID " &_
            "where Products.ProductID = ? "
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                ProductName = Result("ProcductName")
                Price = Result("Price")
                PromotionID = Result("PromotionID")
                Description = Result("Description")
                Quantity = Result("Quantity")
                Image1 = Result("Image1")
                Image2 = Result("Image2")
                Image3 = Result("Image3")
                Image4 = Result("Image4")
                Image5 = Result("Image5")
                Image6 = Result("Image6")

            End If

            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        ProductName = Request.form("ProcductName")
        Price = Request.form("Price")
        PromotionID = Request.form("PromotionID")
        Description = Request.form("Description")
        Image1 = Request.form("Image1")
        Image2 = Request.form("Image2")
        Image3 = Request.form("Image3")
        Image4 = Request.form("Image4")
        Image5 = Request.form("Image5")
        Image6 = Request.form("Image6")



        if (isnull (id) OR trim(id) = "") then id=0 end if

        if (cint(id)=0) then
            if (NOT isnull(PromotionName) and PromotionName<>"" and NOT isnull(DiscountRate) and DiscountRate<>"" and NOT isnull(StartDate) and StartDate<>"" and NOT isnull(EndDate) and EndDate<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()  
                sql1 = "INSERT INTO Promotions(PromotionName,DiscountRate,StartDate,EndDate) VALUES('"&PromotionName&"','"&DiscountRate&"','"&StartDate&"','"&EndDate&"')"              
                connDB.execute sql1 
                ' Response.write sql1              
                
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
            if (NOT isnull(PromotionName) and PromotionName<>"" and NOT isnull(DiscountRate) and DiscountRate<>"" and NOT isnull(StartDate) and StartDate<>"" and NOT isnull(EndDate) and EndDate<>"") then
                Set cmdPrep = Server.CreateObject("ADODB.Command")
                connDB.Open()                
                sql = "UPDATE Promotions SET PromotionName='"&PromotionName&"',DiscountRate='"&DiscountRate&"',StartDate='"&StartDate&"',EndDate='"&EndDate&"' WHERE PromotionID='"&id&"'"
                connDB.execute sql
                ' Response.write sql
                
                If Err.Number=0 Then
                    Session("Success") = "The promotion was edited!"
                    Response.redirect("DBDiscount.asp")
                Else
                    handleError(Err.Description)
                End If
                On Error Goto 0
            else
                Session("Error") = "You have to input enough info"
                    Response.write(Session("Error"))

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
        <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <form>
                                <div class="grid wide">
                                    <div class="row">
                                        <div class="col l-12 m-12 c-12">
                                            <h4 class="title">Men Jeans</h4>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <form action="Post">
                                                    <h4 class="add-text">Product info</h4>
                                                    <div class="row">
                                                        <div class="col l-8 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="ProductName"><p class="add-description">Product name:</p></label>
                                                                <input type="text" id="ProductName" name="ProductName" placeholder="Product name" value="<%=ProductName%>">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="PromotionID"><p class="add-description">Discount ID:</p></label>
                                                                <input type="text" id="PromotionID" name="PromotionID" placeholder="Enter Number" value="<%=PromotionID%>">
                                                            </div>
                                                        </div>
                                                        <div class="col l-8 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="Description"><p class="add-description">Description:</p></label>
                                                                <input type="text" id="Description" name="Description" placeholder="Description" value="<%=Description%>">
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="Price"><p class="add-description">Price:</p></label>
                                                                <input type="text" min="0" id="Price" name="Price" placeholder="Price">
                                                            </div>
                                                        </div>
                                                    </div>  
                                               </form>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <form action="Post" class="form-detail">
                                                    <h4 class="add-text detail">Product Details</h4>
                                                    <a href="#" class="add-option-btn more"><i class="fa-solid fa-plus"></i></a>
                                                    <div id="detail" class="add-detail">
                                                        <div class="row">
                                                            <div class="col l-11 m-10 c-9">
                                                                <div class="add-input">
                                                                    <label for="Color"><p class="add-description">Color:</p></label>
                                                                    <select name="Color" id="Add-color" onclick="showAdd()">
                                                                        <option value="0">Choose color</option>
                                                                        <option value="1">BLUE</option>
                                                                        <option value="2">BLACK</option>
                                                                        <option value="3">WHITE</option>
                                                                        <option value="4">GREEN</option>
                                                                        <option value="5">NAVY</option>
                                                                        <option value="6">GRAY</option>
                                                                        <option value="7">RED</option>
                                                                        <option value="8">ORANGE</option>
                                                                        <option value="9">OFF WHITE</option>
                                                                        <option value="10">PINK</option>
                                                                        <option value="11">LIGHT BLUE</option>
                                                                        <option value="12">BROWN</option>
                                                                        <option value="13">NATURAL</option>
                                                                        <option value="14">BEIGE</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="col l-1 m-2 c-3">
                                                                <div class="add-input detail-remove">
                                                                    <a href="#" class="add-option-btn del"><i class="fa-solid fa-minus"></i></a>
                                                                </div>
                                                            </div>
                                                            <div class="col l-12 c-12 m-12">
                                                                <div id="list-add" class="Add-list">
                                                                    <div class="row no-gutters">
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">S</a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">M</a>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div>
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">L</a>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">XL</a>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">2XL</a>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-1 m-3 c-4">
                                                                            <div class="add-input">
                                                                                <p class="add-description">Size:</p>
                                                                                <a href="#" class="size-item">3XL</a>
                                                                            </div>
                                                                        </div> 
                                                                        <div class="col l-11 m-9 c-8">
                                                                            <div class="add-input">
                                                                                <label for="Quantity"><p class="add-description">Quantity:</p></label>
                                                                                <input type="number" min="0" id="Quantity" name="Quantity" placeholder="Quantity">
                                                                            </div>
                                                                        </div>  
                                                                    </div>
                                                                </div>
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
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 1:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 2:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 3:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 4:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 5:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image"><p class="add-description">Image 6:</p></label>
                                                                <div class="add-img"><img onerror="this.src='/assets/img/replace.jpg'" src="../assets/img/product.jpg" alt=""></div>
                                                                <input type="file" id="image" name="image">
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

        function showAdd() {
            var x = document.getElementById("Add-color").value
            if (x != "0") {
                document.getElementById("list-add").classList.add("add-block")
            }

            else {
                document.getElementById("list-add").classList.remove("add-block")
            }
        }

        $(document).ready(function(){
            
            $(".add-option-btn.more").click(function(){
                $(".form-detail .add-detail:last-child").clone().appendTo(".form-detail")   
            });
            $(document).on("click",".add-option-btn.del",function(){
                if($(".form-detail .add-detail").length > 1) {
                    $(this).parents(".add-detail").remove(); 
                }
            });
        });
    </script>
</body>
</html>