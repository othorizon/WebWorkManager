<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="失败 StudentCenter.aspx.cs" Inherits="StudentCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>个人中心</title>
    <style type="text/css">
        .touming {
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000');
            background-color: rgba(255, 255, 255,0.3);
        }
    </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
    </div>

    <div style="text-align: left;">
        <asp:Label ID="lb_name" runat="server"></asp:Label>
        当前所选班级：
     
        <asp:DropDownList ID="ddl_Class" runat="server" AutoPostBack="True">
        </asp:DropDownList>
        &nbsp;&nbsp;
        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">注销</asp:LinkButton>
    </div>
    <div style="height: 10px"></div>

    <div id="dvsetting" style="width: 300px; margin-left: 0px; position: absolute">
        相关设置
    </div>

    <div id="dvwork" runat="server" style="cursor: pointer; width: 600px; position: absolute; margin-left: 620px">
    </div>

    <script type="text/javascript">//随屏幕滚动
        window.onscroll = function () {
            document.getElementById("dvsetting").style.top = +parseInt(document.documentElement.scrollTop, 10) + 100 + "px";
        }
    </script>


</asp:Content>

