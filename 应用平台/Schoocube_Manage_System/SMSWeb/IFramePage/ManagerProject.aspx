﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerProject.aspx.cs" Inherits="SMSWeb.IFramePage.ManagerProject" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>科研管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style>
        .add_commentwrap .add_comment {
            background: none repeat scroll 0 0 #FAFAFA;
            border: 1px solid #DFDFDF;
            box-shadow: inset 1px 1px 2px #DFDFDF;
            padding: 5px;
            height: 65px;
            position: relative;
        }

            .add_commentwrap .add_comment textarea {
                background: #fff;
            }

        .operating {
            height: 28px;
            position: relative;
            overflow: hidden;
            margin-right: 5px;
        }

            .operating a {
                margin-right: 0px;
            }

            .operating a {
                background: #83bfec;
            }

            .operating span {
                cursor: pointer;
                width: 20px;
                height: 20px;
                color: #fff;
                border-radius: 50%;
                background: red;
                position: absolute;
                top: -8px;
                right: -8px;
                font-size: 12px;
                line-height: 23px;
                text-indent: 3px;
                z-index: 999;
            }

        .operating_briefing {
            position: relative;
            border: 1px solid #ccc;
            padding: 10px;
        }

            .operating_briefing h1 {
                width: 70px;
                line-height: 30px;
                color: #666;
                font-size: 15px;
                margin-right: -80px;
                float: left;
            }

            .operating_briefing .content {
                margin-left: 75px;
                line-height: 20px;
                color: #666;
                font-size: 14px;
                float: left;
                padding: 5px 0px;
            }
            body{background:#fff;}
    </style>
</head>

<body>
    <input type="hidden" id="CurrentID" />
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a href="/HZ_Index.aspx" class="logo fl">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl">
               <%-- <img src="/images/jiaoxuehuodong.png" />--%>
            </div>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li class="active"><a  href="#" onclick="ChangeSrc('http://flytsp:47039/sites/Teacher/TeacherScientific/SitePages/ManagerProject.aspx',this,'passport')">科研管理</a></li>                   
                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="javascript:;" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                         <%--<a href="/Gopay/GoPay.aspx" target="_blank"><span>账户管理</span></a>--%>
                          <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item  pt90">
        <div class="myexam bordshadrad width" style="padding:0px;">

            <div class="mycourse">
                <iframe src="http://flytsp:47039/sites/Teacher/TeacherScientific/SitePages/ManagerProject.aspx" width="100%" height="1200px" id="iframeContent" scrolling="no" allowtransparency="true" frameborder="no" ></iframe>
            </div>
        </div>
    </div>
    <!--预览试卷-->

    <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/system.js"></script>
    <script>
        function ChangeSrc(src, em, pass) {
            $(em).parent().addClass('active').siblings().removeClass("active");
            var param = "";
            if (pass != null) {
                var info = $.parseJSON($.cookie('LoginCookie_Cube'));
                var user = encrypt(info.LoginName);
                var pwd = encrypt($.cookie("PwdCookie_Cube"));
                param = "?user=" + user + "&pwd=" + pwd;
            }
            $("#iframeContent").attr("src", src + param);
        }

        /*
        *功能：对url加密算法（只针对window.location.href跳转，不针对post表单提交及ajax方式）
        *算法：对于暴露在浏览器地址栏中的属性值进行加密，如一个属性为agentID=1，
        *     若对1加密后为k230101io934jksd32r4，说明如下：
        *     前三位为随机数；
        *     第四到第五位为要加密字符转换成16进制的位数，
        *       如：要加密字符为15转换成16进制为f，位数为1，则第四、五位为01；
        *     第六位标识要加密字符为何种字符，0：纯数字，1：字符
        *       若是字符和数字的混合，则不加密；
        *     从第七位开始为16进制转换后的字符（字母和非数字先转换成asc码）；
        *     若加密后的字符总位数不足20位，则用随机数补齐到20位，若超出20位，则不加随机数。
        *     即加密后总位数至少为20位。
        */
        function encode16(str) {
            str = str.toLowerCase();
            if (str.match(/^[-+]?\d*$/) == null) {//非整数字符，对每一个字符都转换成16进制，然后拼接
                var s = str.split("");
                var temp = "";
                for (var i = 0; i < s.length; i++) {
                    s[i] = s[i].charCodeAt();//先转换成Unicode编码
                    s[i] = s[i].toString(16);
                    temp = temp + s[i];
                }
                return temp + "{" + 1;//1代表字符
            } else {//数字直接转换成16进制
                str = parseInt(str).toString(16);
            }
            return str + "{" + 0;//0代表纯数字
        }


        function produceRandom(n) {
            var num = "";
            for (var i = 0; i < n; i++) {
                num += Math.floor(Math.random() * 10);
            }
            return num;
        }

        //主加密函数
        function encrypt(str) {
            var encryptStr = "";//最终返回的加密后的字符串
            encryptStr += produceRandom(3);//产生3位随机数

            var temp = encode16(str).split("{");//对要加密的字符转换成16进制
            var numLength = temp[0].length;//转换后的字符长度
            numLength = numLength.toString(16);//字符长度换算成16进制
            if (numLength.length == 1) {//如果是1，补一个0
                numLength = "0" + numLength;
            } else if (numLength.length > 2) {//转换后的16进制字符长度如果大于2位数，则返回，不支持
                return "";
            }
            encryptStr += numLength;

            if (temp[1] == "0") {
                encryptStr += 0;
            } else if (temp[1] == "1") {
                encryptStr += 1;
            }

            encryptStr += temp[0];

            if (encryptStr.length < 20) {//如果小于20位，补上随机数
                var ran = produceRandom(20 - encryptStr.length);
                encryptStr += ran;
            }
            return encryptStr;
        }
    </script>
</body>
</html>

