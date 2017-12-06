<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="header.aspx.cs" Inherits="SMSWeb.Portal.header" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet"  id="mystylesheet" runat="server"/>
    <link href="/PortalCss/left.css" rel="stylesheet" id="myskin" runat="server" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/PortalJs/jquery.superslide.2.1.1.js"></script>
    <script src="/PortalJs/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script type="text/javascript">
        $(function () {
            $(window).resize(function () {
                $('.slider .51buypic').width($(window).width());
                $('.slider .51buypic li').width($(window).width());
            });

        })
    </script>
    <script type="text/x-jquery-tmpl" id="bannerImg">
        <li style="background: url(${ImageUrl}) no-repeat center top; height: 300px;"></li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="header">

            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <img src="/PortalImages/logo.png" alt="" />
                </div>
                <!--<div class="search fr">
                <input type="text" placeholder="请输入关键词" />
                <input type="submit" value="搜索" />
            </div>-->
            </div>
            <!--nav-->
            <div class="nav">
                <div class="nav_a width">
                    <ul class="nav_b" id="menuList"></ul>
                </div>
            </div>
        </div>
        <!--banner-->
        <div class="banner_bg">
            <div class="banner">
                <div class="slider">
                    <ul class="51buypic" id="bannerUL"></ul>
                    <div class="num">
                        <ul></ul>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $(function () {
                initMenu();
                initBanner();
                $(".resig").on('click', function () {

                });

                $(".login").on('click', function () {
                    window.parent.window.location.href = "/Login_hz.aspx";

                });
                $("#query").on('click', function () {
                    indow.parent.window.location.href = "/Portal/Certificate/Query.aspx";
                })
            })

            function initMenu() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdminManager.ashx",
                        "func": "GetBeforeMenu",
                        "IsDelete": 0,
                        "Display": 0,
                        "BeforeAfter": 0
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#menuList").html("");
                            $("#menuList").html(json.result.retData);

                            $('.xiala').hover(function () {
                                $(this).find('dt').addClass('hover');
                                $(this).find(".lie").show();
                            }, function () {
                                $(this).find('dt').removeClass('hover');
                                $(this).find(".lie").hide();
                            })

                        }
                    },
                    error: OnError
                });
            }

            function initBanner() {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "PortalManage/SchoolStyle.ashx",
                        Func: "GetPageList",
                        MenuId: 41,
                        PageIndex: 1,
                        pageSize: 8
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#bannerUL").html('');
                            $("#bannerImg").tmpl(json.result.retData.PagedData).appendTo("#bannerUL");
                        }
                        else {
                            $("#bannerUL").html("<li>暂无数据！</li>");
                        }
                        $(".slider").slide({ titCell: ".num ul", mainCell: ".51buypic", effect: "fold", autoPlay: true, delayTime: 700, autoPage: true });
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            }

            function redirect() {
                window.parent.window.location.href = "/Portal/index.aspx";
            }

            function ResponstUrl(url) {
                window.parent.window.location.href = url;
            }
        </script>
    </form>
</body>
</html>
