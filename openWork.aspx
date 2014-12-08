<%@ Page Language="C#" AutoEventWireup="true" CodeFile="openWork.aspx.cs" Inherits="openWork" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        #TextArea1 {
            height: 200px;
            width: 336px;
        }
    </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" style="text-align:left;width:340px">
        <div>
            <div>
                标题：<asp:TextBox ID="tbtitle" Style="background-color: transparent;" Width="221px" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tbtitle" Display="Dynamic" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
            </div>
            <div id="dvmycontent">
                <div>我的回答：</div>
                <textarea id="tacontent" style="height: 200px; width: 336px" runat="server" name="S1"></textarea>
            </div>
            <div id="dvattach" visible="false" style="width: 336px" runat="server">
                <asp:Label ID="lbattach" runat="server" Text="123"></asp:Label>
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">删除</asp:LinkButton>
            </div>
            <div id="dvupfile" runat="server">
                附件：<asp:FileUpload ID="FileUpload1" runat="server" />
            </div>
            <div>
                <asp:Button ID="bt_submit" runat="server" Text="提交作业" OnClick="Button1_Click" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="bt_delete" runat="server" OnClick="bt_delete_Click" Text="删除作业" Visible="False" />
            </div>
        </div>
        <div style="height:5px"></div>

        <script type="text/javascript">
            function queren() {
                if (confirm('你真的要删除这条数据吗'))
                    return true;
                else
                    return false;
            }
        </script>
    </form>

</body>
</html>
