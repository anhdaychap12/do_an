<!-- #include file="connect.asp" -->
<%
    dim p_user, p_pass, p_name, p_phone, p_email, p_address, p_img, id_acc, p_SQL

    If isEmpty(session("user")) then
        Response.redirect("/login.asp")
    else
        connDB.Open()
        set rs = connDB.execute("select * from Customers inner join Accounts on Customers.AccountID = Accounts.AccountID where Username = '"&session("user")&"'")    
        if NOT rs.EOF then
            id_acc = rs("AccountID")
            p_user = rs("Username")
            p_pass = rs("Password")
            p_name = rs("Fullname")
            p_phone = rs("PhoneNumber")
            p_email = rs("Email")
            p_address = rs("Address")
            p_img = rs("Image")
        end if
        rs.Close()
        set rs = nothing
        If Request.ServerVariables("REQUEST_METHOD") = "POST" Then
            p_user = Request.form("p_user")
            p_pass = Request.form("p_pass")
            p_name = Request.form("p_name")
            p_phone = Request.form("p_phone")
            p_email = Request.form("p_email")
            p_address = Request.form("p_address")
            p_SQL = "UPDATE Customers SET Fullname = '"&p_name&"', PhoneNumber = '"&p_phone&"', Email = '"&p_email&"', Address = '"&p_address&"' WHERE Customers.AccountID = '"&id_acc&"'" 
            p_SQL = p_SQL + "UPDATE Accounts SET Username ='"&p_user&"', Password = '"&p_pass&"' WHERE Accounts.AccountID = '"&id_acc&"'"
            set rs = connDB.execute(p_SQL)
        end if  
        connDB.close()    
        set connDB = nothing
    end if    
