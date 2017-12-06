<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login_hz.aspx.cs" Inherits="SMWeb.Login" %>

<!DOCTYPE html>

<html lang="en" xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>校立方</title>
    <link type="text/css" rel="stylesheet" href="css/layout.css" />
    <link type="text/css" rel="stylesheet" href="css/reset.css" />

    <script src="Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script type="text/javascript" src="js/tab.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/Common.js"></script>
    <style type="text/css">
        .code {
            background-image: url(w1.jpg);
            font-family: Arial;
            font-style: italic;
            color: Red;
            border: 0;
            padding: 2px 3px;
            letter-spacing: 3px;
            font-weight: bolder;
        }
        .header_wrap{width:100%;height:114px;border-top:6px solid #23A0F0;}
        .header{width:1200px;margin:0 auto;}
        .footer_wrap{width:100%;height:120px;background:url(images/footer_bg.png) repeat-x;}
         .footer_wrap .footer{width:1200px;margin:0 auto;}
         .logo{margin-top:32px;}
         .footer_right{margin-top:27px;}
        .footer_right p {
    font-size: 12px;
    color: #666666;
    line-height: 22px;
    text-align: right;
}
         .footer_right p a{color: #666666;}
         .content{width:100%;height:660px;background:url(images/content_02.png) no-repeat center top;background-size:cover;}
         .main1{width:1200px;margin:0 auto;position:relative;height:100%;}
         .login_conaa{padding:10px;background: rgba(255,255,255,.2);
    border-radius: 3px;width:340px;height:290px;float:right;position:absolute;right:0;top:50%;margin-top:-155px;}
         .Login .login_con{height:250px;}
         .Login{padding-top:0;}
         .login_img{position:relative;height:100%;width:43%;}
         .login_img img{position:absolute;top:0;left:0;bottom:0;margin: auto;}
         @media screen and (min-width:1366px) and (max-width:1920px){
             .login_img{width:50%;}
         }
    </style>
</head>
<body>
    <!--- -->
    <div class="header_wrap">
        <div class="header">
             <img src="images/header.png" /></div>
       
    </div>
    <div class="content">
        <div class="Login main1">
            <div class="fl login_img pr">
                 <img src="images/login_img.png" />
            </div>
            <div class="login_conaa">
                <div class="login_con">
                    <h1>系统登录</h1>
                    <div class="form">
                        <form method="get" action="">
                            <ul class="con">
                                <li class="xian"><span class="icon">
                                    <img src="images/people.png" /></span><input id="txt_loginName" type="text" class="kuang" value="huyongdi" placeholder="请输入用户名" /></li>
                                <li class="xian"><span class="icon">
                                    <img src="images/password.png" /></span><input id="txt_passWord" type="password" class="kuang" value="pwd@123" placeholder="请输入密码" /></li>
                                <li class="yzm xian"><span class="icon">
                                    <img src="images/yzm.png" /></span><input id="inpCode" type="text" class="kuang1" placeholder="请输入验证码" /><span class="yzmtu">
                                        <input type="text" id="checkCode" class="code" style="width: 50px" /></span><a href="#" onclick="createCode()">刷新</a></li>
                                <li>
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
    <footer class="footer_wrap">
        <div class="footer">
            <div class="logo fl">
                <img src="PortalImages/logo.png" />
			</div>
            <div class="footer_right fr">
				<p>联系电话：010-5xx地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>电话：010-62460887、010-62461764  传真：010-62463259   网址：<a href="http://www.bjybjx.cn">http://www.bjybjx.cn</a></p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
			</div>
        </div>
    </footer>
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
            /******添加访问率分析***********/
            addMonnitor(5, '', '', 0,cookie.retData[0].Name ,cookie.retData[0].IDCard);
            /*****************/
            $.cookie('LoginCookie_Cube', JSON.stringify(cookie.retData[0]));
            if (cookie.retData[0].SF == "教师") {
                location.href = "HZ_Index.aspx";
            }
            else {
                GetClassID(cookie.retData[0].IDCard)
                location.href = "/PersonalSpace/Learning_center_portal.aspx";

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
