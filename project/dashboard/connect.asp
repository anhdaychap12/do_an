<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
<<<<<<< HEAD
strConnection = "Provider=SQLOLEDB.1;Data Source=DESKTOP-NLBPS1S;Database=WEB_BQA1;User Id=sa ;Password=ducanh"
=======
strConnection = "Provider=SQLOLEDB.1;Data Source=PHUC\SQLEXPRESS;Database=WEB_BQA1;User Id=sa ;Password=01052002"
>>>>>>> 13b71924e1713ea9675e642e4618b2633815543f
connDB.ConnectionString = strConnection
%>