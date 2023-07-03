<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->
<%
Dim sql, listPromotion, k, v, i, id_details, listQuan, dem, cateId
set listPromotion =CreateObject("Scripting.Dictionary")

' On Error Resume Next
Sub handleError(message)
    Session("Error") = message
End Sub

    ''lấy cateId
    cateId = Request.QueryString("CateID")

    connDB.open()
    

    ''Lấy danh sách Promotion
    sql = "SELECT * FROM Promotions"
    set rs = connDB.execute(sql)
    Do While not rs.EOF
        k = rs("PromotionID")
        v = rs("PromotionName")
        listPromotion.add k ,v
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing

    connDB.close()   

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
                            <form method = "POST" action="" onsubmit="return checkAddProduct()">
                                <div class="grid wide">
                                    <div class="row">
                                        <div class="col l-12 m-12 c-12">
                                            <h4 class="title">Men Jeans</h4>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <div>
                                                    <h4 class="add-text">Product info</h4>
                                                    <div class="row">
                                                        <div class="col l-8 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="ProductName"><p class="add-description">Product name:</p></label>
                                                                <input class="addInput" type="text" id="ProductName" name="ProductName" placeholder="Product name" value="<%=ProductName%>">
                                                                <small id="Error_ProductName" class="errorAdd"></small>
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="PromotionID"><p class="add-description">PromotionID:</p></label>
                                                                <select id = "PromotionID" name="PromotionID">
                                                                    <option value="0">Choose</option>
                                                                    <%
                                                                        For each i in listPromotion.keys
                                                                    %>
                                                                            <option value="<%=i%>"><%=listPromotion(i)%></option>
                                                                    <%
                                                                        next
                                                                    %>
                                                                    <option value="2">6/6</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="col l-8 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="Description"><p class="add-description">Description:</p></label>
                                                                <input class="addInput" type="text" id="Description" name="Description" placeholder="Description" value="<%=Description%>">
                                                                <small id="Error_Description" class="errorAdd"></small>
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="Price"><p class="add-description">Price:</p></label>
                                                                <input class="addInput" type="text" min="0" id="Price" name="Price" placeholder="Price" value="<%=Price%>">
                                                                <small id="Error_Price" class="errorAdd"></small>
                                                            </div>
                                                        </div>
                                                    </div> 
                                               </div>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-setting last">
                                                <button class="add-btn" type="button" onclick="addPro()">Submit</button>
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
        <div class="modal-dialog modal-form ADD">
            <div class="modal-heading success">
                <i class="fa-regular fa-circle-check"></i>
            </div>
            <div class="modal-content">
                <h4>Success!</h4>
                <b id = "messenger"></b>
            </div>
            <div class="modal-option">
                <a class="modal-btn modal-btn-clear" id="next">Update Quantity</a>
                <button type="button" class="modal-btn-cancel" data-bs-dismiss="modal" onclick="CloseConfirm()">Cancel</button>
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

        // ajax để hiển thị số lượng sản phẩm tương ứng với size.
        function checkAddProduct() {
            const addInputs = document.querySelectorAll(".addInput");
            let isValid = true;
            for (let addInput of addInputs) {
                addInput.addEventListener("input", () => {
                    addInput.style.border = "";
                    addInput.nextElementSibling.innerHTML=""
                });
                if (addInput.value.trim() === "") {
                    document.getElementById("Error_" + addInput.id).innerHTML = "Invalid " + addInput.id + "!";
                    addInput.style.border = "red 1px solid";
                    document.getElementById("Error_" + addInput.id).style.color = "red";
                    isValid = false;
                } else {
                    document.getElementById("Error_" + addInput.id).innerHTML = "";
                    addInput.style.border = "";
                }
            }
            return isValid;
        }

        function addPro() {
            if (checkAddProduct()) {
                var ProductName = $('#ProductName').val();
                var Description = $('#Description').val();
                var PromotionID = $('#PromotionID').val();
                var Price = $('#Price').val();
                var CateID = <%=cateId%>;
                data = { ProductName, Description, PromotionID, Price, CateID };
                $('#confirm-delete').css("display", "block");
                $.ajax({
                    type: "GET",
                    url: "AjaxAddProduct.asp",
                    data: data,
                    success: function (response) {
                        $('#messenger').html(response.message);
                        var id = response.id_Pro;
                        $("#next").attr("href", "EditProduct.asp?id=" + id);
                    }
                });
            }
        }

        // function addPro() {
        //     var ProductName = $('#ProductName').val();
        //     var Description = $('#Description').val();
        //     var PromotionID = $('#PromotionID').val();
        //     var Price = $('#Price').val();
        //     var CateID = <%=cateId%>;
        //     data = {ProductName, Description, PromotionID, Price, CateID};
        //     $('#confirm-delete').css("display", "block");
        //     $.ajax({
        //         type: "GET",
        //         url: "AjaxAddProduct.asp",
        //         data: data,
        //         success: function (response) {
        //             $('#messenger').html(response.message);
        //             var id = response.id_Pro;
        //             $("#next").attr("href", "EditProduct.asp?id="+id);
        //         } 
        //     });
        // }

        const modal = document.querySelector('.delete-box') 
        const modalForm = document.querySelector('.modal-form')
        modal.addEventListener('click',CloseConfirm)
        modalForm.addEventListener('click',function(e){
            e.stopPropagation();
        })

        function CloseConfirm(){
            document.getElementById('confirm-delete').style.display = "none";
        }
    </script>
</body>
</html>