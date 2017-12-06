<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NoticeDetails.aspx.cs" Inherits="SMSWeb.Portal.Notice.NoticeDetails" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>发布信息详细</title>
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
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
    <script src="../../PortalJs/syslogin.js"></script>
    <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
     <script src="../../Scripts/jquery.tmpl.js"></script>
    <script src="../../Scripts/PageBar.js"></script>
    <script src="../../PortalJs/header.js"></script>
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
        <input id="NoticeId" runat="server" type="hidden" />
        <asp:HiddenField ID="HMenuId" runat="server" Value="11" />
        <asp:HiddenField ID="HType" runat="server" />
        <asp:HiddenField ID="HUserName" runat="server" />
        <asp:HiddenField ID="HUserIdCard" runat="server" />
        <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <div class="weixin fl">
                        <span></span>
                        官方微信

                    </div>
                    <a href="/Portal/Certificate/Query.aspx" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <%--<iframe name="htmlHeader" src="../headerTop.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>--%>
        <%--<div id="htmlHeader" style="min-height:155px;"></div>--%>
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
            <div class="leftnav fl">
                <h1>
                    <span class="school_zn" id="hTitle">信息详情</span>
                    <span class="school_zy" id="szTitle">Notices</span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content fr">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a><span>&gt;</span><a href="" id="aTitleMenu"></a>
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
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            leftTree();
            addClickNumer();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/NoticesHandler.ashx",
                    "func": "GetNoticeAll",
                    "Id": $("#NoticeId").val()
                },
                success: function (json) {
                    if (json.result.status == "ok") {
                        var dtJson = json.result.retData;
                        if (dtJson != null && dtJson.length > 0) {
                            var item = dtJson[0];
                            $("#noticeTitle").html(item.Title);
                            //$("#noticeImg").html("<img src='" + item.ShowImgUrl + "' />");
                            $("#Contents").html(item.Contents);
                            $("#aTypeMenu").html(ShowNewsType(item.Type));
                            $("#aTypeMenu").attr("href", "NoticeItemList.aspx?Type=" + item.Type);
                            $("#aTitleMenu").html(item.Title);
                            //访问率分析//
                            addMonnitor(3, item.Id, item.Title, 0, $("#HUserName").val(), $("#HUserIdCard").val());
                            ///
                        }
                    }
                },
                error: OnError
            });
            
        })

        function addClickNumer()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/NoticesHandler.ashx", Func: "UpdateNotice", Id: $("#NoticeId").val(), ClickNum: "1" },
                success: function (json) {
                   
                },
                error: function (errMsg) {
                   
                }
            });
        }

        function escape2Html(str) {
            var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
            return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
        }

        var TreeArry = [{ id: 0, val: "通知公告" }, { id: 1, val: "学校新闻" }, { id: 2, val: "媒体报道" }, { id: 3, val: "招聘信息" }];
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
                    $("#HUserName").val(UserInfo.Name);
                    $("#HUserIdCard").val(UserInfo.IDCard);
                }
            }
        }
    </script>
</body>
</html>
