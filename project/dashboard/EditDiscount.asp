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
            cmdPrep.CommandText = "SELECT * FROM Promotions WHERE PromotionID=?"
            cmdPrep.Parameters(0)=id
            Set Result = cmdPrep.execute 

            If not Result.EOF then
                PromotionName = Result("PromotionName")
                DiscountRate = Result("DiscountRate")
                StartDate = Result("StartDate")
                EndDate = Result("EndDate")
            End If

            Result.Close()
        End If
    Else
        id = Request.QueryString("id")
        PromotionName = Request.form("PromotionName")
        DiscountRate = Request.form("DiscountRate")
        StartDate = Request.form("StartDate")
        EndDate = Request.form("EndDate")


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
                Response.write sql
                
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
    <style>
        .dashboard-main-header-search {
            display: none;
        }
        .dashboard-main-header {
            justify-content: flex-end;
        }
    </style>
</head>
<body>
            <!--#include file="menu.nav.asp"-->
                        <div class="dashboard-main-body">
                            <div class="grid wide">
                                <div class="row">
                                    <div class="col l-12 c-12 c-12">
                                        <div class="add-content">
                                            <form method="post"   onsubmit="return validateDiscountRate() && validateDate() && validateDateFormat1() && validateDateFormat() && convertDates();">
                                                <h4 class="add-text">Discount info</h4>
                                                <div class="row">
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <label for="PromotionName"><p class="add-description">Promotion name:</p></label>
                                                            <input type="text" id="PromotionName" name="PromotionName" placeholder="Discount name" value="<%=PromotionName%>" required>
                                                            <small id="error_name"></small>
                                                         </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">    
                                                            <label for="DiscountRate"><p class="add-description">Promotion:</p></label>
                                                            <input type="number" id="DiscountRate" name="DiscountRate" placeholder="Promotion (0-100)"  value="<%=DiscountRate%>" required>
                                                            <small id="error_discount"></small>
                                                        </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <label for="StartDate"><p class="add-description">From:</p></label>
                                                            <input type="date" id="StartDate" name="StartDate"placeholder="mm/dd/yyyy" value="<%=StartDate%>" required>
                                                            <small id="error_startdate"></small>
                                                        </div>
                                                    </div>
                                                    <div class="col l-6 m-6 c-12">
                                                        <div class="add-input">
                                                            <label for="EndDate"><p class="add-description">To:</p></label>
                                                            <input type="date" id="EndDate" name="EndDate" placeholder="mm/dd/yyyy"value="<%=EndDate%>" required>
                                                            <small id="error_enddate"></small>
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
                                                   <a href="DBDiscount.asp" class="add-btn cancel">Cancel</a>
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
        function validateDiscountRate() {
        document.getElementById("DiscountRate").addEventListener("input",()=>{
            document.getElementById("error_discount").innerHTML ="";
            document.getElementById("DiscountRate").style.border= ""
        })    
        var discountRate = document.getElementById("DiscountRate").value;
        if (discountRate < 0 || discountRate > 100) {
            document.getElementById("error_discount").innerHTML ="Discount rate must be between 0 and 100!";
            document.getElementById("error_discount").style.color = "red";
            document.getElementById("DiscountRate").style.border= "red  1px solid"
            return false;
        }
        else{
            document.getElementById("error_discount").innerHTML ="";
            return true;
        }
        }
        function validateDate() {    
        var startDate = new Date(document.getElementById("StartDate").value);
        var endDate = new Date(document.getElementById("EndDate").value);
        if (endDate <= startDate) {
            document.getElementById("error_enddate").innerHTML ="End date must be after start date!";
            document.getElementById("error_enddate").style.color = "red";
            document.getElementById("EndDate").style.border= "red  1px solid"
            return false;
        }
        else{
            document.getElementById("error_enddate").innerHTML ="";
            return true;
        }
        }
        
        function convertDates() {
        var startDateInput = document.getElementById("StartDate");
        var endDateInput = document.getElementById("EndDate");

        var startDate = moment(startDateInput.value, "MM/DD/YYYY").format("MM/DD/YYYY");
        var endDate = moment(endDateInput.value, "MM/DD/YYYY").format("MM/DD/YYYY");

        startDateInput.value = startDate;
        endDateInput.value = endDate;
        }
    </script>
</body>
</html>
