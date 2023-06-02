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
        If (isnull(id) OR trim(id) = "") then 
            id=0 
        End if
        If (cint(id)<>0) Then
            Set cmdPrep = Server.CreateObject("ADODB.Command")
            connDB.Open()
            cmdPrep.ActiveConnection = connDB
            cmdPrep.CommandType = 1
            cmdPrep.CommandText = "SELECT * FROM Accounts WHERE AccountID=? and Role = 'admin'"
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                Username = Result("Username")
                Password = Result("Password")
                Role = Result("Role")
            End If

            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        Username = Request.form("Username")
        Password = Request.form("Password")


        if (isnull (id) OR trim(id) = "") then id=0 end if

        if (cint(id)=0) then
            if (NOT isnull(Username) and Username<>"" and NOT isnull(Password) and Password<>""  ) then
                connDB.Open()  
                sql1 = "INSERT INTO Accounts(Username,Password,Role) VALUES('"&Username&"','"&Password&"','admin')"              
                connDB.execute sql1 
                ' Response.write sql1              
                
                If Err.Number = 0 Then  
                    Session("Success") = "New Account added!"                    
                    Response.redirect("DBAccount.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
        else
            if (NOT isnull(Username) and Username<>"" and NOT isnull(Password) and Password<>""  ) then
                connDB.Open()                
                sql = "UPDATE Accounts SET Username='"&Username&"',Password='"&Password&"',Role='admin' WHERE AccountID='"&id&"'"
                connDB.execute sql
                ' Response.write sql
                
                If Err.Number=0 Then
                    Session("Success") = "The Account was edited!"
                    Response.redirect("DBAccount.asp")
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
                            <div class="grid wide">
                                <div class="row">
                                    <div class="col l-12 c-12 c-12">
                                        <div class="add-content">
                                            <form method="Post" onsubmit="return validateRole();">
                                                <h4 class="add-text">Account info</h4>
                                                <div class="row">
                                                    <div class="col l-12 m-12 c-12">
                                                        <div class="add-input">

                                                            <label for="Username"><p class="add-description">Username:</p></label>
                                                            <input type="text" id="Username" name="Username" placeholder="Username" value="<%=Username%>" required>

                                                         </div>
                                                    </div>
                                                    <div class="col l-12 m-12 c-12">
                                                        <div class="add-input">
                                                            <label for="Password"><p class="add-description">Password:</p></label>
                                                            <input type="text" id="Password" name="Password" placeholder="Password" value="<%=Password%>" required>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="add-setting">
                                                    <button class="add-btn" type="submit">
                                                   <%
                                                        if (id=0) then
                                                            Response.write("Add")
                                                        else
                                                            Response.write("Edit")
                                                        end if
                                                    %>              
                                                   </button>
                                                   <a href="DBAccount.asp" class="add-btn cancel">Cancel</a>
                                                </div>   
                                           </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
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
                $(this).toggleClass('click');
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
    <script>
        function validateRole() {
        var role = document.getElementById("Role").value;
        if (role !== "admin") {
            alert("Role must be admin!");
            return false;
        }
        return true;
        }
    </script>
</body>
</html>