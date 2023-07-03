
<!-- #include file="connect.asp" -->
<!-- #include file="checkLogin.asp" -->
<%
Dim sql, Image1, Image2, Image3, Image4, Image5, Image6, listColor, listSize, listPromotion, k, v, i, id_details, listQuan, dem, listCate, cate
set listSize = CreateObject("Scripting.Dictionary")
set listColor =CreateObject("Scripting.Dictionary")
set listPromotion =CreateObject("Scripting.Dictionary")
set listCate =CreateObject("Scripting.Dictionary")

' On Error Resume Next
Sub handleError(message)
    Session("Error") = message
End Sub

''Hàm kiểm tra xem productDetails có tồn tại hay không
Function checkID_Details(t, x, p)
    connDB.open()
    sql = "select ProductDetailID from ProductDetails where ProductID = '"&t&"' and ColorID='"&x&"' and SizeID = '"&p&"'"
    set rs = connDB.execute(sql)
    If not rs.EOF Then
        checkID_Details = rs("ProductDetailID")
    Else
        checkID_Details = 0
    End if
    rs.Close
    set rs = nothing
    connDB.close()
End Function


    ''check xem user có tồn tại hay không
    If (isnull(Session("user")) OR TRIM(Session("user")) = "") Then
        Response.redirect("../login.asp")
    End If

    ''Lấy id của sản phẩm
    id = Request.QueryString("id")

    'lấy CateID
    CateID = Request.QueryString("CateID")

    connDB.open()
    ''Lấy danh sách màu
    sql = "select * from Colors"
    Set rs = connDB.execute(sql)
    Do While not rs.EOF
        k = rs("ColorID")
        v = rs("Color")
        listColor.add k, v
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing

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

    ''Lấy danh sách size

    sql = "select * from Sizes"
    Set rs = connDB.execute(sql)
    Do While not rs.EOF
        k = rs("SizeID")
        v = rs("Size")
        listSize.add k, v
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing

    'lấy cateid để trả về trang men , women
     sql = "select * from Categories where CategoryID = '"&CateID&"'"
    Set rs = connDB.execute(sql)
    Do While not rs.EOF
        k = rs("CategoryID")
        v = rs("CategoryName")
        listCate.add k, v
        rs.MoveNext()
    Loop
    rs.Close()
    set rs = nothing

    connDB.close()
    

    If (Request.ServerVariables("REQUEST_METHOD") = "GET") THEN        
        
        If (cint(id)<>0) Then
            
            connDB.Open()
            ''Lấy ra tên, giá, mô tả, id khuyến mại của sản phẩm
            sql = "select Products.ProcductName, Products.[Description], Products.Price, Products.PromotionID,CONCAT( Categories.CategoryName,' ',Categories.Description) as NameCate "
            sql = sql & " from Products inner join Categories on Products.CategoryID = Categories.CategoryID where ProductID = '"&id&"'"
            Set rs = connDB.execute(sql)

            If not rs.EOF Then
                NameCate = rs("NameCate")
                ProductName = rs("ProcductName")
                Price = rs("Price")
                Description = rs("Description")
                PromotionID = rs("PromotionID")
            End if

            rs.Close()
            set rs = nothing

            ''Lấy ra ảnh của sản phẩm
            sql = "select * from ImagePrducts where ProductID = '"&id&"'"
            Set rs = connDB.execute(sql)

            If not rs.EOF Then
                Image1 = rs("Image1")
                Image2 = rs("Image2")
                Image3 = rs("Image3")
                Image4 = rs("Image4")
                Image5 = rs("Image5")
                Image6 = rs("Image6")
            End if
            rs.Close()
            set rs = nothing    
            connDB.Close()

        End If
        
    Else
        ProductName = Request.form("ProductName")
        Description = Request.form("Description")
        PromotionID = Request.form("PromotionID")
        Price = Request.form("Price")
        ColorID= Request.form("Color")
        Image1 = Request.form("p_img1")
        Image2 = Request.form("p_img2")
        Image3 = Request.form("p_img3")
        Image4 = Request.form("p_img4")
        Image5 = Request.form("p_img5")
        Image6 = Request.form("p_img6")

        ''1. Cập nhật tên, giá, mô tả, khuyến mại cho sản phẩm
        connDB.Open()
        
        If cint(PromotionID) <> 0 Then ''nếu có khuyến mại
            sql = "update Products"
            sql = sql & " set ProcductName = '"&ProductName&"', Price = '"&Price&"', [Description] = '"&Description&"', PromotionID ='"&PromotionID&"'"
            sql = sql & " where ProductID = '"&id&"'"
            connDB.execute(sql)
        Else ''Không có khuyến mại
            sql = "update Products"
            sql = sql & " set ProcductName = '"&ProductName&"', Price = '"&Price&"', [Description] = '"&Description&"', PromotionID = NULL "
            sql = sql & " where ProductID = '"&id&"'"
            connDB.execute(sql)
        End if
        connDB.Close()
        

        ''2. Cập nhật chi tiết sô lượng sản phẩm theo size, màu
        
        If Cint(ColorID) <> 0 Then
            ' true
            listQuan = Request.form("Quantity")

            listQuan = Split(listQuan, ", ")
            dem = 0
            for each i in listSize.keys
                id_details = checkID_Details(id, ColorID, i)
                If id_details <> 0 Then
                ''nếu id_productDetail đã tồn tại thì update lại số lượng
                    connDB.Open()
                    sql = "update ProductDetails"
                    sql = sql + " set Quantity = '"&listQuan(dem)&"'"
                    sql = sql + " where ProductDetailID = '"&id_details&"'"
                    connDB.execute(sql)
                    connDB.Close()
                Else '' nếu id_productDetail không tồn tại thì insert dữ liệu vào bảng productDetails
                    connDB.open()
                    sql = "insert into ProductDetails(ProductID, ColorID, SizeID, Quantity) values"
                    sql = sql + " ('"&id&"', '"&ColorID&"', '"&i&"', '"&listQuan(dem)&"')"
                    connDB.execute(sql)
                    connDB.Close()
                End if
                dem = dem + 1
            next
        End if

        ''3. Cập nhật ảnh sản phẩm
        connDB.Open()
        If (id <> 0) then
            sql = "update ImagePrducts"
            sql = sql & " set Image1 = '"&Image1&"', Image2 = '"&Image2&"', Image3= '"&Image3&"', Image4 ='"&Image4&"', Image5 ='"&Image5&"', Image6 ='"&Image6&"'"
            sql = sql & " where ImagePrducts.ProductID = '"&id&"'"
            connDB.execute(sql)
            connDB.Close()
        End If  
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
    <style>
        .dashboard-main-header-search{
            display: none;
        }
        .dashboard-main-header{
            justify-content: flex-end;
        }
    </style>
