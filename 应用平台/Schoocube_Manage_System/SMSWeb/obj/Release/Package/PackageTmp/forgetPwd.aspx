<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="forgetPwd.aspx.cs" Inherits="SMSWeb.forgetPwd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <style>
        .forget_wrap{background: #fff;}
        .retrievepwd-progress{    width: 600px;
            margin: 0 auto;
            padding: 58px 0 30px;}
        .retrievepwd-progress .progress-pwd-out {
            background: url(images/steppwd.png) no-repeat 0 0;
            width: 600px;
            height: 30px;
        }
        .retrievepwd-progress .way li.current {
            color: #0b70c0;
        }
        .retrievepwd-progress .way li {
            float: left;
            font-size:16px;
            padding-top: 13px;
            width: 180px;
            text-align: right;
        }
        .retrievepwd-progress .way li.p1 {
            width:140px;
        }
        .retrievepwd-progress .way li.p2 {
            width:120px;
        }
        .retrievepwd-cont {
            width: 600px;
            margin: 0 auto;
        }
        .retrievepwd-cont .register-process-list {
            padding-top: 20px;
            width: 600px;
        }
        .register-process-list li{position:relative;}
        .register-process-list li .label {
            display: inline;
            height: 21px;
            float: left;
            width: 172px;
            margin-top: 10px;
            text-align: right;
            margin-right: 3px;
            font-size: 14px;
            position:absolute;
            top:0;left:0;
        }
        .retrievepwd-cont .register-process-list li{margin-top: 10px;}
        .step-content-one-select{width:210px;border-radius:2px;height:32px;border:1px solid #ccc;}
        .left{padding-left:180px;}
        .getvcode{margin-top:10px;}
        .retrievepwd-cont .a-link {
            color: #1970b4;
            text-decoration: underline;
        }
        .ui-inp{width:210px;height:28px;border-radius:2px;border:1px solid #ccc;}
        .btn-public-38 {
            display: block;
            margin:0 auto;
            font-size: 14px;
            height: 38px;
            width:100px;
            background: #0b70c0;
            color: #fff;
            border-radius:2px;
            line-height: 38px;
            text-align:center;
            margin-top: 30px;
            border:none;
        }
        .label1{display: inline;
            height: 21px;
            float: left;
            margin-top: 10px;
            text-align: right;
            margin-right: 3px;
            font-size: 14px;}
        #email,#phone{float:left;margin-top:10px;}
    </style>
    <script src="Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <!--header-->
        <header class="repository_header_wrap">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="HZ_Index.aspx">
                    <img src="PortalImages/logoBefore.png" style="margin-top: 5px;" />

                </a>
                
            </div>
        </header>
        <div class="forget_wrap width">
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
                    <li class="clearfix">
                        <label class="label">帐号：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input id="" maxlength="6" name="validate" class="ui-inp" type="text" />
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <label class="label">选择方式：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input type="radio" name="email" id="email"/>
                                <label for="email" class="label1">邮箱</label>
                                <input type="radio" name="phone" id="phone" />
                                <label for="phone" class="label1">手机号</label>
                            </div>
                        </div>
                    </li>
                    <li class="clearfix">
                        <label class="label">验证码：</label>
                        <div class="left">
                            <div class="clearfix">
                                <input id="input-vcode" maxlength="6" name="validate" class="ui-inp fl" type="text" /> 
                                <div class="getvcode fl ml10">
                                    <a id="a-getvcode" href="javascript:void(0);" class="a-link">获取验证码</a>
                                </div>
                                <div class="getvcode fl ml10" >
                                    <a  class="a-link1">57秒</a>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
                <%--<a href="javascript:void(0);" id="next-vcode-btn" class="btn-public-38 next-btn">
					下一步
                </a>--%>
                <input type="button" value="下一步" class="btn-public-38 next-btn" />
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
                    <p>传真：010-62463259   网址：<a href="" style="color: #fff;">http://www.bjybjx.cn</a></p>
                    <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
                </div>
            </div>
        </footer>
    </form>
</body>
</html>
