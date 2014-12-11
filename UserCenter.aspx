<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserCenter.aspx.cs" Inherits="UserCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>个人中心</title>
</head>
<body>
    <%
        HttpCookie cookie = Request.Cookies["UserStatus"];
        if (cookie != null)
        {
            if (cookie.Values["type"].Equals("student"))
                Server.Transfer("StudentCenter.aspx?worktype=" + Request.QueryString["worktype"]);
            else
                if (cookie.Values["type"].Equals("teacher"))
                    Server.Transfer("TeacherCenter.aspx?classid=" + Request.QueryString["classid"]);
                else
                {
                    cookie.Expires = DateTime.Now;
                    Response.Cookies.Add(cookie);
                    Response.Redirect("Login.aspx");
                }
        }
        else
        {
            Response.Redirect("Error.aspx?msg=用户信息错误");
            cookie.Expires = DateTime.Now;
            Response.Cookies.Add(cookie);
        }
    %>
</body>
</html>
