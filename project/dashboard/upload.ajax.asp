<%@ LANGUAGE="VBSCRIPT" CODEPAGE="1252" ENABLESESSIONSTATE="FALSE" LCID="1046" %>
<!--#include file="upload.lib.asp"-->
<% Response.Charset = "ISO-8859-1"

Dim Form : Set Form = New ASPForm
Server.ScriptTimeout = 1440 ' Limite de 24 minutos de execu��o de c�digo, o upload deve acontecer dentro deste tempo ou ent�o ocorre erro de limite de tempo.
Const MaxFileSize = 10240000 ' Bytes. Aqui est� configurado o limite de 100 MB por upload (inclui todos os tamanhos de arquivos e conte�dos dos formul�rios).
If Form.State = 0 Then

	

	For each Field in Form.Files.Items
		' # Field.Filename : Nome do Arquivo que chegou.
		' # Field.ByteArray : Dados bin�rios do arquivo, �til para subir em blobstore (MySQL).
		Field.SaveAs Server.MapPath(".\assets\") & "\img\" & Field.FileName
		Response.Write UTF8_ANSI(Field.FileName)& vbcrlf
	Next
End If

function UTF8_ANSI(x)
    ' Check if do you are using the codepage 1252 or this script doesn't works properly.
    ' Verifique se voc� est� usando o c�digo de p�gina 1252 ou este n�o funcionar� corretamente.
    ' <.%@LANGUAGE="VBSCRIPT" CODEPAGE = "1252" %.>
    Cod = second(now()) + minute(now())
    x=replace(x,chr(226)&chr(128)&chr(156),chr(34))
    x=replace(x,chr(226)&chr(128)&chr(157),chr(34))
    x=replace(x,chr(226)&chr(128)&chr(147),chr(150))
    for ife = 1 to 191 : x=replace(x,chr(195)&chr(ife),chr(ife+64)) : next
    UTF8_ANSI=x
end function


%>
