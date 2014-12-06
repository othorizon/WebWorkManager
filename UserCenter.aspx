<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserCenter.aspx.cs" Inherits="UserCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
<%
    HttpCookie cookie = Request.Cookies["UserStatus"];
    if(cookie.Values["type"].Equals("student"))
        Server.Transfer("StudentCenter.aspx");
    else if (cookie.Values["type"].Equals("teacher"))
        Server.Transfer("TeacherCenter.aspx");
    else
    {
        cookie.Expires = DateTime.Now;
        Response.Cookies.Add(cookie);
        Response.Redirect("Login.aspx");
    }
     %>
</body>
</html>
