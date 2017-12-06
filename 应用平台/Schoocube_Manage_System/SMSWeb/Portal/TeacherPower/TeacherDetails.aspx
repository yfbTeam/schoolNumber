﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherDetails.aspx.cs" Inherits="SMSWeb.Portal.TeacherPower.TeacherDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>师资力量详细</title>
    
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet"  id="mystylesheet" runat="server"/>
    <link href="/PortalCss/left.css" rel="stylesheet" id="myskin" runat="server" />
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
    <script type="text/javascript" src="//js/menu_top.js"></script>
    <script src="//PortalJs/syslogin.js"></script>
    <script src="//Scripts/jquery.cookie.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//PortalJs/header.js"></script>
    <script id="tr_leftTree" type="text/x-jquery-tmpl">
        {{if PId!=0}}
        {{if Id!=$("#HMenuId").val()}}
        <a href="#" data-url="${BeforeUrl}">${Name}</a>
        {{else}}
        <a href="#" class="on" data-url="${BeforeUrl}">${Name}</a>
        {{/if}}
        {{/if}}
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <asp:HiddenField ID="IDCard" runat="server" />
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
       <%-- <iframe name="htmlHeader" src="/headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>--%>
       <%-- <div id="htmlHeader" style="min-height:155px;"></div>--%>
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
        <div class="main width clearfix  mb20" style="margin-top:20px;">
            <!--leftnav-->
            <div class="leftnav">
                <h1>
                    <span class="school_zn" id="hTitle"></span>
                     <span class="school_zy" id="szTitle"></span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span><a href="" id="aListMenu"></a> <span>&gt;</span><a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail">

                    <h1 class="title" id="noticeTitle"></h1>
                    <p style="text-align: center" id="noticeImg">
                    </p>
                    <p id="Contents"></p>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" id="htmlFoot" src="/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            initData();
            leftTree();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
        })

        function initData() {
            if ($("#IDCard").val().length > 0) {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        IDCard: $("#IDCard").val(),
                        Func: "GetTeacherData"
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#teacherList").html('');
                            var items = json.result.retData;
                            if (items != null && items.length > 0) {
                                $("#noticeTitle").html(items[0].Name);
                                if (items[0].PhotoURL != "")
                                    $("#noticeImg").html("<img src=" + items[0].PhotoURL + " />");
                                else
                                    $("#noticeImg").html("<img src='/PortalImages/defaultteacher.jpg' />");
                                $("#Contents").html(items[0].BriefIntroduction);
                            }
                        }
                        else {
                            $("#teacherList").html("暂无教师信息！");
                        }
                    },
                    error: OnError
                });
            }
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
                                    $("#aListMenu").attr("href", "/Portal/TeacherPower/Teacher.aspx?id=" + $("#HMenuId").val());
                                    $("#aListMenu").html("师资力量");
                                    $("#aTypeMenu").html("师资详细");
                                    //$("#aTypeMenu").html(items[i].Name);
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
