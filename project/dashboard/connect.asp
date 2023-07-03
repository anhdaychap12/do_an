<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<%
'code here
Dim connDB
set connDB = Server.CreateObject("ADODB.Connection")
Dim strConnection
strConnection = "Provider=SQLOLEDB.1;Data Source=DESKTOP-85SJOGH\SQLASP;Database=WEB_BQA1;User Id=sa ;Password=123"
connDB.ConnectionString = strConnection
%>

