﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AfterImgView.aspx.cs" Inherits="SMSWeb.Portal.about.AfterImgView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <style type="text/css">
        .game163 {
            position: relative;
            border: 1px solid #dcdddd;
            padding: 4px;
            overflow: hidden;
            width: 745px;
        }

            .game163 .bigImg {
                height: 350px;
                position: relative;
            }

                .game163 .bigImg li a {
                    vertical-align: middle;
                    width: 745px;
                    height: 450px;
                    overflow:hidden;
                    display:block;
                }
                .game163 .bigImg li a img{width:100%;}
                .game163 .bigImg h4 {
                    font-size: 14px;
                    font-weight: bold;
                    line-height: 33px;
                    height: 33px;
                    padding-right: 30px;
                    overflow: hidden;
                    text-align: left;
                }

            .game163 .smallScroll {
                height: 120px;
                margin-bottom: 6px;
            }

            .game163 .sPrev, .game163 .sNext {
                float: left;
                display: block;
                width: 14px;
                height: 47px;
                margin-top: 32px;
                text-indent: -9999px;
                background: url(/PortalImages/sprites1008.png) no-repeat 0 -3046px;
            }

            .game163 .sNext {
                background-position: 0 -2698px;
            }

            .game163 .sPrev:hover {
                background-position: 0 -3133px;
            }

            .game163 .sNext:hover {
                background-position: 0 -2785px;
            }

            .game163 .smallImg {
                float: left;
                margin: 0 6px;
                display: inline;
                width: 705px;
                overflow: hidden;
            }

                .game163 .smallImg ul {
                    height: 123px;
                    width: 9999px;
                    overflow: hidden;
                }

                .game163 .smallImg li {
                    float: left;
                    padding: 0 4px 0 0;
                    width: 173px;
                    cursor: pointer;
                    display: inline;
                }

                .game163 .smallImg a {
                    border: 1px solid #dcdddd;
                    width: 173px;
                    height: 120px;
                    overflow:hidden;
                    display:block;
                }
                 .game163 .smallImg a img{width:100%;}
                .game163 .smallImg .on img {
                    border-color: #1e50a2;
                }

            .game163 .pageState {
                position: absolute;
                top: 450px;
                right: 5px;
                font-family: "Times New Roman", serif;
                letter-spacing: 1px;
            }

                .game163 .pageState span {
                    color: #f00;
                    font-size: 16px;
                }
    </style>
    <style>
        .width {
            width: 1024px;
            margin: 0 auto;
        }

        #header .top {
            width: 100%;
            height: 34px;
            background: #333333;
        }

            #header .top .top_con {
                height: 34px;
                font-size: 12px;
                line-height: 34px;
                color: #fff;
            }

                #header .top .top_con h1 .tel {
                    width: 22px;
                    height: 22px;
                    display: block;
                    float: left;
                    background: url(/PortalImages/sprite.png) no-repeat 0 0;
                    margin: 6px 5px 6px 0px;
                }

        .weixin span {
            width: 22px;
            height: 22px;
            display: block;
            background: url(/PortalImages/sprite.png) no-repeat 0px -26px;
            margin: 6px 5px 6px 0px;
            float: left;
        }

        .login_resig {
            margin-left: 20px;
        }

            .login_resig a {
                padding: 0px 5px;
                color: #fff;
            }
        /*logo*/
        .logo_search {
            padding: 25px 0px;
        }

        .search {
            height: 32px;
            width: 300px;
            border-radius: 2px;
            border: 2px solid #2562ba;
            margin: 10px 0px;
        }

            .search input[type=text] {
                text-indent: 2em;
                width: 240px;
                height: 30px;
                border: none;
                outline: none;
            }

            .search input[type=submit] {
                width: 57px;
                height: 32px;
                border: none;
                background: #2562ba;
                color: #fff;
                font-size: 12px;
            }
        /*nav*/
        /*nav*/
        .nav {
            width: 100%;
            background: #2562ba;
            height: 40px;
            text-align: center;
            margin: auto;
            position: relative;
        }

        .nav_a ul.nav_b li {
            background: url("/PortalImages/nav_rightbg.png") no-repeat right center;
            float: left;
            font-family: "微软雅黑";
            font-size: 16px;
            line-height: 40px;
            position: relative;
            text-align: center;
            width: 100px;
        }
            /*.nav_a ul.nav_b li:hover { background:#0296f4;}*/
            .nav_a ul.nav_b li .xiala dt.hover {
                background: url(/PortalImages/hover_nav.png) no-repeat;
                background-size: 100%;
            }

            .nav_a ul.nav_b li .xiala dt {
                height: 40px;
            }

            .nav_a ul.nav_b li a {
                color: #fff;
                display: block;
            }

        .lie {
            display: none;
            left: 0;
            position: absolute;
            top: 40px;
            z-index: 200;
        }

            .lie ul.liea li {
                background: #0077DB;
                height: 28px;
                line-height: 28px;
                width: 100px;
            }

                .lie ul.liea li:hover {
                    background: #0296f4;
                }

                .lie ul.liea li a {
                    color: #fff;
                    display: block;
                    font-size: 14px;
                    font-weight: normal;
                }

                    .lie ul.liea li a:hover {
                        text-decoration: underline;
                    }
        /*banner*/
        .banner_bg {
            width: 100%;
            height: 300px;
            box-shadow: 0px 3px 30px 0px rgba(0,0,0,.2);
        }

        .slider {
            width: 100%;
            height: 300px;
            position: relative;
            overflow: hidden;
        }

            .slider ul li a {
                display: block;
                width: 100%;
                height: 300px;
            }
            /*数字按钮样式*/
            .slider .num {
                width: 100%;
                height: 14px;
                bottom: 15px;
                position: absolute;
                text-align: center;
                z-index: 1;
            }

                .slider .num ul {
                    display: inline-block;
                    height: 14px;
                    vertical-align: top;
                }

                .slider .num li {
                    display: inline-block;
                    width: 12px;
                    text-indent: -9999px;
                    height: 12px;
                    border: 1px solid #ef8222;
                    float: left;
                    border-radius: 100%;
                    background: #fff;
                    margin-left: 5px;
                    cursor: pointer;
                }

                    .slider .num li.on {
                        background: #ef8222;
                    }
    </style>
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../PortalJs/layout.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <script src="../../PortalJs/syslogin.js"></script>
    <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../Scripts/jquery.tmpl.js"></script>
    <script src="../../PortalJs/jquery.superslide.2.1.1.js"></script>
    <script src="../../PortalJs/header.js"></script>
    <script id="tr_top_item" type="text/x-jquery-tmpl">
        <li>
            <a href="#">
                <img src="${ImageUrl}" /></a>
            <h4><a href="#">${Title}</a></h4>
        </li>
    </script>
    <script id="tr_down_item" type="text/x-jquery-tmpl">
        <li>
            <a>
                <img src="${ImageUrl}" /></a>
        </li>
    </script>

    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        {{if Id!=$("#HMenuId").val()}}
        <a href="#" data-url="${BeforeUrl}">${Name}</a>
        {{else}}
        <a href="#" class="on" data-url="${BeforeUrl}">${Name}</a>
        {{/if}}
        {{/if}}
    </script>
    <title>北京仪器仪表高级技工学校</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="HSSId" runat="server" />
        <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <div class="weixin fl">
                        <span></span>
                        官方微信
                    </div>
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                    <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <%--<iframe name="htmlHeader" src="../headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="160px"></iframe>--%>
        <%--<div id="htmlHeader" style="min-height: 155px;"></div>--%>
        <div id="header">

            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <a href="/Portal/index.aspx"><img src="/PortalImages/logo.png" /></a>
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
        <div class="main width clearfix  mb20" style="margin-top: 20px;">
            <!--leftnav-->
            <div class="leftnav fl">
                <h1>
                    <span class="school_zn" id="hTitle"></span>
                    <span class="school_zy" id="szTitle"></span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content fr">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail">
                    <div class="game163" style="margin: 0 auto">
                        <ul class="bigImg" id="ultop">
                        </ul>

                        <div class="smallScroll">
                            <a class="sPrev" href="javascript:void(0)">←</a>
                            <div class="smallImg">
                                <ul id="uldown">
                                </ul>
                            </div>
                            <a class="sNext" href="javascript:void(0)">→</a>
                        </div>

                        <div class="pageState"></div>

                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>
    </form>
    <script type="text/javascript">
        var index = 0;
        //大图切换
        $(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            leftTree();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
            initData();
        })

        function initData() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/SchoolStyle.ashx",
                    Func: "GetPageList",
                    MenuId: $("#HMenuId").val(),
                    isPage: false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_data").html('');
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            if ($("#HSSId").val() != "") {
                                for (var i = 0; i < items.length; i++) {
                                    if (items[i].Id == $("#HSSId").val()) {
                                        index = i;
                                        break;
                                    }

                                }
                            }
                        }
                        $("#tr_top_item").tmpl(items).appendTo("#ultop");
                        $("#tr_down_item").tmpl(items).appendTo("#uldown");
                        jQuery(".game163").slide({
                            titCell: ".smallImg li",
                            mainCell: ".bigImg",
                            effect: "fold",
                            defaultIndex: index,
                            autoPlay: true,
                            delayTime: 200,
                            startFun: function (i, p) {
                                //控制小图自动翻页
                                if (i == 0) { jQuery(".game163 .sPrev").click() } else if (i % 4 == 0) { jQuery(".game163 .sNext").click() }
                            }
                        });

                        //小图左滚动切换
                        jQuery(".game163 .smallScroll").slide({ defaultIndex: index, mainCell: "ul", delayTime: 100, vis: 4, scroll: 4, effect: "left", autoPage: true, prevCell: ".sPrev", nextCell: ".sNext", pnLoop: false });

                    }
                    else {
                        $("#ultop").html("");
                        $("#uldown").html("");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function leftTree() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "GetPortalTreeDataForChildId",
                    MenuId: $("#HMenuId").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#div_leftTree").html('');
                        var items = json.result.retData;
                        $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                if (items[i].PId == "0") {
                                    $("#hTitle").html(items[i].Name);
                                    $("#szTitle").html(items[i].EnName);
                                }
                                if (items[i].Id == $("#HMenuId").val()) {
                                    $("#aTypeMenu").html(items[i].Name);
                                }
                            }
                        }
                    }
                    else {
                        $("#div_leftTree").html("暂无数据！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
