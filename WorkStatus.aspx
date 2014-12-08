<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WorkStatus.aspx.cs" Inherits="WorkStatus" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        #TextArea1 {
            height: 200px;
            width: auto;
        }
    </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server" style="text-align:left;width:auto">

            <div id="dvmycontent">
               <div> 已完成人数：<asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
                   未完成人数：<asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                </div>
                <div>
                    <asp:GridView ID="GridView1" runat="server" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowCommand="GridView1_RowCommand" Width="368px" OnRowCreated="GridView1_RowCreated">
                        <Columns>
                            <asp:TemplateField ShowHeader="False" HeaderText="操作">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="false" CommandArgument='<%#Eval("附件")%>' CommandName='<%#Eval("WorkID")%>' Text="下载"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
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
