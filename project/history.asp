<!-- #include file="connect.asp" -->
<!--#include file="layout/header.asp"-->
<%
    if IsEmpty(session("user")) then
    Response.redirect("/login.asp")
    end if
    ''1. lấy id khách hàng
    Dim CusID, SQL_ID, dictOrderID, STT, IdOrder
    connDB.Open()
    set rs = connDB.execute("SELECT CustomerID from Customers inner join Accounts on Customers.AccountID = Accounts.AccountID where Username = '"&session("user")&"'")
    if not rs.EOF then
    CusID = rs("CustomerID")
    end if
    rs.Close()
    set rs = nothing
    ''2. Lấy danh sách id_order(dùng dictionary key:biến i tự tăng, value: order_id)
    set dictOrderID = CreateObject("Scripting.Dictionary")
    set rs = connDB.execute("select Orders.OrderID from Orders where CustomerID = '"&CusID&"'")
    STT = 0
    Do While not rs.EOF 
        STT = STT + 1
        IdOrder = rs("OrderID")
        dictOrderID.add STT,IdOrder
        rs.MoveNext()
    Loop
    rs.close()
    set rs = nothing
    connDB.Close()
%>
<body>
    <div class="main">
        <div class="history">
            <div class="grid wide">
                <div class="row product-wrap">
                    <div class="product-title">
                        <h2><span>History order</span></h2>
                        <p>Bring called seed first of third give itself now ment</p>
                    </div>
                </div>
                <%
                    if dictOrderID.count  = 0 then
                        Response.Write ("<h3 class=""no-history"">Your history is empty!</h3>")
                    else
                %>
                <div class="row">
                    <div class="col l-12 m-12 c-12">
                        <div class="history-list">
                            <%
                            '3. Dùng vòng lặp dictionary ->xuất ra danh sách hàng hóa của từng hóa đơn
                            connDB.Open()
                            for each Y in dictOrderID.keys
                                SQL_ID = "SELECT Orders.*, ShippingFrees.Price as ShippingPrice, Orders.TotalAmount, cast(OrderDate as date) as OrderDATE FROM Orders inner join ShippingFrees on ShippingFrees.ShippingFreeID = Orders.ShippingFreeID  WHERE Orders.OrderID = '"&dictOrderID(Y)&"' "                         
                            set rs = connDB.execute(SQL_ID)
                            If not rs.EOF Then
                        %>
                        <div class="history-order">
                            <div class="row">
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content origin">
                                        <p>Order ID: <span><%=rs("OrderID")%></span></p>
                                        <a href="Confirm.asp?OrderID=<%=rs("OrderID")%>" class="history-details">Details</a>
                                    </div>
                                </div>
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content fake">
                                        <p>Phone</p>
                                        <h4><%=rs("Phone")%></h4>
                                    </div>
                                </div>
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content">
                                        <p>Shipping</p>
                                        <h4>$<%=rs("ShippingPrice")%><h4>
                                    </div>
                                </div>
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content fake">
                                        <p>Total</p>
                                        <h4 class="history-total">$<%=rs("TotalAmount")%></h4>
                                    </div>
                                </div>
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content">
                                        <p>Ordered On</p>
                                        <h4><%=rs("OrderDate")%></h4>
                                    </div>
                                </div>
                                <div class="col l-2 m-6 c-12">
                                    <div class="history-content fake">
                                        <p>Status</p>
                                        <h4 class="history-title">Ongoing</h4>
                                    </div>
                                </div>
                            </div>
                            <p class="history-info">To Address: <span><%=rs("Address")%></span></p>
                        </div>
                        <%
                                End if
                                rs.Close()
                                set rs = nothing
                            Next
                            connDB.Close()
                            end if   
                        %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="main.js"></script>
        <!--#include file="layout/footer.asp"-->
    </div>
</body>