<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="successPwd.aspx.cs" Inherits="SMSWeb.successPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="/css/layout.css" rel="stylesheet" type="text/css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/index.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
     <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <style>
        .forget_wrap {
            background: #fff;
        }

        .retrievepwd-progress {
            width: 600px;
            margin: 0 auto;
            padding: 58px 0 30px;
        }

            .retrievepwd-progress .progress-pwd-out {
                background: url(images/steppwd.png) no-repeat 0 -40px;
                width: 600px;
                height: 30px;
            }

            .retrievepwd-progress .way li.current {
                color: #0b70c0;
            }

            .retrievepwd-progress .way li {
                float: left;
                font-size: 16px;
                padding-top: 13px;
                width: 180px;
                text-align: right;
            }

                .retrievepwd-progress .way li.p1 {
                    width: 140px;
                }

                .retrievepwd-progress .way li.p2 {
                    width: 120px;
                }

        .retrievepwd-cont {
            width: 600px;
            margin: 0 auto;
        }

            .retrievepwd-cont .register-process-list {
                padding-top: 20px;
                width: 600px;
            }

        .register-process-list li label {
            display: inline;
            height: 21px;
            float: left;
            width: 172px;
            margin-top: 10px;
            text-align: right;
            margin-right: 3px;
            font-size: 14px;
        }

        .retrievepwd-cont .register-process-list li {
            margin-top: 10px;
        }

        .step-content-one-select {
            width: 210px;
            border-radius: 2px;
            height: 32px;
            border: 1px solid #ccc;
        }

        .left {
            padding-left: 180px;
        }

        .getvcode {
            margin-top: 10px;
        }

        .retrievepwd-cont .a-link {
            color: #1970b4;
            text-decoration: underline;
        }

        .ui-inp {
            width: 210px;
            height: 28px;
            border-radius: 2px;
            border: 1px solid #ccc;
        }

        .btn-public-38 {
            display: block;
            margin: 0 auto;
            font-size: 14px;
            height: 38px;
            width: 100px;
            background: #0b70c0;
            color: #fff;
            border-radius: 2px;
            line-height: 38px;
            text-align: center;
            margin-top: 30px;
        }

        .success {
            margin-top: 30px;
        }

            .success span {
                width: 50px;
                height: 50px;
                float: left;
                display: block;
                background: url(images/steppwd.png) no-repeat -60px -80px;
            }

            .success div {
                float: left;
                margin-left: 10px;
            }

                .success div .pa {
                    line-height: 30px;
                    font-size: 21px;
                    font-weight: bold;
                    position:static;
                }

                .success div .pb {
                    line-height: 20px;
                    font-size: 15px;
                }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="huser" runat="server" />
        <asp:HiddenField ID="hpwd" runat="server" />
        <!--header-->
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/Portal/index.aspx">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 5px;" />

                </a>

            </div>
        </header>
        <div class="forget_wrap width" style="min-height:578px;margin-top:200px;">
            <div class="retrievepwd-progress clearfix">
                <div class="progress-pwd-out png24">
                    <div class="progress-pwd-in progress-pwd-inwidth2 png24"></div>
                </div>
                <ul class="clearfix way">
                    <li class="current">选择方式</li>
                    <li class="p1">重置密码</li>
                    <li class="p2">完成</li>
                </ul>
                <div class="retrievepwd-cont">
                    <ul class="register-process-list">
                        <li class="clearfix mb20">
                            <div class="left">
                                <div class="clearfix mt5 success">
                                    <span></span>
                                    <div>
                                        <p class="pa">新密码设置成功</p>
                                        <p class="pb">
                                            下次登录请输入新密码
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                    <a href="javascript:void(0);" id="next-vcode-btn" class="btn-public-38 next-btn">5秒后回到门户首页
                    </a>
                </div>
            </div>
        </div>
        <footer class="mt10">
            <div class="footer width clearfix">
                <div class="logo fl">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 10px;" />
                </div>
                <div class="footer_right fr">
                    <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                    <p>传真：010-62463259   网址：<a href="#" style="color: #fff;">http://www.bjybjx.cn</a></p>
                    <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
                </div>
            </div>
        </footer>
    </form>
    <script type="text/javascript">
        var nums=5;
        $(function () {
            initLogin();
        })

        function refreshTime()
        {
            clock = setInterval(doLoop, 1000); //一秒执行一次
        }

        function doLoop()
        {
            nums--;
            if (nums > 0) {
                $("#next-vcode-btn").html(nums + '秒后回到门户首页');
            } else {
                window.location = "/Portal/index.aspx";
            }
        }

        function initLogin()
        {
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                async: false,
                dataType: "json",
                data: { "Func": "Login", "loginName": $("#huser").val(), "passWord": $("#hpwd").val() },
                success: OnSuccessLogin,
                error: OnErrorLogin

            });
        }

        function OnSuccessLogin(json) {
            var cookie = json.result;
            if (cookie.errNum == "0") {
                /******添加访问率分析***********/
                addMonnitor(5, '', '登录', 0, cookie.retData[0].Name, cookie.retData[0].IDCard);
                /*****************/
                $.cookie('LoginCookie_Cube', JSON.stringify(cookie.retData[0]));
                $.cookie('PwdCookie_Cube', $("#txt_passWord").val(), { path: '/', secure: false });
                refreshTime();
            } else {
                layer.msg(json.result.errMsg + "！");
                window.location = "/Portal/index.aspx";
            }
        }
        function OnErrorLogin(XMLHttpRequest, textStatus, errorThrown) {
            //layer.msg("登录名或密码错误！" + errorThrown);
            layer.msg("登录失败！");
        }
    </script>
</body>
</html>