</head>
<body>
        <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <form method = "POST" action="">
                                <div class="grid wide">
                                    <div class="row">
                                        <div class="col l-12 m-12 c-12">
                                            <h4 class="title"><%=NameCate%></h4>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <div>
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
                                                                <input type="text" id="Description" name="Description" placeholder="Description" value="<%=Description%>">
                                                            </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="Price"><p class="add-description">Price:</p></label>
                                                                <input type="text" min="0" id="Price" name="Price" placeholder="Price" value="<%=Price%>">
                                                            </div>
                                                        </div>
                                                    </div> 
                                               </div>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content">
                                                <div class="form-detail">
                                                    <h4 class="add-text detail">Product Details</h4>
                                                    <a href="#" class="add-option-btn more"><i class="fa-solid fa-plus"></i></a>
                                                    <div id="detail" class="add-detail">
                                                        <div class="row">
                                                            <div class="col l-11 m-10 c-9">
                                                                <div class="add-input">
                                                                    <label for="Color"><p class="add-description">Color:</p></label>
                                                                    <select name="Color" id="Add-color" onclick="showAdd()">
                                                                        <option value="0">Choose color</option>
                                                                        <%
                                                                            For each i in listColor.keys
                                                                        %>
                                                                            <option value="<%=i%>"><%=listColor(i)%></option>
                                                                        <%    
                                                                            Next
                                                                        %>
                                                                        
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
                                                                    
                                                                </div>
                                                            </div>                                                     
                                                        </div> 
                                                    </div>   
                                               </div>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-content last">
                                                <div>
                                                    <h4 class="add-text">Product Imagine</h4>
                                                    <div class="row">
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-1"><p class="add-description">Image 1:</p></label>
                                                                <div class="add-img"><img id="Image1" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image1%>" alt=""></div>
                                                                <input type="text" name="p_img1" id="p_img1" hidden  value="<%=Image1%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-1" name="image-1" class="IMAGE" onchange="UploadFile('image-1')">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-2"><p class="add-description">Image 2:</p></label>
                                                                <div class="add-img"><img id="Image2" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image2%>" alt=""></div>
                                                                <input type="text" name="p_img2" id="p_img2" hidden value="<%=Image2%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-2" name="image-2" class="IMAGE" onchange="UploadFile('image-2')">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-3"><p class="add-description">Image 3:</p></label>
                                                                <div class="add-img"><img id="Image3" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image3%>" alt=""></div>
                                                                <input type="text" name="p_img3" id="p_img3" hidden value="<%=Image3%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-3" name="image-3" class="IMAGE" onchange="UploadFile('image-3')">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-4"><p class="add-description">Image 4:</p></label>
                                                                <div class="add-img"><img id="Image4" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image4%>" alt=""></div>
                                                                <input type="text" name="p_img4" id="p_img4" hidden value="<%=Image4%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-4" name="image-4" class="IMAGE" onchange="UploadFile('image-4')">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-5"><p class="add-description">Image 5:</p></label>
                                                                <div class="add-img"><img id="Image5" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image5%>" alt=""></div>
                                                                <input type="text" name="p_img5" id="p_img5" hidden value="<%=Image5%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-5" name="image-5" class="IMAGE" onchange="UploadFile('image-5')">
                                                             </div>
                                                        </div>
                                                        <div class="col l-4 m-6 c-12">
                                                            <div class="add-input">
                                                                <label for="image-6"><p class="add-description">Image 6:</p></label>
                                                                <div class="add-img"><img id="Image6" onerror="this.src='/assets/img/replace.jpg'" src="<%=Image6%>" alt=""></div>
                                                                <input type="text" name="p_img6" id="p_img6" hidden value="<%=Image6%>">
                                                                <input type="file" accept="image/jpeg, image/png" id="image-6" name="image-6" class="IMAGE" onchange="UploadFile('image-6')">
                                                             </div>
                                                        </div>
                                                    </div>   
                                               </div>
                                            </div>
                                        </div>
                                        <div class="col l-12 c-12 c-12">
                                            <div class="add-setting last">
                                                <button class="add-btn" type="submit">Submit</button>
                                                <%
                                                for each cate in listCate.keys
                                                    If (listCate(cate) <> "Women") Then
                                                %>
                                                <a href="DBMen.asp" class="add-btn cancel">Cancel</a>
                                                <%
                                                    Else 
                                                %>
                                                <a href="DBWomen.asp" class="add-btn cancel">Cancel</a>
                                                <% 
                                                    End If
                                                Next
                                                %>
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

        function UploadFile(inputID) {
            const url = document.getElementById(inputID).files[0]
            let nameImg = url.name
            let srcImg = '../dashboard/assets/img/' + nameImg
            switch(inputID)
            {
                case 'image-1':
                    document.getElementById('Image1').src= srcImg
                    document.getElementById('p_img1').value = srcImg
                    break;
                case 'image-2':
                    document.getElementById('Image2').src = srcImg
                    document.getElementById('p_img2').value = srcImg
                    break;
                case 'image-3':
                    document.getElementById('Image3').src = srcImg
                    document.getElementById('p_img3').value = srcImg
                    break;
                case 'image-4':
                    document.getElementById('Image4').src = srcImg
                    document.getElementById('p_img4').value = srcImg
                    break;
                case 'image-5':
                    document.getElementById('Image5').src = srcImg
                    document.getElementById('p_img5').value = srcImg
                    break;
                case 'image-6':
                    document.getElementById('Image6').src = srcImg
                    document.getElementById('p_img6').value = srcImg
                    break;             
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

        // ajax để hiển thị số lượng sản phẩm tương ứng với size

        $('#Add-color').change(function () {
            var id_color = $(this).val();
            var id_product = <%=id%>;
            var data = {ColorID: id_color, ProductID: id_product};
            console.log(data);
            $.ajax({
                type: "GET",
                url: "SizeQuan.asp",
                data: {ColorID: id_color, ProductID: id_product},
                success: function (response) {
                    $('#list-add').html(response);
                    
                } 
            });
        });
    </script>
</body>
</html>
