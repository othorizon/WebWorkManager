<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="TeacherCenter.aspx.cs" Inherits="TeacherCenter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>个人中心</title>
    <style type="text/css">
        .touming {
            filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000');
            background-color: rgba(255, 255, 255,0.3);
        }

        .gaga {
            width: 100px;
            height: 100px;
            position: absolute;
            top: 50%;
            left: 50%;
            margin-left: -50px;
            margin-top: -50px;
        }

        .popupcontent {
            position: absolute;
            visibility: hidden;
            overflow: hidden;
            border: 1px solid #CCC;
            background-color: #F9F9F9;
            border: 1px solid #333;
            padding: 5px;
        }
    </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
    </div>

    <div style="text-align: left; z-index: 99">
        <asp:Label ID="lb_name" runat="server"></asp:Label>
        当前所选班级：  
         
        <asp:Label ID="classname" runat="server" Text=""></asp:Label>
        &nbsp;&nbsp;
        <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">注销</asp:LinkButton>
    </div>
    <div style="height: 10px"></div>


    <div id='dvopenwork' style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3); z-index: 99; opacity: 0; display: none; POSITION: absolute; left: 625px; top: 116px; width: 0px; height: 344px; text-align: center">
        <iframe scrolling='no' id='iframeregister' style='opacity: 1; border: none; width: inherit; height: inherit' src="error.aspx"></iframe>
    </div>


    <div id="dvsetting" style="z-index: 20; width: 100px; margin-left: 20px; position: absolute">
       <label id="lbclass" runat="server" >筛选工作：</label><br />
         <input type="button" value="全部" onclick="showall()" /><br /><br />

    </div>
    <!--1111111111111111111111111111231-->
    <script>
        function openLogin() {

            document.getElementById("dvopenwork").style.display = "";

            $('#dvopenwork').animate({ width: '600px', opacity: 1 }, 800);
        }
        function closeLogin() {
            document.getElementById("dvopenwork").style.display = "none";

        }
    </script>

    <div id="dvwork" runat="server" style="cursor: pointer; width: 600px; position: absolute; margin-left: 620px">
    </div>

    <script type="text/javascript">//进入工作
        $("#<%=dvwork.ClientID%> input").click(function () {
            var id = this.name;
            var num = this.id;
            //  document.getElementById('dvopenwork' + num).innerHTML = "<iframe scrolling='no' id='iframeregister' style='width:336px' src=\"MinRegister.aspx\"></iframe>";
            //   .text("<iframe scrolling='no' id='iframeregister' style='opacity:0;border:none;height:0px;width:336px' src=\"MinRegister.aspx\"></iframe>");
            window.open("openwork.aspx?workid=" + id + "&username=<%=username%>", '', 'menubar=no,location=no,status=no,scroolbars=no,resizable=no,width=350,height=350');
        });
    </script>

    <script type="text/javascript">//工作详情打开事件
        var show = 0;
        var clientid = '<%=dvwork.ClientID%>';



        $('#' + clientid + ' > div').click(function () {
            //    $('#' + clientid + ' > div').css({ "opacity": "1", "height": "100%" });

            var id = this.id
            var num = $('#' + id + ' > div ').height();
            if (num < 50) {

                $('#dvopenwork').animate({ width: '1px', left: '+=400px', opacity: 0 }, 500, function () {//隐藏openwork
                    document.getElementById("dvopenwork").style.display = "none";
                    $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });

                    $(function () {

                        $('#' + id + ' > div ').animate({ height: '300px', opacity: 1 }, 800,
                            function () {
                                $("html,body").animate({ scrollTop: $("#" + id).offset().top - 50 }, 500, function () {
                                    var dv = document.getElementById("dvopenwork");

                                    if (document.getElementById("dvopenwork").style.display == "none") {
                                        var px = 99 + id * 59;
                                        //228 628
                                        dv.style.top = px + "px";
                                        $('#dvopenwork').animate({ left: '628px', width: '0px', opacity: 0 }, 0);
                                        var workid = document.getElementById("button" + id).name;
                                        document.getElementById("iframeregister").src = "openwork.aspx?username=" +<%=username%> +"&workid=" + workid;
                                        document.getElementById("dvopenwork").style.display = "";
                                        $('#dvopenwork').animate({ left: '-=400px', width: '400px', opacity: 1 }, 800);
                                    }
                                });
                            });
                    });

                });
            }
            else {
                $('#dvopenwork').animate({ width: '1px', left: '+=400px', opacity: 0 }, 500, function () {//隐藏openwork
                    document.getElementById("dvopenwork").style.display = "none";
                    document.getElementById("iframeregister").src = "";
                    $(function () { $('#' + clientid + ' > div > div ').animate({ height: '10px', opacity: 0 }, 800); });
                });

            }
        } );


    </script>


    <script type="text/javascript">//工作列表动画
        function showwork() {

            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 1, height: '55px' }, 1000);
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 1, height: '100%' }, 0);
            // $("div[name='finish']").css( "display", "" );
            //  $("div[name='"+type+"']").animate({ opacity: 1, height: '55px'}, 1000);
            //   $("div[name='"+type+"']").animate({ opacity: 1, height: '100%' }, 0);

        }
        function hidefinish() {
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 0, height: '1px' }, 1000);
            document.location.href = "usercenter.aspx?worktype=notfinish";
        }
        function hidenotfinish() 
        {
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 0, height: '1px' }, 1000);
            document.location.href = "usercenter.aspx?worktype=finish";
        }
        function showall()
        {
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 0, height: '1px' }, 1000);
            document.location.href = "usercenter.aspx";
        }
        function selectclass(id)
        {
            $('#<%=dvwork.ClientID%> > div').animate({ opacity: 0, height: '1px' }, 800);
            document.location.href = "usercenter.aspx?classid="+id;
        }
    </script>
    <script type="text/javascript">//随屏幕滚动
        window.onscroll = function () {
            document.getElementById("dvsetting").style.top = +parseInt(document.documentElement.scrollTop, 10) + 100 + "px";
        }
    </script>



</asp:Content>

