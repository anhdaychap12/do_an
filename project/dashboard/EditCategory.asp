<!-- #include file="connect.asp" -->
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
            cmdPrep.CommandText = "SELECT * FROM Categories WHERE CategoryID=?"
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                CategoryName = Result("CategoryName")
                Description = Result("Description")
            End If

            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        CategoryName = Request.form("CategoryName")
        Description = Request.form("Description")


        if (isnull (id) OR trim(id) = "") then id=0 end if

        if (cint(id)=0) then
            if (NOT isnull(CategoryName) and Categoryname<>"" and NOT isnull(Description) and Description<>""  ) then
                connDB.Open()  
                sql1 = "INSERT INTO Categories(CategoryName,Description) VALUES('"&CategoryName&"','"&Description&"')"              
                connDB.execute sql1 
                ' Response.write sql1              
                
                If Err.Number = 0 Then  
                    Session("Success") = "New Category added!"                    
                    Response.redirect("DBCategory.asp")  
                Else  
                    handleError(Err.Description)
                End If
                On Error GoTo 0
            else
                Session("Error") = "You have to input enough info"                
            end if
        else
            if (NOT isnull(CategoryName) and CategoryName<>"" and NOT isnull(Description) and Description<>""  ) then
                connDB.Open()                
                sql = "UPDATE Categories SET CategoryName='"&CategoryName&"',Description='"&Description&"' WHERE CategoryID='"&id&"'"
                connDB.execute sql
                ' Response.write sql
                
                If Err.Number=0 Then
                    Session("Success") = "The Category was edited!"
                    Response.redirect("DBCategory.asp")
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
                                            <form method="Post" onsubmit="return checkCategory()">
                                                <h4 class="add-text">Category info</h4>
                                                <div class="row">
                                                    <div class="col l-12 m-12 c-12">
                                                        <div class="add-input">

                                                            <label for="CategoryName"><p class="add-description">Category:</p></label>
                                                            <input type="text" id="CategoryName" name="CategoryName" placeholder="Category name" value="<%=CategoryName%>" required>
                                                            <small id="Error"></small>
                                                         </div>
                                                    </div>
                                                    <div class="col l-12 m-12 c-12">
                                                        <div class="add-input">
                                                            <label for="Description"><p class="add-description">Description:</p></label>
                                                            <input type="text" id="Description" name="Description" placeholder="Description" value="<%=Description%>" required>
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
                                                   <a href="DBCategory.asp" class="add-btn cancel">Cancel</a>
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

        function checkCategory() {
            var check_Category = document.getElementById("CategoryName").value;
            if (check_Category !== "Men" && check_Category !== "Women") {
                document.getElementById("Error").innerHTML = "Please enter Men or Women!";
                document.getElementById("CategoryName").style.border = "red 1px solid";
                document.getElementById("Error").style.color = "red";
                return false;
            } else {
                document.getElementById("Error").innerHTML = "";
                document.getElementById("CategoryName").style.border = "none";
                return true;
            }
        }
    </script>
</body>
</html>