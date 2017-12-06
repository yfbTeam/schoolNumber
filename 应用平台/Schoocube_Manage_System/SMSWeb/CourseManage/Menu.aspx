<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="SMSWeb.CourseManage.Menu" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <title>菜单管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/CourseMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="Term.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->

</head>
<body>

    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <form id="form1" runat="server">
        <input id="option" type="hidden" value=">" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>

                <nav class="navbar menu_mid fl">

                    <ul id="Menu">
                        <li currentclass="active"><a href="SystemParam.aspx">系统参数</a></li>
                        <li currentclass="active"><a href="#" onclick="ChangeSrc('/MenuInfo/MenuInfo.aspx',this)">菜单管理</a></li>
                        <li currentclass="active"><a href="#" onclick="ChangeSrc('/Up_Image/Up_Image.aspx',this)">菜单图标</a></li>
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
                                <h2><%=Name %></h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr ">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>
        <div class="onlinetest_item width pt90">
            <iframe src="/MenuInfo/MenuInfo.aspx" width="100%" height="800px" id="iframeContent"></iframe>
        </div>
    </form>
</body>
<script type="text/javascript" src="/js/common.js"></script>

<script type="text/javascript">
    var UrlDate = new GetUrlDate()
    function ChangeSrc(src, em) {
        $(em).parent().addClass('active').siblings().removeClass("active");
        $("#iframeContent").attr("src", src);
    }
    $(function () {
        if (UrlDate.Type == "1") {
            $("#Menu").children("li").eq(1).addClass('active').siblings().removeClass("active");
            $("#iframeContent").attr("src", "/MenuInfo/MenuInfo.aspx");
        }
        else {
            $("#Menu").children("li").eq(2).addClass('active').siblings().removeClass("active");
            $("#iframeContent").attr("src", "/Up_Image/Up_Image.aspx");
        }
    });
</script>
</html>
