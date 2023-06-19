<!--#include file="connect.asp"-->
<%
    Dim user_name, pass_word, Result
    user_name = Request.form("user_name")
    pass_word = Request.form("pass_word")
    
    connDB.Open()
    set Result = connDB.execute("select * from Accounts where Username = '"&user_name&"' and [Password] = '"&pass_word&"'")
    If user_name <> "" and trim(user_name) <> "" and pass_word <> "" and trim(pass_word) <> "" Then
        If not Result.EOF Then
            Session("user") = user_name
            Session("success") = "Login Successfull!"
            Session("Role") = Result("Role")
            If Result("Role") <> "admin" then
                Response.redirect("index.asp")
            Else
                Response.redirect("dashboard/Dashboard.asp")
            end If
        Else
            Session("error") = "Wrong username or password"
        End if
    Else
        Session("error") = "Please input username and password"
    End if
    Result.Close()
    set Result = nothing
    connDB.Close()
    set connDB = nothing
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
                <div class="img">
                </div>
                <div class="login">
                    <div class="login__title">
                        <p>Sign In</p>
                    </div>
                    <form method="post" action="login.asp" onsubmit="return check_Validate()" class="login__form" id="login__form">
                        <div class="login__group">
                            <label for="user_name" class="login__label"><i class="fa-solid fa-user-tie"></i> Username :</label>
                            <input type="text" class="login__input" name="user_name" id="user_name" placeholder="Username">
                            <small id ="error_user"></small>
                        </div>
                        <div class="login__group">
                            <label for="pass_word" class="login__label"><i class="fa-solid fa-lock"></i> Password :</label>
                            <input type="password" class="login__input" name="pass_word" id="pass_word" placeholder="Password">
                            <small id="error_password"></small>
                        </div>
                        <div class="login__group">                            
                            <button class="login__btn" type="submit">Sign In <i class="fa-solid fa-arrow-right"></i></button>
                        </div>
                        <div class="login__group login--flex">
                            <small></small>
                            <div class="login__question">
                                <input type="checkbox" name="" id="check">
                                <label for="check">Remember me</label>
                            </div>
                            <div class="login__question">
                                <p><a href="" class="login__link">Forgot Password ?</a></p>
                            </div>
                        </div>
                        <div class="login__group">
                            <p id="error"><%=Session("error")%></p>
                        </div>
                    </form>
                    <div class="login__foot">
                        Not a member ?
                        <a href="SignUp.asp" class="login__link">Sign Up</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        document.getElementById('error').style.color = "red"
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

            if(check_Value) {
                return false
            }
        }
    </script>
</body>
</html>