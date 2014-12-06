<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>用户登陆</title>
    <style type="text/css">
        .auto-style1 {
            width: 300px;
            height:120px;
            float:right;
        }

        .auto-style3 {       
            text-align: left;
        }


    </style>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="height:150px"></div>
   
     <div class="auto-style1" style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label1" runat="server" Text="登录名：" Width="80px"></asp:Label>
                    <asp:TextBox ID="tb_username" runat="server" Width="90px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ControlToValidate="tb_username">用户名不能为空</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label2" runat="server" Text="用户类型：" Width="80px"></asp:Label>
                    <asp:DropDownList ID="ddl_type" runat="server">
                        <asp:ListItem Value="student">学生</asp:ListItem>
                        <asp:ListItem Value="teacher">教师</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style3">
                    <asp:Label ID="Label3" runat="server" Text="密码：" Width="80px"></asp:Label>
                    <asp:TextBox ID="tb_pwd" runat="server" Width="90px" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ControlToValidate="tb_pwd">密码不能为空</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="auto-style3" >
                    <asp:Label ID="Label4" runat="server" Text="保存登陆状态:"></asp:Label>
                    <asp:DropDownList ID="ddl_expires" runat="server">
                        <asp:ListItem Value="不保存">不保存</asp:ListItem>
                        <asp:ListItem>一天</asp:ListItem>
                        <asp:ListItem>一周</asp:ListItem>
                        <asp:ListItem>一个月</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="auto-style3" style="text-align:center">
                    <asp:Button ID="Button1" runat="server" Style="text-align: center; height: 21px;" Text="登陆" Width="62px" OnClick="Button1_Click" />
                </td>
            </tr>
            </table>




    </div>
</asp:Content>


