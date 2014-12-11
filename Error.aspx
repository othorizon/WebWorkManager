<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <%
        Response.Write(Request.QueryString["msg"]);
        try
        {
            HttpCookie cookie = Request.Cookies["UserStatus"];
            cookie.Expires = DateTime.Now;
            Response.Cookies.Add(cookie);
        }
        catch
        { }
        %>
 <a    href="#"    onclick="javascript:history.back();">返回</a>

</asp:Content>