%>      
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
        <!--#include file="layout/header.asp"-->
        <div class="infomation">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>My Profile</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <form method="Post" id="form-info" onsubmit="return check_Validate()" class="info-form">
                    <div class="row">
                        <div class="col l-3 m-4 c-12">
                            <div class="info-img">
                                <img src="<%=p_img%>" alt="">
                                <div class="upload-img">
                                    <input type="file" accept="image/png, image/jpeg ,image/jpg" id="image" name="image" class="upload-file">
                                    <label for="image" class="upload-img-btn"><i class="fa-solid fa-camera"></i></label>
                                </div>
                            </div>
                        </div>
                        <div class="col l-9 m-8 c-12">
                            <div class="info-text">
                                <h4>Info</h4>
                                <div class="info-form-item">
                                    <p>Account:</p>
                                    <input class="input-check" id="user_name" name ="p_user" type="text" placeholder="Account" value="<%=p_user%>">
                                    <small class="error-info" id="error_user"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-item">
                                    <p>Password:</p>
                                    <input class="input-check" id="pass_word" name ="p_pass" type="password" placeholder="Password" value="<%=p_pass%>">
                                    <small class="error-info" id="error_password"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-item">
                                    <p>Name:</p>
                                    <input class="input-check" id="full_name" name ="p_name" type="text" placeholder="Name" value="<%=p_name%>">
                                    <small class="error-info" id="error_name"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-item">
                                    <p>Phone:</p>
                                    <input class="input-check" id="user_phone" name ="p_phone" type="number" placeholder="Phone" value="<%=p_phone%>">
                                    <small class="error-info" id="error_phone"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-item">
                                    <p>Email:</p>
                                    <input class="input-check" id="user_email" name ="p_email" type="text" placeholder="Email" value="<%=p_email%>">
                                    <small class="error-info" id="error_email"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-item">
                                    <p>Address:</p>
                                    <input class="input-check" id="user_address" name ="p_address" type="text" placeholder="Address" value="<%=p_address%>">
                                    <small class="error-info" id="error_address"></small>
                                    <i class="btn-edit fa-solid fa-pen"></i>
                                </div>
                                <div class="info-form-setting">
                                    <button class="btn-save" type="submit"><i class="fa-solid fa-floppy-disk"></i> Save</button>
                                    <a href="profile.asp" class="btn-save cancel"><i class="fa-solid fa-ban"></i> Cancel</a>
                                </div>
                            </div>
                        </div>
                    </div>         
                </form>
            </div>
        </div>
        <!--#include file="layout/footer.asp"-->
    <div id="confirm-delete" tabindex="-1" class="modal delete-box profile">
        <div class="modal-dialog modal-form">
            <div class="modal-heading">
                <i class="fa-regular fa-circle-check"></i>
            </div>
            <div class="modal-content">
                <h4>Success!</h4>
                <p>Your profile is saved!</p>
            </div>
            <div class="modal-option">
                <button type="button" onclick="CloseConfirm()" class="modal-btn-cancel">Close</button>
            </div>
        </div>
    </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-/bQdsTh/da6pkI1MST/rWKFNjaCP5gBSY4sEBT38Q/9RBh9AH40zEOg7Hlq2THRZ" crossorigin="anonymous"></script>
    <script src="main.js"></script>
    <script>
        
        $(function() {
            $('#form-info').submit(function(event) {
                event.preventDefault();
                $.ajax({
                url: 'profile.asp',
                type: 'POST',
                data: $(this).serialize(),
                success: function(data) {
                    document.getElementById('confirm-delete').style.display = "block";
                },
                error: function() {
                    alert('Form error!');
                }
                });
            });
        });

        const modal = document.querySelector('.delete-box') 
        const modalForm = document.querySelector('.modal-form')
        modal.addEventListener('click',CloseConfirm)
        modalForm.addEventListener('click',function(e){
            e.stopPropagation();
        })

        function CloseConfirm(){
            document.getElementById('confirm-delete').style.display = "none";
        }

        $(function()
        {
            $("#confirm-delete").on("show.bs.modal", function(e){
                $(this).find(".modal-btn-clear").attr("href", $(e.relatedTarget).data("href"));
            });
        });

        function check_Validate() {
            let check_Value = false
            // error hidden when input event
            const checkInputs = document.querySelectorAll(".input-check")
            const infoItems = document.querySelectorAll(".info-form-item")
            const errorInfos =  document.querySelectorAll(".error-info")
            for (let checkInput of checkInputs) {
                checkInput.addEventListener("input",function(){
                    for(let infoItem of infoItems) {
                        infoItem.classList.remove("error-check")
                        for(let errorInfo of errorInfos) {
                            errorInfo.innerHTML=""
                        }   
                    }
                })
            }
            // username
            let check_User = document.getElementById("user_name").value
            if (check_User.length === 0) {
                document.getElementById("error_user").innerHTML = "Invalid username"
                document.getElementById("error_user").classList.add("error-check")
                document.getElementById('user_name').parentElement.classList.add("error-check")
                check_Value = true
            }
            else if (check_User.length < 6) {
                document.getElementById("error_user").innerHTML = "Username must be at least 6 characters"
                document.getElementById("error_user").classList.add("error-check")
                document.getElementById('user_name').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                document.getElementById("error_user").innerHTML = ""
                document.getElementById('user_name').parentElement.classList.remove("error-check") 
            }

            // fullname
            let check_Fullname = document.getElementById("full_name").value
            if (check_Fullname.length === 0) {
                document.getElementById("error_name").innerHTML = "Invalid fullname"
                document.getElementById("error_name").classList.add("error-check")
                document.getElementById('full_name').parentElement.classList.add("error-check")
                check_Value = true
            }
            else if (check_Fullname.length < 8) {
                document.getElementById("error_name").innerHTML = "Fullname must be at least 8 characters"
                document.getElementById("error_name").classList.add("error-check")
                document.getElementById('full_name').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                document.getElementById("error_name").innerHTML = ""
                document.getElementById('full_name').parentElement.classList.remove("error-check") 
            }
            // address
            let check_Address = document.getElementById("user_address").value
            if (check_Address.length === 0) {
                document.getElementById("error_address").innerHTML = "Invalid address"
                document.getElementById("error_address").classList.add("error-check")
                document.getElementById('user_address').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                document.getElementById("error_address").innerHTML = ""
                document.getElementById('user_address').parentElement.classList.remove("error-check") 
            }
            //Phone number
            let check_Phone = document.getElementById("user_phone").value
            if (check_Phone.length === 0) {
                document.getElementById("error_phone").innerHTML = "Invalid phone number"
                document.getElementById("error_phone").classList.add("error-check")
                document.getElementById('user_phone').parentElement.classList.add("error-check")
                check_Value = true
            }
            else if (check_Phone.length < 10 || check_Phone.length > 10) {
                document.getElementById("error_phone").innerHTML = "Phone number must be at 10 numbers"
                document.getElementById("error_phone").classList.add("error-check")
                document.getElementById('user_phone').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                document.getElementById("error_phone").innerHTML = ""
                document.getElementById('user_phone').parentElement.classList.remove("error-check") 
            }
            // password
            let check_Password = document.getElementById("pass_word").value
            if (check_Password.length === 0) {
                document.getElementById("error_password").innerHTML = "Invalid password"
                document.getElementById("error_password").classList.add("error-check")
                document.getElementById('pass_word').parentElement.classList.add("error-check")
                check_Value = true
            }
            else if (check_Password.length < 3) {
                document.getElementById("error_password").innerHTML = "Password must be at least 3 characters"
                document.getElementById("error_password").classList.add("error-check")
                document.getElementById('pass_word').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                document.getElementById("error_password").innerHTML = ""
                document.getElementById('pass_word').parentElement.classList.remove("error-check") 
            }

            // email
            let check_Email = document.getElementById("user_email").value
            if (check_Email.length === 0) {
                document.getElementById("error_email").innerHTML = "Invalid address"
                document.getElementById("error_email").classList.add("error-check")
                document.getElementById('user_email').parentElement.classList.add("error-check")
                check_Value = true
            }
            else {
                let regex_email = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
                if (!regex_email.test(check_Email)) {
                    document.getElementById("error_email").innerHTML = "Email is not correct"
                    document.getElementById("error_email").classList.add("error-check")
                    document.getElementById('user_email').parentElement.classList.add("error-check")
                    check_Value = true 
                }
                else {
                    document.getElementById("error_email").innerHTML = ""
                    document.getElementById('user_email').classList.remove("error-check")
                } 
            }

            if(check_Value) {
                return false
            }
        }
    </script>
</body>
</html>