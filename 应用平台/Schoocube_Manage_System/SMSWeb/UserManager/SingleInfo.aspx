<%@ Page Title=""  Language="C#" MasterPageFile="~/SMS.Master" AutoEventWireup="true" CodeBehind="SingleInfo.aspx.cs" Inherits="SMSWeb.UserManager.SingleInfo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />
    
    <script src="../Scripts/jquery-1.8.0.js"></script>
    
    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>
    <script type="text/javascript">
        function Add() {
            var userName = $("input[id$=TB_UserName]").val();
            var loginName = $("input[id$=TB_LoginName]").val();
            var password = $("input[id$=TB_Password]").val();
            var password2 = $("input[id$=TB_Password2]").val();
            var email = $("input[id$=TB_Email]").val();
            var sex = $("input[id$=TB_Sex]").val();


            if (userName == "") {
                layer.msg("请输入姓名！");
                return false;
            }
            if (loginName == "") {
                layer.msg("请输入登录名！");
                return false;
            }
            if (password == "") {
                layer.msg("请输入密码！");
                return false;
            }
            if (password != password2) {
                layer.msg("俩次密码不一致！");
                return false;
            }

            return true;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="listdv">
        <table>
            <tr>
                <th>姓名：</th>
                <td>
                    <asp:HiddenField ID="Hid_Uid" runat="server" />
                    <asp:TextBox ID="TB_UserName" runat="server"></asp:TextBox>
                    <span>*</span>
                </td>
            </tr>
            <tr>
                <th>登陆名：</th>
                <td>
                    <asp:TextBox ID="TB_LoginName" runat="server"></asp:TextBox>
                    <span>*</span>
                </td>
            </tr>
            <tr>
                <th>密码：</th>
                <td>
                    <asp:TextBox ID="TB_Password" TextMode="Password" runat="server"></asp:TextBox>
                    <span>*</span>
                </td>
            </tr>
            <tr>
                <th>确认密码：</th>
                <td>
                    <asp:TextBox ID="TB_Password2" TextMode="Password" runat="server"></asp:TextBox>
                    <span>*</span>
                </td>
            </tr>
            <tr>
                <th>邮箱：</th>
                <td>
                    <asp:TextBox ID="TB_Email" runat="server"></asp:TextBox>
                    
                </td>
            </tr>
            <tr>
                <th>性别：</th>
                <td>
                    <asp:TextBox ID="TB_Sex" runat="server"></asp:TextBox>
                    
                </td>
            </tr>
            <tr>
                <th>用户头像：</th>
                <td>
                    <input type="file" id="file_activity" name="file_activity" runat="server" />
                    
                </td>
            </tr>
            <tr class="btntr">
                <th></th>
                <td>
                    <asp:Button ID="Btn_Save" OnClientClick="return Add();" OnClick="Btn_Save_Click" CssClass="save" runat="server" ValidationGroup="ProjectSubmit" Text="保存" />

                    <input type="button" class="cancel" value="取消" onclick="closeFrame('0');" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
