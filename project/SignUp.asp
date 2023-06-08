<!--#include file="connect.asp"-->
<%
    ''1. Khi người dùng nhập đầy đủ thông tin vào form đăng kí -> gán giá trị của của thẻ input vào các biến tương ứng
    ''2. Tạo mới thông tin tài khoản vào bảng customer (insert vào bảng customer)
    ''3. Lấy id của khách hàng vừa tạo (dùng 2 câu lệnh ở dưới để lấy id cus vừa mới tạo) (không hiểu thì nghiên cứu file checkout nhé !)
        ' sql = "SELECT @@IDENTITY"
        ' OrderID = connDB.execute(sql).Fields(0).Value
    ''4. Tạo mới tài khoản vào bảng accounts (insert vào bảng account)
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
                        <p>Sign In</p>
                    </div>
                    <form method="post" action="register.asp" class="login__form" id="login__form">
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_name" class="login__label"><i class="fa-solid fa-user-tie"></i> Account :</label>
                                <input type="text" class="login__input" name="user_name" id="user_name" placeholder="Account">
                            <small></small>
                        </div>
                            <div class="login__group register">
                                <label for="full_name" class="login__label"><i class="fa-solid fa-pen"></i> Name :</label>
                                <input type="text" class="login__input" name="full_name" id="full_name" placeholder="Name">
                                <small></small>
                            </div>
                        </div>
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_phone" class="login__label"><i class="fa-solid fa-phone"></i> Phone :</label>
                                <input type="number" class="login__input" name="user_phone" id="user_phone" placeholder="Phone">
                                <small></small>
                            </div>
                            <div class="login__group register">
                                <label for="user_email" class="login__label"><i class="fa-solid fa-envelope"></i> Email :</label>
                                <input type="email" class="login__input" name="user_email" id="user_email" placeholder="Email">
                                <small></small>
                            </div>
                        </div>
                        <div class="login__wrap">
                            <div class="login__group register">
                                <label for="user_address" class="login__label"><i class="fa-solid fa-location-dot"></i> Address :</label>
                                <input type="text" class="login__input" name="user_address" id="user_address" placeholder="Address">
                                <small></small>
                            </div>
                            <div class="login__group register">
                                <label for="pass_word" class="login__label"><i class="fa-solid fa-lock"></i> New  Password :</label>
                            <input type="password" class="login__input" name="pass_word" id="pass_word" placeholder="Password">
                            <small></small>
                        </div>
                        </div>
                        <div class="login__group register login--flex">
                            <small></small>
                            <div class="login__question setting">
                                <input type="checkbox" name="" id="check">
                                <label for="check">Remember me</label>
                            </div>
                            <div class="login__question setting">
                                <a href="" class="login__link">Forgot Password ?</a>
                            </div>
                        </div>
                        <div class="login__group register">                            
                            <button class="login__btn" type="submit">Sign In <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                        <div class="login__group register setting">
                            <p id="error"><%=Session("error")%></p>
                        </div>
                    </form>
                    <div class="login__foot">
                        Not a member
                        <a href="Login.asp" class="login__link">Sign Up</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var error = document.getElementById('error');
        var input__user = document.getElementById('user_name')
        var input__pass = document.getElementById('pass_word')
        var input__fullname = document.getElementById('full_name')
        var input__phone = document.getElementById('user_phone')
        var input__email = document.getElementById('user_email')
        var input__address = document.getElementById('user_address')
        error.style.color = "red"
        if (error.textContent) {
            input__user.parentElement.classList.add("login--error")
            input__pass.parentElement.classList.add("login--error")
            input__fullname.parentElement.classList.add("login--error")
            input__phone.parentElement.classList.add("login--error")
            input__email.parentElement.classList.add("login--error")
            input__address.parentElement.classList.add("login--error")
        }
    </script>
</body>
</html>
