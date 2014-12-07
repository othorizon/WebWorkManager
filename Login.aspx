<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>用户登陆</title>
    <style type="text/css">
        .auto-style1 {
            width: 250px;
            height:100%;
            float:right;
        }

        .auto-style3 {       
            text-align: left;
        }
        </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" runat="server" ContentPlaceHolderID="ContentPlaceHolder1">
    <div style="height:150px"></div>
   <div style="margin:0 auto;height:20px" id="dvregister" runat="server">   
   </div>
     <div class="auto-style1" id="dvlogin" style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
        <table class="auto-style1">
            <tr>
                <td class="auto-style3">
                    <div id="registermsg" style="opacity:0;height:0px; text-align:center; font-family: 微软雅黑; color: #0066FF;"></div>                
                    <asp:Label ID="Label1" runat="server" Text="登录名：" Width="80px"></asp:Label>
                    <asp:TextBox ID="tb_username" runat="server" Width="110px" ValidationGroup="group1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ControlToValidate="tb_username" ValidationGroup="group1">*</asp:RequiredFieldValidator>
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
                    <asp:TextBox ID="tb_pwd" runat="server" Width="110px" TextMode="Password" ValidationGroup="group1"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="RequiredFieldValidator" ForeColor="Red" ControlToValidate="tb_pwd" ValidationGroup="group1">*</asp:RequiredFieldValidator>
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
                    <asp:Button ID="Button1" runat="server" Style=" height: 30px;width:50px" Text="登陆" Width="62px" OnClick="Button1_Click" ValidationGroup="group1" />                 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="Button2" runat="server" Text="注册" OnClick="Button2_Click" Style="height: 30px;width:50px"/>
                </td>
            </tr>
            </table>
    </div>
    <script type="text/javascript">
        function showregister()
        {
            $('#iframeregister').animate({ opacity: 1, height: '46px' }, 800);
            $('#iframeregister').animate({ opacity: 1, height: '240px' }, 0);
            $('#dvlogin').animate({ opacity: 0 }, 800);
   
        }
        function hideregister()
        {
           // $('#iframeregister').css({ "opacity": "1", "height": "300px" });
            $('#iframeregister').animate({ opacity: 0, height: '1px' }, 1000);
           $('#dvlogin').animate({ opacity: 1 }, 2000);        
        }
        function registermsg(msg) {
            msg2 = msg+",注册成功";
            $('#registermsg').animate({ opacity: 1,height:'100%' }, 1000);
            $('#registermsg').text(msg2);
            $('#<%=tb_username.ClientID%>').val(msg);
            $('#<%=tb_pwd.ClientID%>').focus();
        }

    </script>
</asp:Content>


