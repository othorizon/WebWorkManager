<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title>用户注册</title>
    <style type="text/css">
        .auto-style1 {
        width: 336px;
        }
        .auto-style2 {
            height: 20px;
        width: 387px;
            text-align: left;
        }
        .auto-style3 {
            width: 387px;
            text-align: left;
        }
        .auto-style4 {
            width: 387px;
            text-align: left;
            height: 41px;
        }
        </style>

</asp:Content>
<asp:Content ID="Content2" runat="server"   contentplaceholderid="ContentPlaceHolder1">

    <asp:ScriptManager ID="ScriptManager1" runat="server">
            </asp:ScriptManager>
        <div class="auto-style1" style="filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#3f000000',endColorstr='#3f000000');
    background-color:rgba(255, 255, 255,0.3);">
           <table id="tb_step1" runat="server" class="auto-style1">
                <tr>
                    <td class="auto-style2">
                        用户类型：<asp:DropDownList style="background-color: transparent;" ID="ddl_type" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddl_type_SelectedIndexChanged">
                            <asp:ListItem>选择用户类型</asp:ListItem>
                            <asp:ListItem Value="student">学生</asp:ListItem>
                            <asp:ListItem Value="teacher">教师</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td id="td_username" runat="server" class="auto-style3" aria-orientation="horizontal">
                       
                         <asp:Label ID="lb_name" runat="server" Text="学号：" Width="80px"></asp:Label>
                         <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline">
                            <ContentTemplate>                              
                                <asp:TextBox ID="tb_username" runat="server" AutoPostBack="True" OnTextChanged="tb_username_TextChanged" style="background-color: transparent;" Width="140px"></asp:TextBox>          
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="tb_username" Display="Dynamic" EnableTheming="True" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
                                <asp:Label ID="lb_checkname" runat="server" Font-Bold="False" ForeColor="Red" Width="80px"></asp:Label>
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1" RenderMode="Inline">                                 
                                     <ProgressTemplate>
                                        用户名检测中...
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                            </ContentTemplate>
                            <Triggers>
                                <asp:AsyncPostBackTrigger ControlID="tb_username" EventName="TextChanged">
                                </asp:AsyncPostBackTrigger>
                            </Triggers>
                        </asp:UpdatePanel>
                          
                       
                    </td>
                </tr>
                <tr>
                    <td id="td_pwd1" runat="server" class="auto-style3">
                        <asp:Label ID="Label1" runat="server" Text="密码：" Width="80px"></asp:Label>
                        <asp:TextBox style="background-color: transparent;" ID="tb_pwd1" runat="server" TextMode="Password" Width="140px" ViewStateMode="Enabled"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="tb_pwd1" Display="Dynamic" EnableTheming="True" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td id="td_pwd2" runat="server" class="auto-style4">
                        <asp:Label ID="Label2" runat="server" Text="确认密码：" Width="80px"></asp:Label>
                        <asp:TextBox style="background-color: transparent;" ID="tb_pwd2" runat="server" TextMode="Password" Width="140px" ViewStateMode="Enabled"></asp:TextBox>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="tb_pwd1" ControlToValidate="tb_pwd2" ErrorMessage="密码不一致" Display="Dynamic" ForeColor="Red">密码不一致</asp:CompareValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="tb_pwd2" Display="Dynamic" EnableTheming="True" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td id="td_nextbutton" runat="server" style="text-align:center" class="auto-style3">
                        <asp:Button ID="bt_next" runat="server" Text="下一步" OnClick="bt_next_Click" />
                    </td>
                </tr>
            </table>
            <table  id="tb_stepstudent" visible="false"  runat="server" class="auto-style1"  >
                          <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label3" runat="server" Text="姓名：" Width="80px"></asp:Label>
                        <asp:TextBox ID="tb_name" style="background-color: transparent;" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="tb_name" Display="Dynamic" EnableTheming="True" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
                    </td></tr>
                          <tr>
                    <td class="auto-style2">
                        <asp:Label ID="Label4" runat="server" Text="班级：" Width="80px"></asp:Label>
                        <asp:DropDownList ID="ddl_class" style="background-color: transparent;"  runat="server">
                        </asp:DropDownList>
                    </td></tr>
                          <tr>
                    <td style="text-align:center" class ="auto-style2">
                        <asp:Button ID="bt_Finish" runat="server" Text="登记学生" OnClick="bt_Finish_Click" />
                              </td></tr>
                 </table>
            <table  id="tb_stepteacher" visible="false"  runat="server" class="auto-style1"  >
                          <tr>
                    <td style="text-align:left" class ="auto-style2">
                        <asp:Label ID="Label5" runat="server" Text="姓名：" Width="80px"></asp:Label>
                        <asp:TextBox ID="tb_name2" style="background-color: transparent;" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="tb_name2" Display="Dynamic" EnableTheming="True" ErrorMessage="RequiredFieldValidator" ForeColor="Red">不能为空</asp:RequiredFieldValidator>
                              </td></tr>
                          <tr>
                    <td style="text-align:left" class ="auto-style2">
                        <asp:Label ID="Label6" runat="server" Text="执教班级(单击选中，按住Ctrl多选）："></asp:Label>
                        <br />
&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ListBox ID="listb_Class" runat="server" Width="170px" Font-Size="Medium" SelectionMode="Multiple"></asp:ListBox>
                              </td></tr>
                          <tr>
                    <td style="text-align:center" class ="auto-style2" id="tb_">
                        <asp:Button ID="bt_Finish2" runat="server" style="text-align: left" Text="登记教师" OnClick="bt_Finish2_Click" />
                              </td></tr>
            </table>
         </div>

        </asp:Content>


