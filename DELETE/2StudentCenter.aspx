<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="2StudentCenter.aspx.cs" Inherits="StudentCenter" %>

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

    <script type="text/javascript">//工作详情打开事件
        //    $(function () { $('#dvcontent').animate({ height: '0px', opacity: 0 }, 1000); })
        var show = 0;
        var clientid = '<%=dvwork.ClientID%>';
        $('#' + clientid + ' > div').click(function () {
            $('#' + clientid + ' > div').css({ "opacity": "1", "height": "100%" });
            var id = this.id
            var num = $('#' + id + ' > div ').height();
            if (num < 50) {
                $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });
                $(function () {
                    $('#' + id + ' > div ').animate({ height: '400px', opacity: 1 }, 800,
                        function () {
                            $("html,body").animate({ scrollTop: $("#" + id).offset().top - 50 }, 1000,
                                function () {
                                   // $("iframe").animate({ src: "workinfo.aspx" }, 800);
                                });
                        });
                });
                                     
            }
            else {
                $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });
            }
        });
    </script>
    <script type="text/javascript">//进入工作
        $("input").click(function () {
            var id = this.name;
            var num = this.id;
          //  document.getElementById('dvopenwork' + num).innerHTML = "<iframe scrolling='no' id='iframeregister' style='width:336px' src=\"MinRegister.aspx\"></iframe>";
             //   .text("<iframe scrolling='no' id='iframeregister' style='opacity:0;border:none;height:0px;width:336px' src=\"MinRegister.aspx\"></iframe>");
            $('#iframe' + id).animate({ src: "DoWork.aspx?workid="+ id }, 800);
           // window.open("DoWork.aspx?workid=" + id);
        });
    </script>
    <script type="text/javascript">//工作列表动画
        function showwork() {
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 1, height: '55px' }, 1000);
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 1, height: '100%' }, 0);

        }
    </script>
    <script type="text/javascript">//随屏幕滚动
        window.onscroll = function () {
            document.getElementById("dvsetting").style.top =  + parseInt(document.documentElement.scrollTop, 10)  +100+ "px";
        }
    </script>



</asp:Content>

