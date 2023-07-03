<!--#include file="connect.asp"-->
<%
    ''1. Khi người dùng nhập đầy đủ thông tin vào form đăng kí -> gán giá trị của của thẻ input vào các biến tương ứng
    dim user_name, full_name, user_address, user_phone, user_email, pass_word, Sql, AccountID, Resutl_su, Result_check, username_error
    user_name = Request.form("user_name")
    full_name = Request.form("full_name")
    user_address = Request.form("user_address")
    user_phone = Request.form("user_phone")
    user_email = Request.form("user_email")
    pass_word = Request.form("pass_word")

    if ( Not ISNULL(user_name) and trim(user_name)<>"" and Not ISNULL(pass_word)  and trim(pass_word)<>"" and Not ISNULL(full_name) and trim(full_name)<>""and Not ISNULL(user_phone) and trim(user_phone)<>"" and Not ISNULL(user_address)  and trim(user_address)<>"" and Not ISNULL(user_email) and trim(user_email)<>"") then
        connDB.Open()
        set Result_check = connDB.Execute("SELECT COUNT(*) FROM Accounts WHERE Username = '"&user_name&"'" )
        if Result_check(0) > 0 then
        'username_error = "Username already exists!"
        Session("Error") = "Username already exists!"
        else
        ''2. Tạo mới tài khoản vào bảng accounts (insert vào bảng account)
        set Resutl_su = connDB.Execute("INSERT INTO Accounts(Username,[Password],Role) VALUES('"&user_name&"','"&pass_word&"','customer')")
        ''3. Lấy id của khách hàng vừa tạo    
        Sql = "SELECT @@IDENTITY"
        AccountID = connDB.execute(Sql).Fields(0).Value
        ''4. Tạo mới thông tin tài khoản vào bảng customer (insert vào bảng customer)    
        set Resutl_su = connDB.Execute("INSERT INTO Customers(Fullname,PhoneNumber,Address,Email,AccountID) VALUES('"&full_name&"','"&user_phone&"','"&user_address&"','"&user_email&"','"&AccountID&"')" )
        Response.Redirect("login.asp")
        Session("Success") = "Sign up successfully!"
        Resutl_su.Close()
        set Resutl_su = nothing
        connDB.Close()
        set connDB = nothing
        end if    
    else
        Session("Error") = "Please input full information!"
    end if
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>login</title>
    <link rel="icon" type="image/png" href="./assets/img/favicon.jpg"/>
    <link rel="stylesheet" href="/assets/css/login.css">
    <link rel="stylesheet" href="/assets/fonts/fontawesome-free-6.2.0-web/css/all.css">
