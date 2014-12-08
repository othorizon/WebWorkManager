<%@ Page Language="C#" AutoEventWireup="true" CodeFile="2workinfo.aspx.cs" Inherits="workinfo" %>

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
            width: 300px;
        }

        .fix {
            height: 30px;
        }

        .iframe {
        }
    </style>
</head>
<body>
    <div style="filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000'); background-color: rgba(255, 255, 255,0.3);">
        <form id="form1" runat="server">
            <div>
                <table class="main" style="text-align: left">
                    <tr>
                        <td class="left" rowspan="3">
                          
                        </td>
                        <td id="title" style="cursor: pointer" runat="server" class="fix">标题</td>
                    </tr>
                    <tr>
                        <td>
                            <div id="dvcontent" runat="server"></div>
                        </td>
                    </tr>
                    <tr>
                        <td class="fix">按钮</td>
                    </tr>
                </table>
            </div>
        </form>
    </div>
</body>
</html>
