<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SMSWeb.Portal.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户登录</title>
    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet" />
    <link href="/css/layout.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <style>
        .main1 {
            padding: 0;
        }

        .Login .login_con1 {
            box-shadow: none;
        }

        .code {
            font-family: Arial;
            font-style: italic;
            color: Red;
            border: 0;
            padding: 2px 3px;
            letter-spacing: 3px;
            font-weight: bolder;
        }
    </style>
</head>
<body style="background: #fff;">
    <div class="content" style="width: auto;">
        <div class="Login main1">
            <div class="login_conaa">
                <div class="login_con login_con1" style="height: auto;">
                    <%--<h1>系统登录</h1>--%>
                    <div class="form">
                        <form method="get" action="" runat="server">
                            <asp:HiddenField ID="urlP" runat="server" />
                            <asp:HiddenField ID="modelP" runat="server" />
                            <ul class="con">
                                <li class="xian"><span class="icon">
                                    <img src="/images/people.png" /></span><input id="txt_loginName" type="text" class="kuang" value="huyongdi" placeholder="请输入用户名" /></li>
                                <li class="xian"><span class="icon">
                                    <img src="/images/password.png" /></span><input id="txt_passWord" type="password" class="kuang" value="pwd@123" placeholder="请输入密码" /></li>
                                <li class="yzm xian"><span class="icon">
                                    <img src="/images/yzm.png" /></span><input id="inpCode" type="text" class="kuang1" placeholder="请输入验证码" /><span class="yzmtu">
                                        <input type="text" id="checkCode" class="code" style="width: 50px" /></span><a href="#" onclick="createCode()">刷新</a></li>
                                <li class="clearfix">
                                    <a href="" class="fr" id="forgetPwd">忘记密码？</a>
                                </li>
                                <li >
                                    <span class="btn">
                                        <input id="BtnLogin" type="button" class="btn_btn" value="登录" onclick="Login()" />
                                    </span>
                                </li>
                            </ul>
                            <div class="clear"></div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
<script>

    $(document).ready(function () {
        //加载验证码
        createCode();
        //回车提交事件
        $("body").keydown(function () {
            if (event.keyCode == "13") {//keyCode=13是回车键
                $("#BtnLogin").click();
            }
        });
        $("#forgetPwd").on("click", function () {
            parent.window.location = "/forgetPwd.aspx";
            parent.CloseIFrameWindow();
        })
    });

    var code; //在全局 定义验证码
    function createCode() {
        code = "";
        var codeLength = 4;//验证码的长度
        var checkCode = document.getElementById("checkCode");
        checkCode.value = "";
        var selectChar = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

        for (var i = 0; i < codeLength; i++) {
            var charIndex = Math.floor(Math.random() * 60);
            code += selectChar[charIndex];
        }
        if (code.length != codeLength) {
            createCode();
        }
        checkCode.value = code;
        $("#inpCode").val(code);
    }

    function Login() {
        var inputCode = document.getElementById("inpCode").value.toUpperCase();
        var codeToUp = code.toUpperCase();

        if (inputCode.length <= 0) {
            layer.msg("请输入验证码！");
            return false;
        }
        else if (inputCode != codeToUp) {
            layer.msg("验证码输入错误！");
            createCode();
            $("#inpCode").val('').focus();
            return false;
        }
        else {
            var loginName = $("#txt_loginName").val();
            var passWord = $("#txt_passWord").val();
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                async: false,
                dataType: "json",
                data: { "Func": "Login", "loginName": loginName, "passWord": passWord },
                success: OnSuccessLogin,
                error: OnErrorLogin

            });
        }
    }

    function OnSuccessLogin(json) {
        var cookie = json.result;
        if (cookie.errNum == "0") {
            $.cookie('LoginCookie_Cube', JSON.stringify(cookie.retData[0]), { path: '/', secure: false });
            $.cookie('PwdCookie_Cube', $("#txt_passWord").val(), { path: '/', secure: false });
            addMonnitor(5, '', '登录', 0, cookie.retData[0].Name, cookie.retData[0].IDCard);
            if ($("#urlP").val() != "" && $("#modelP").val() != "") {
                if ($("#urlP").val() == "course") {
                    var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                    if (UserInfo.SF == "学生") {
                        parent.window.location = "/OnlineLearning/StuLessonDetail.aspx?itemid=" + $("#modelP").val() + "&flag=0";
                    } else if (UserInfo.SF == "教师") {
                        parent.window.location = "/CourseManage/CourseDetail.aspx?itemid=" + $("#modelP").val();
                    }
                }
                parent.CloseIFrameWindow();
            } else {
                parent.window.location.reload();
                parent.CloseIFrameWindow();
            }
        } else {
            layer.msg(json.result.errMsg + "！");
        }
    }
    function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
        layer.msg("登录名或密码错误！" + errorThrown);
    }
    function GetClassID(IDCard) {
        $.ajax({
            url: "/SystemSettings/UserInfo.ashx",
            async: false,
            dataType: "json",
            data: { "Func": "GetClassID", "IDCard": IDCard },
            success: function (json) {

                if (json.result.errNum == "0") {

                    $.cookie('ClassID', json.result.retData[0].ClassID);

                } else {
                    layer.msg(json.result.errMsg + "！");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg(errorThrown);
            }
        });
    }
</script>
</html>
