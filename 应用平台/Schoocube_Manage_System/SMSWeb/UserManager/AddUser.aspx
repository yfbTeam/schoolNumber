<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="SMSWeb.UserManager.AddUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>


    <link href="../Stu_css/iconfont.css" rel="stylesheet" />
    <link href="../Stu_css/layout.css" rel="stylesheet" />
    
    <script src="../Scripts/jquery-1.8.0.js"></script>
    
    <script src="../Stu_js/layer/layer.js"></script>
    <script src="../Stu_js/layer/OpenLayer.js"></script>
    
    <script type="text/javascript">
        
        function closeFrame(returnVal)
        {
            OL_CloseLayerIframe(returnVal);
        }
        function RemoveCurrent(fileName, trId) {
            $("#" + trId).hide();
            var nowfile = $("input[id$=Hid_fileName]").val();
            $("input[id$=Hid_fileName]").val(nowfile + '#' + fileName);
        }
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
</head>
<body>
    <form id="form1" runat="server">
    <div class="listdv">
        <table>
            <tr>
                <th>姓名：</th>
                <td>
                    <asp:TextBox ID="TB_UserName" runat="server"></asp:TextBox>
                    <span>*
                            </span>
                </td>
            </tr>
            <tr>
                <th>登陆名：</th>
                <td>
                    <asp:TextBox ID="TB_LoginName" runat="server"></asp:TextBox>
                    <span>*
                            </span>
                </td>
            </tr>
            <tr>
                <th>密码：</th>
                <td>
                    <asp:TextBox ID="TB_Password" TextMode="Password" runat="server"></asp:TextBox>
                    <span>*
                            </span>
                </td>
            </tr>
            <tr>
                <th>确认密码：</th>
                <td>
                    <asp:TextBox ID="TB_Password2" TextMode="Password" runat="server"></asp:TextBox>
                    <span>*
                            </span>
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

            <tr class="btntr">
                <th></th>
                <td>
                    <asp:Button ID="Btn_Save" OnClientClick="return Add();" OnClick="Btn_Save_Click" CssClass="save" runat="server" ValidationGroup="ProjectSubmit" Text="保存" />

                    <input type="button" class="cancel" value="取消" onclick="closeFrame('0');" />
                </td>
            </tr>
        </table>
    </div>
        </form>
</body>
</html>
