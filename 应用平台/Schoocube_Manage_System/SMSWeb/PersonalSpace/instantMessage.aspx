<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="instantMessage.aspx.cs" Inherits="SMSWeb.PersonalSpace.instantMessage" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>即时消息</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
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
    </style>
</head>

<body>
    <input type="hidden" id="CurrentID" />
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li class="active"><a href="#" onclick="ChangeSrc('http://192.168.1.101:1009/ChatManage.aspx',this)">群组管理</a></li>
                    <li><a href="#" onclick="ChangeSrc('http://192.168.1.101:1009/SelectChatRoom.aspx?name=<%=Name%>',this)">消息发送</a></li>
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
                <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90">
        <div class="course_manage bordshadrad">
            <%--<div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="javascript:;" class="on" onclick="ChangeSrc('/SysMessage/UsersMessage.aspx?Type=0',this)">班级通知</a>
                    <a href="javascript:;" onclick="ChangeSrc('http://192.168.1.101:9010/index.aspx',this)">班级论坛</a>
                    <a href="javascript:;" onclick="ChangeSrc('/SysMessage/EmailtemList.aspx?Type=0',this)">电子邮件</a>
                    <a href="javascript:;" onclick="ChangeSrc('/Library.aspx',this)">知识库</a>
                    <a href="javascript:;" onclick="ChangeSrc('/Exam/test.aspx',this)">考试</a>
                    <a href="javascript:;" onclick="ChangeSrc('/Questionnaire/MyOption.aspx',this)">问卷调查</a>
                    <a href="javascript:;" onclick="ChangeSrc('/analysisa/Student_InfoSum.aspx',this)">学员信息汇总</a>
                    <a href="javascript:;" onclick="ChangeSrc('/SysMessage/SmsItemList.aspx',this)">短信管理</a>
                    <a href="javascript:;" onclick="ChangeSrc('/SysMessage/WebMessage.aspx',this)">站内信</a>
                    <a href="javascript:;" onclick="ChangeSrc('http://192.168.1.101:1009/SelectChatRoom.aspx?name=<%=LoginName%>',this)">即时消息</a>
                </div>
            </div>--%>

            <div class="wrap">
                <iframe src="http://192.168.1.101:1009/ChatManage.aspx" width="100%" height="1200px" id="iframeContent"></iframe>

            </div>
        </div>
    </div>
    <!--预览试卷-->
    <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/PortalImages/logoBefore.png" alt="" style="margin-top: 10px;" />
            </div>
            <div class="footer_right fr">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>
                    传真：010-62463259   网址：<a href="http://www.bjybjx.cn" target="_blank" style="color: #fff;">http://www.bjybjx.cn</a>
                </p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
            </div>
        </div>
    </footer>
    <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/system.js"></script>
    <script>
        function ChangeSrc(src, em) {
            $(em).parent().addClass('active').siblings().removeClass("active");
            $("#iframeContent").attr("src", src);
        }
    </script>
</body>
</html>
