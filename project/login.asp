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
                Response.redirect("database.asp")
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
                    <form method="post" action="login.asp" class="login__form" id="login__form">
                        <div class="login__group">
                            <label for="user_name" class="login__label"><i class="fa-solid fa-user-tie"></i> Username :</label>
                            <input type="text" class="login__input" name="user_name" id="user_name" placeholder="Username">
                            <small></small>
                        </div>
                        <div class="login__group">
                            <label for="pass_word" class="login__label"><i class="fa-solid fa-lock"></i> Password :</label>
                            <input type="password" class="login__input" name="pass_word" id="pass_word" placeholder="Password">
                            <small></small>
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
                        Not a member
                        <a href="" class="login__link">Sign Up</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script>
        var error = document.getElementById('error');
        var input__user = document.getElementById('user_name')
        var input__pass = document.getElementById('pass_word')
        error.style.color = "red"
        if (error.textContent) {
            input__user.parentElement.classList.add("login--error")
            input__pass.parentElement.classList.add("login--error")
        }
    </script>
</body>
</html>