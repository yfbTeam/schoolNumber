<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeItemList.aspx.cs" Inherits="SMSWeb.Portal.Notice.NoticeItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>信息展示</title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet"  id="mystylesheet" runat="server"/>
    <link href="/PortalCss/left.css" rel="stylesheet" id="myskin" runat="server" />
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
    <script src="//PortalJs/syslogin.js"></script>
    <script src="//Scripts/jquery.cookie.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//PortalJs/header.js"></script>
    <script id="item_news" type="text/x-jquery-tmpl">
        <li>
            <b></b><a href="NoticeDetails.aspx?Id=${Id}&Type=${Type}">${NameLengthUpdate(Title,30)}</a><span>${DateTimeConvert(CreateTime,'yyyy-MM--dd')}</span>
        </li>
    </script>
    <%--<script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        {{if Id!=$("#HMenuId").val()}}
        <a href="#" data-url="${BeforeUrl}">${Name}</a>
        {{else}}
        <a href="#" class="on" data-url="${BeforeUrl}">${Name}</a>
        {{/if}}
        {{/if}}
    </script>--%>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HType" runat="server" />
        <asp:HiddenField ID="HMenuId" runat="server" Value="11" />
        <asp:HiddenField ID="PageNumber" runat="server" />
        <input type="hidden" id="HRoleType" />
        <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <a href="#htmlFoot" name="#htmlFoot">
                        <div class="weixin fl" style="color:#fff">
                            <span></span>
                            官方微信

                        </div>
                    </a>
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                     <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <%--<iframe name="htmlHeader" src="/headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>--%>
        <%-- <div id="htmlHeader" style="min-height:155px;"></div>--%>
        <div id="header">
            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <a href="/Portal/index.aspx">
                        <img src="/PortalImages/logo.png" /></a>
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
            <div class="leftnav">
                <h1>
                    <span class="school_zn" id="hTitle">信息</span>
                    <span class="school_zy" id="szTitle">Notices</span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail">
                    <ul class="news_lists" id="newsList">
                    </ul>
                    <div class="page mt10">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" id="htmlFoot" src="/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            leftTree();
            getUserInfoCookie();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
            initNotice(1, $("#PageNumber").val());
            $("#aTypeMenu").html(ShowNewsType($("#HType").val()));
        })

        var TreeArry = [{ id: 0, val: "通知公告" }, { id: 1, val: "学校新闻" }, { id: 2, val: "媒体报道" }, { id: 3, val: "招聘信息" }];
        function initNotice(startIndex, pageSize) {
            var root = 0;
            if ($("#HRoleType").val() == "教师") {
                root = 1;
            } else if ($("#HRoleType").val() == "学生") {
                root = 2;
            }
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/NoticesHandler.ashx",
                    "func": "GetPageList",
                    "PageIndex": startIndex,
                    "PageSize": pageSize,
                    "type": $("#HType").val(),
                    "Root": root,
                    "isPush": 1
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var dtJson = json.result.retData;
                        if (dtJson != null) {
                            $("#newsList").html('');
                            $("#item_news").tmpl(dtJson.PagedData).appendTo("#newsList");
                            makePageBar(initNotice, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, $("#PageNumber").val(), json.result.retData.RowCount);
                        }
                    } else {
                        $("#newsList").html("暂无新闻！");
                    }
                },
                error: OnError
            });
        }

        function leftTree() {
            var html = "";
            for (var i = 0; i < TreeArry.length; i++) {
                if ($("#HType").val() == TreeArry[i].id)
                    html += "<a href=\"#\" data-url=\"/Portal/Notice/NoticeItemList.aspx?Type=" + TreeArry[i].id + "\" class=\"on\" >" + TreeArry[i].val + "</a>";
                else
                    html += "<a href=\"#\" data-url=\"/Portal/Notice/NoticeItemList.aspx?Type=" + TreeArry[i].id + "\">" + TreeArry[i].val + "</a>";
            }
            $("#div_leftTree").html(html);
            //$.ajax({
            //    url: "/Common.ashx",
            //    type: "post",
            //    async: false,
            //    dataType: "json",
            //    data: {
            //        PageName: "PortalManage/AdminManager.ashx",
            //        Func: "GetPortalTreeDataForChildId",
            //        MenuId: $("#HMenuId").val()
            //    },
            //    success: function (json) {
            //        if (json.result.errMsg == "success") {
            //            $("#div_leftTree").html('');
            //            var items = json.result.retData;
            //            $("#tr_leftTree").tmpl(items).appendTo("#div_leftTree");
            //            if (items != null) {
            //                for (var i = 0; i < items.length; i++) {
            //                    if (items[i].PId == "0") {
            //                        $("#hTitle").html(items[i].Name);
            //                        $("#szTitle").html(items[i].EnName);
            //                    }
            //                    if (items[i].Id == $("#HMenuId").val()) {
            //                        $("#aTypeMenu").html(items[i].Name);
            //                    }
            //                }
            //            }
            //        }
            //        else {
            //            $("#div_leftTree").html("暂无数据！");
            //        }
            //    },
            //    error: function (XMLHttpRequest, textStatus, errorThrown) {

            //    }
            //});
        }

        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HRoleType").val(UserInfo.SF);
                }
            }
        }
        
    </script>
</body>
</html>