</head>
<body>
    <section>
        <div class="main">
            <div class="container">
                <div class="login">
                    <div class="login__title register">
                        <p>Sign Up</p>
                    </div>
                    <form method="post" action="SignUp.asp" onsubmit="return check_Validate()" class="login__form" id="login__form">
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_name" class="login__label"><i class="fa-solid fa-user-tie"></i> Account :</label>
                                <input type="text" class="login__input" name="user_name" id="user_name" placeholder="Account">
                            <small id="error_user"></small>
                        </div>
                            <div class="login__group register">
                                <label for="full_name" class="login__label"><i class="fa-solid fa-pen"></i> Name :</label>
                                <input type="text" class="login__input" name="full_name" id="full_name" placeholder="Name">
                                <small id="error_name"></small>
                            </div>
                        </div>
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_phone" class="login__label"><i class="fa-solid fa-phone"></i> Phone :</label>
                                <input type="number" class="login__input" name="user_phone" id="user_phone" placeholder="Phone">
                                <small id="error_phone"></small>
                            </div>
                            <div class="login__group register">
                                <label for="user_email" class="login__label"><i class="fa-solid fa-envelope"></i> Email :</label>
                                <input type="text" class="login__input" name="user_email" id="user_email" placeholder="Email">
                                <small id="error_email"></small>
                            </div>
                        </div>
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_address" class="login__label"><i class="fa-solid fa-location-dot"></i> Address :</label>
                                <input type="text" class="login__input" name="user_address" id="user_address" placeholder="Address-Ward-District-Province/City">
                                <small id="error_address"></small>
                            </div>
                            <div class="login__group register">
                                <label for="pass_word" class="login__label"><i class="fa-solid fa-lock"></i> New  Password :</label>
                                <input type="password" class="login__input" name="pass_word" id="pass_word" placeholder="Password">
                                <small id="error_password"></small>
                            </div>
                        </div>
                        <div class="login__group register login--flex">
                            <div class="login__question setting">
                                <input type="checkbox" name="" id="check">
                                <label for="check">Remember me</label>
                            </div>
                            <div class="login__question setting">
                                <a href="#" class="login__link">Forgot Password ?</a>
                            </div>
                        </div>
                        <div class="login__group register">                            
                            <button class="login__btn" type="submit">Sign Up <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                        <div class="login__group register setting">
                            <% If Not IsEmpty(Session("Error")) Then %>
                                <p id="error"><%= Session("Error") %></p>
                            <% End If %>
                        </div>
                    </form>
                    <div class="login__foot">
                        Have a account ?
                        <a href="Login.asp" class="login__link">Sign In</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        document.getElementById("error").style.color = "red"
        setTimeout(function() {
        var error = document.getElementById("error");
        if (error) {
            error.style.display = "none";
        }
        }, 3000);
        function check_Validate() {
            let check_Value = false
            // error hidden when input event
            const LoginInputs = document.querySelectorAll(".login__input")
            for (let LoginInput of LoginInputs) {
                LoginInput.addEventListener("input",function(){
                    LoginInput.parentElement.classList.remove("login--error")
                    LoginInput.nextElementSibling.innerHTML=""
                })
            }
            // username
            let check_User = document.getElementById("user_name").value
            if (check_User.length === 0) {
                document.getElementById("error_user").innerHTML = "Invalid username"
                document.getElementById("error_user").classList.add("login--error")
                document.getElementById('user_name').parentElement.classList.add("login--error")
                check_Value = true
            }
            else if (check_User.length < 6) {
                document.getElementById("error_user").innerHTML = "Username must be at least 6 characters"
                document.getElementById("error_user").classList.add("login--error")
                document.getElementById('user_name').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                document.getElementById("error_user").innerHTML = ""
                document.getElementById('user_name').parentElement.classList.remove("login--error") 
            }

            // fullname
            let check_Fullname = document.getElementById("full_name").value
            if (check_Fullname.length === 0) {
                document.getElementById("error_name").innerHTML = "Invalid fullname"
                document.getElementById("error_name").classList.add("login--error")
                document.getElementById('full_name').parentElement.classList.add("login--error")
                check_Value = true
            }
            else if (check_Fullname.length < 8) {
                document.getElementById("error_name").innerHTML = "Fullname must be at least 8 characters"
                document.getElementById("error_name").classList.add("login--error")
                document.getElementById('full_name').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                document.getElementById("error_name").innerHTML = ""
                document.getElementById('full_name').parentElement.classList.remove("login--error") 
            }
            // address
            let check_Address = document.getElementById("user_address").value
            if (check_Address.length === 0) {
                document.getElementById("error_address").innerHTML = "Invalid address"
                document.getElementById("error_address").classList.add("login--error")
                document.getElementById('user_address').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                document.getElementById("error_address").innerHTML = ""
                document.getElementById('user_address').parentElement.classList.remove("login--error") 
            }
            //Phone number
            let check_Phone = document.getElementById("user_phone").value
            if (check_Phone.length === 0) {
                document.getElementById("error_phone").innerHTML = "Invalid phone number"
                document.getElementById("error_phone").classList.add("login--error")
                document.getElementById('user_phone').parentElement.classList.add("login--error")
                check_Value = true
            }
            else if (check_Phone.length < 10 || check_Phone.length > 10) {
                document.getElementById("error_phone").innerHTML = "Phone number must be at 10 numbers"
                document.getElementById("error_phone").classList.add("login--error")
                document.getElementById('user_phone').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                document.getElementById("error_phone").innerHTML = ""
                document.getElementById('user_phone').parentElement.classList.remove("login--error") 
            }
            // password
            let check_Password = document.getElementById("pass_word").value
            if (check_Password.length === 0) {
                document.getElementById("error_password").innerHTML = "Invalid password"
                document.getElementById("error_password").classList.add("login--error")
                document.getElementById('pass_word').parentElement.classList.add("login--error")
                check_Value = true
            }
            else if (check_Password.length < 3) {
                document.getElementById("error_password").innerHTML = "Password must be at least 3 characters"
                document.getElementById("error_password").classList.add("login--error")
                document.getElementById('pass_word').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                document.getElementById("error_password").innerHTML = ""
                document.getElementById('pass_word').parentElement.classList.remove("login--error") 
            }

            // email
            let check_Email = document.getElementById("user_email").value
            if (check_Email.length === 0) {
                document.getElementById("error_email").innerHTML = "Invalid address"
                document.getElementById("error_email").classList.add("login--error")
                document.getElementById('user_email').parentElement.classList.add("login--error")
                check_Value = true
            }
            else {
                let regex_email = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
                if (!regex_email.test(check_Email)) {
                    document.getElementById("error_email").innerHTML = "Email is not correct"
                    document.getElementById("error_email").classList.add("login--error")
                    document.getElementById('user_email').parentElement.classList.add("login--error")
                    check_Value = true 
                }
                else {
                    document.getElementById("error_email").innerHTML = ""
                    document.getElementById('user_email').classList.remove("login--error")
                } 
            }

            if(check_Value) {
                return false
            }
        }
    </script>
</body>
</html>
