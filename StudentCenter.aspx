<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StudentCenter.aspx.cs" Inherits="StudentCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   用户名： <%=Request.Cookies["UserStatus"].Values["username"]%><br />
    用户类型：<%=Request.Cookies["UserStatus"].Values["type"] %>
</asp:Content>

