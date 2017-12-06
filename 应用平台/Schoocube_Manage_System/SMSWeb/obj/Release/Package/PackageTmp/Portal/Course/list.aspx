<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="list.aspx.cs" Inherits="SMSWeb.Portal.Course.list" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>课程展示</title>
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../PortalJs/layout.js"></script>
    <script src="../../Scripts/Common.js"></script>  
    <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <script src="../../PortalJs/syslogin.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js" type="text/javascript"></script>
    <script src="/Scripts/jquery.tmpl.js" type="text/javascript"></script>
    <script src="../../PortalJs/header.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
         .search_wrap{margin-top:20px;}
            .search_wrap input[type=text]{float: left;
                height: 26px;
                border: 1px solid #9ec5e2;
                border-radius: 2px;
                width: 278px;
                text-indent:10px;
            }
            .search_wrap input[type=button] {
                background: #1472b9;
                padding: 7px 10px;
                font-size: 14px;
                color: #fff;
                border-radius: 0px 0px 2px 2px;border:none;
            }
            .course_type {
                width: 70px;
                height: 70px;
                color: #fff;
                font-size: 14px;
                position: absolute;
                left: -35px;
                top: -35px;
                line-height: 120px;
                text-align: center;
                transform: rotate(-45deg);
                -webkit-transform: rotate(-45deg);
                -moz-transform: rotate(-45deg);
                -ms-transform: rotate(-45deg);
            }
            .course_bixiu {
                background: #19c857;
            }.course_xuanxiu{background: #f6a20f;}

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
                    background: url(../PortalImages/sprite.png) no-repeat 0 0;
                    margin: 6px 5px 6px 0px;
                }

        .weixin span {
            width: 22px;
            height: 22px;
            display: block;
            background: url(../PortalImages/sprite.png) no-repeat 0px -26px;
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
            background: url("../PortalImages/nav_rightbg.png") no-repeat right center;
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
                background: url(../PortalImages/hover_nav.png) no-repeat;
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
    <%--<script id="tr_data" type="text/x-jquery-tmpl">
        <li>
            <a href="${hrefShow(ID)}">
                <div class="img_school">
                    {{if ImageUrl==""}}
                    <img src="${ImageUrl}" alt="" />
                    {{else}}
                     <img src="${ImageUrl}" alt="" />
                    {{/if}}
                </div>
                <p>${Name}</p>
            </a>
        </li>
    </script>--%>
        <script type="text/x-jquery-tmpl" id="tr_data">
        <li class="clearfix">
            <div class="l-s fl" style="width:238px;height:175px;position:relative;">
                <a href="${hrefShow(ID)}">
                    {{if ImageUrl==""}}
                    <img src="/PortalImages/defaultimg.jpg" alt="" width="238" height="175" />
                    {{else}}
                     <img src="${ImageUrl}" alt="" width="238" height="175"/>
                    {{/if}}
                    </a>
                <div class="course_type course_bixiu">
                     {{if IsCharge==1}}收费
                   {{else}}免费
                   {{/if}}
                </div>
            </div>
            <div class="r-s fl" style="height:175px;overflow:hidden;">
                <h3 class="n"><a href="${hrefShow(ID)}">${Name}</a></h3>
                <p>${CourseIntro}</p>
            </div>
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
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="Hid_ClassID" runat="server" />
        <input type="hidden" id="HRoleType" runat="server" />
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
      <%--  <iframe name="htmlHeader" src="../header.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>--%>
     <%--     <div id="htmlHeader" style="min-height:155px;"></div>--%>
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
                    <span class="school_zn" id="hTitle">课程展示</span>
                    <span class="school_zy" id="szTitle">Course</span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content fr">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="#" id="aTypeMenu"></a>
                </h1>
                <div class="search_wrap">
                    <input type="text" name="CourseName" value=" " placeholder="课程名称" id="CourseName"   runat="server"/>
                    <input type="button" name="name" value="查询" id="btnQuery" />
                    <input type="button" name="name" value="加入收藏 " class="fr" id="CourseFavorite" />
                </div>
                <div class="content_detail" style="padding: 10px 0px;">
                    
                    <ul class="o-list" id="tb_data">
                    </ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>

                <%--<div class="content_detail" style="padding: 10px 0px;">
                    <h1 class="title"></h1>
                    <ul class="img_lists clearfix" id="tb_data">
                    </ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>--%>


            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        var UserInfo = null;
        $(document).ready(function () {
            //$("#htmlHeader").load("/Portal/headerTop.html");
            getUserInfoCookie();
            getData(1, 5);
            leftTree();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
            $("#btnQuery").on("click", function () {
                btnQuery();
            })
            $("#CourseFavorite").on("click", function () {
                var title = "课程展示筛选条件" + $("#CourseName").val();
                var url=window.location+"&coursename="+$("#CourseName").val();
                AddFavorite(title, url);
            })

        });

        function getData(startIndex, pageSize) {
            //初始化序号 
            //pageNum = (startIndex - 1) * pageSize + 1;
            if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "OnlineLearning/MyLessonsHandler.ashx",
                        Func: "GetMyLessonsByType",
                        CourseType: 3,
                        PageIndex: startIndex,
                        pageSize: pageSize,
                        Name:$("#CourseName").val()
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            $("#tb_data").html('');
                            $("#tr_data").tmpl(json.result.retData.PagedData).appendTo("#tb_data");
                            makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 5, json.result.retData.RowCount);
                        }
                        else {
                            $("#tb_data").html("");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            } else {
                if ($("#HRoleType").val() == "学生") {
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                            Func: "GetMyLessonsDataPage",
                            PageIndex: startIndex,
                            pageSize: pageSize,
                            ispage: true,
                            ClassID: $("#Hid_ClassID").val(),
                            StuNo: $("#HUserIdCard").val(),
                            Name: $("#CourseName").val()
                        },
                        success: function (json) {
                            var href = "";
                            if (json.result.errNum.toString() == "0") {
                                $("#tb_data").html('');
                                $("#tr_data").tmpl(json.result.retData.PagedData).appendTo("#tb_data");
                                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 5, json.result.retData.RowCount);
                            }
                            else {
                                $("#tb_data").html("暂无课程！");
                            }
                        },
                        error: OnError
                    });
                } else {
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "CourseManage/CourceManage.ashx",
                            Func: "GetPageList",
                            PageIndex: startIndex,
                            pageSize: pageSize,
                            IdCard: $("#HUserIdCard").val(),
                            Name: $("#CourseName").val()
                        },
                        success: function (json) {
                            var href = "";
                            if (json.result.errNum.toString() == "0") {
                                $("#tb_data").html('');
                                $("#tr_data").tmpl(json.result.retData.PagedData).appendTo("#tb_data");
                                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 5, json.result.retData.RowCount);
                            }
                            else {
                                $("#tb_data").html("暂无课程！");
                            }
                        },
                        error: OnError
                    });
                }

            }
        }

        function leftTree() {
            var html = "<a href=\"#\" data-url=\"/Portal/Course/list.aspx\" class=\"on\" >课程展示</a>";
            $("#div_leftTree").html(html);
            $("#aTypeMenu").html("课程展示");
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
            //                        $("#aTypeMenu").html("课程展示");
            //                        //$("#aTypeMenu").html(items[i].Name);
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

        function btnQuery()
        {
            getData(1, 5);
        }

        function AddFavorite(title, url) {
            url = encodeURI(url);
            try {
                window.external.addFavorite(url, title);
            }
            catch (e) {
                try {
                    window.sidebar.addPanel(title, url, "");
                }
                catch (e) {
                    alert("抱歉，您所使用的浏览器无法完成此操作。\n\n加入收藏失败，请进入新网站后使用Ctrl+D进行添加");
                }
            }
        }

        function hrefShow(cid) {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                if ($("#HRoleType").val() == "学生") {
                    return "/OnlineLearning/StuLessonDetail.aspx?itemid=" + cid + "&flag=0";
                } else if ($("#HRoleType").val() == "教师") {
                    return "/CourseManage/CourseDetail.aspx?itemid=" + cid + "&ParentID=20&PageName=/CourseManage/CourseIndex.aspx";
                }
            } else {
                return "javascript:OpenIFrameWindow('用户登录', '/Portal/login.aspx?url=course&paramsid="+cid+"', '700px', '500px')";
            }
        }

        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserIdCard").val(UserInfo.IDCard);
                    $("#HUserName").val(UserInfo.LoginName);
                    $("#Hid_ClassID").val(UserInfo.ClassID);
                    $("#HRoleType").val(UserInfo.SF);
                }
            }
        }
    </script>
</body>
</html>
