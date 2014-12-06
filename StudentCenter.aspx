<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="StudentCenter.aspx.cs" Inherits="StudentCenter" %>

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

    <div style="width: 300px; float: left">
        相关设置
    </div>

    <div id="dvwork" runat="server" style="cursor: pointer; width: 600px; float: left; margin-left: 320px">
    </div>

    <script type="text/javascript">//工作详情打开事件
        //    $(function () { $('#dvcontent').animate({ height: '0px', opacity: 0 }, 1000); })
        var show = 0;
        var clientid = '<%=dvwork.ClientID%>';
        $('#' + clientid + ' > div').click(function () {

            var id = this.id
            var num = $('#' + id + ' > div ').height();
            if (num < 50) {
                $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });
                $(function () { $('#' + id + ' > div ').animate({ height: '300px', opacity: 1 }, 800); });
            }
            else {
                $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });
            }
        });
    </script>
    <script type="text/javascript">//进入工作
        $("input").click(function () {
            var id = this.name;
            window.open("DoWork.aspx?workid=" + id);
        });
    </script>



</asp:Content>

