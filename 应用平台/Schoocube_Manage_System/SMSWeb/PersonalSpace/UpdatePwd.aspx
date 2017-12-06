<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UpdatePwd.aspx.cs" Inherits="SMSWeb.PersonalSpace.UpdatePwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人中心</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--证书-->
    <link rel="stylesheet" href="/css/certificate.css">
    <link rel="stylesheet" href="/css/certificateT.css">
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <link href="/Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <%--<script src="/Scripts/jquery-1.11.2.min.js"></script>--%>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/js/jquery.jqprint.js"></script>
    <script src="/js/jquery-migrate-1.1.0.js"></script>
    <script type="text/javascript" src="http://html2canvas.hertzen.com/build/html2canvas.js"></script>
    <script src="/CourseManage/Term.js"></script>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
        function UpdatePwd() {
            var LoginName = $("#LoginName").val();
            var OldPassword = $("#OldPassword").val();
            var NewPassword = $("#NewPassword").val();
            var NewPassword1 = $("#NewPassword1").val();

            if (!OldPassword.length || !NewPassword.length || !NewPassword1.length) {
                layer.msg("所有数据不可为空");
            }
            else {
                if (NewPassword != NewPassword1) {
                    layer.msg("新密码和确认密码不一致");
                }
                else {
                    $.ajax({
                        url: "/SystemSettings/CommonInfo.ashx",
                        type: "post",
                        dataType: "json",
                        data: {
                            Func: "UpStuPass",
                            LoginName: LoginName,
                            OldPassword: OldPassword,
                            NewPassword: NewPassword
                        },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                layer.msg("密码修改成功");
                            }
                            else {
                                layer.msg(json.result.errMsg)
                            }
                        },
                        error: function (errMsg) {
                            $("#tbCertificate").html(errMsg);
                        }
                    });
                }
            }

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <%--<h4 class="set-mold">修改密码</h4>--%>
            <table class="set-mold-table">
                <tbody>
                    <tr>
                        <td class="w85">学生账号：</td>
                        <td>
                            <input type="text" name="LoginName" id="LoginName" class="input">
                        </td>
                    </tr>
                    <tr>
                        <td class="w85">旧密码：</td>
                        <td>
                            <input type="text" name="OldPassword" id="OldPassword" class="input">
                        </td>
                    </tr>
                    <tr>
                        <td class="w85">新密码：</td>
                        <td>
                            <input type="text" name="NewPassword" id="NewPassword" class="input">
                        </td>
                    </tr>
                    <tr>
                        <td class="w85">再次输入：</td>
                        <td>
                            <input type="text" name="NewPassword1" id="NewPassword1" class="input">
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td><a href="javascript:void(0)" class="xiugai" onclick="UpdatePwd()">提交</a></td>
                    </tr>
                </tbody>
            </table>
        </div>
    </form>
</body>
</html>
