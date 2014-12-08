<%@ Page Language="C#" AutoEventWireup="true" CodeFile="workinfo.aspx.cs" Inherits="workinfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .main {
            width: 100%;
        }

        .left {
            width: 1px;
        }

        .fix {
            height: 30px;
        }

        .iframe {
        }
    </style>
    <script src="Scripts/jquery-1.7.1.min.js" type="text/javascript"></script>
</head>
<body>
    <div style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
        <form id="form1" runat="server">
            <div>
                <table class="main" style="text-align: left">
                    <tr>
                        <td class="left" rowspan="3">
                            <iframe scrolling='no' id='openwork' style='border: none; height: 0px; width: 0px' src="openWork.aspx?workid=<%=workid%>&username=<%=username%>"></iframe>
                        </td>
                        <td id="title" style="cursor: pointer" runat="server" class="fix">标题</td>
                    </tr>
                    <tr>
                        <td>
                            <div id="dvcontent" style="height: 1px; opacity: 0" runat="server"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="fix">按钮</td>
                    </tr>
                </table>
            </div>
            <script type="text/javascript">
                $('#title').click(function () {
                 
                    //$('#openwork').css("src", "openwork.aspx");
                    if ($('#dvcontent').height() < 100) {                     
                        $('#dvcontent').animate({ opacity: 1, height: '300px' }, 800, function () {
                            $('#openwork').animate({ width: '380px', height: '300px' }, 800);
                        });
                    }
                    else {

                        $('#openwork').animate({ width: '1px', height: '1px' }, 800, function () {
                            $('#openwork').animate({ width: '0px', height: '0px' }, 0);
                            $('#dvcontent').animate({ opacity: 0, height: '1px' }, 800, function () {
                            });
                        });
                       
                        // $('.left').animate({ width: '380px' }, 800);
                    }
                })
            </script>
        </form>
    </div>
</body>
</html>
