<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DESKTOP-NLBPS1S;Database=WEB_BQA1;User Id=sa ;Password=ducanh"
connDB.ConnectionString = strConnection
%>
