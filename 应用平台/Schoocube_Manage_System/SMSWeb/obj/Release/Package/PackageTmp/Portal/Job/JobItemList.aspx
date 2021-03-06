﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobItemList.aspx.cs" Inherits="SMSWeb.Portal.Job.JobItemList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/PortalCss/reset.css" />
    <link rel="stylesheet" type="text/css" href="/PortalCss/layout.css" />
    <%--<link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />--%>
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
            .nav_a ul.nav_b li .xiala dt:hover {
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
    <style>
        .bordshadrad {
            border: 1px solid #C2C2C2;
            box-shadow: 0px 0px 1px #C2C2C2;
            border-radius: 2px;
        }

        .select {
            outline: none;
            margin-left: 5px;
            min-width: 88px;
            height: 28px;
            border: 1px solid #a1c7e3;
            border-radius: 2px;
            font-size: 14px;
            color: #1472b9;
            display: block;
            float: left;
            margin: 5px 0px;
            position: relative;
            cursor: pointer;
        }

        .width {
            width: 1200px;
            margin: 0 auto;
        }

        .employment_wrap {
            background: #fff;
        }

        .employment_select {
            border: 2px solid #a1c7e3;
            padding: 0px 10px;
            font-size: 16px;
            margin-top: 10px;
        }

        .employment_select_left {
            color: #666;
            line-height: 40px;
        }

            .employment_select_left span {
                color: #1783c7;
            }

        .employment_select_right label {
            line-height: 40px;
            color: #666666;
            font-size: 14px;
            float: left;
            margin-left: 5px;
        }

        .employment_select_right input {
            width: 138px;
            height: 26px;
            border: 1px solid #a1c7e3;
            border-radius: 2px;
            float: left;
            text-indent: 10px;
            margin-top: 5px;
        }

        .employment_lists ul li {
            position: relative;
            padding: 10px;
            border: 2px solid #a1c7e3;
            margin-top: 10px;
        }

            .employment_lists ul li .employment_list_right {
                border-left: 1px solid #a1c7e3;
                width: 309px;
                padding: 5px 0px 5px 20px;
                margin-right: 20px;
            }

                .employment_lists ul li .employment_list_right .company_name {
                    font-size: 18px;
                    color: #666;
                    line-height: 25px;
                }

                .employment_lists ul li .employment_list_right .work {
                    font-size: 16px;
                    color: #666;
                    line-height: 22px;
                }

                .employment_lists ul li .employment_list_right .deal {
                    margin-top: 5px;
                }

                    .employment_lists ul li .employment_list_right .deal span {
                        padding: 4px 12px;
                        background: #daebf9;
                        border: 1px solid #b6d7f2;
                        display: block;
                        float: left;
                        color: #1876be;
                        margin-right: 10px;
                    }

            .employment_lists ul li .employment_list_left {
                /*width: 765px;*/
                padding: 5px 30px 5px 0px;
            }

                .employment_lists ul li .employment_list_left .job {
                    font-size: 18px;
                    color: #1876be;
                    line-height: 25px;
                }

                .employment_lists ul li .employment_list_left .job_detail {
                    font-size: 18px;
                    color: #666;
                }

                    .employment_lists ul li .employment_list_left .job_detail em {
                        padding-right: 10px;
                        display: block;
                        float: left;
                        color: #ff6000;
                    }

                    .employment_lists ul li .employment_list_left .job_detail span {
                        padding: 0px 10px;
                        display: block;
                        float: left;
                        border-left: 1px solid #CCCCCC;
                    }

                .employment_lists ul li .employment_list_left .date_feedback span {
                    font-size: 14px;
                    color: #999;
                    padding-right: 10px;
                    display: block;
                    float: left;
                }

                .employment_lists ul li .employment_list_left .date_feedback .date {
                    border-right: 1px solid #ccc;
                }

            .employment_lists ul li .closeshow {
                position: absolute;
                right: 10px;
                top: 30PX;
            }

            .employment_lists ul li .recommend_courses {
                border-top: 1px dotted #a1c7e3;
                display: none;
            }

                .employment_lists ul li .recommend_courses .allcourses li {
                    border: 1px solid #e7e7e7;
                    position: relative;
                    width: 212px;
                    height: 160px;
                    margin: 10px 0px 10px 20px;
                    float: left;
                    overflow: hidden;
                    padding: 0;
                }

        .stytem_select {
            height: 48px;
            border-bottom: 3px solid #cfcfcf;
        }

            .stytem_select .stytem_select_left a.on {
                border-bottom: 3px solid #1472b9;
                color: #1472b9;
            }

            .stytem_select .stytem_select_left a {
                padding: 0px 10px;
                line-height: 48px;
                color: #555;
                font-size: 14px;
                display: inline-block;
            }

        .closeshow {
            width: 24px;
            height: 24px;
            display: inline-block;
            border-radius: 50%;
            border: 2px solid #A1C8E6;
            line-height: 24px;
            text-align: center;
            cursor: pointer;
            font-size: 16px;
            color: #0A73C0;
            margin-left: 10px;
        }

        .allcourses {
            margin-left: -20px;
        }

            .allcourses li .allcourse_img {
                width: 214px;
                height: 130px;
                overflow: hidden;
            }

            .allcourses li .course_type {
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
                z-index: 2;
            }

        .course_bixiu {
            background: #19c857;
        }

        .allcourses li .couese_title {
            padding: 5px 8px;
            color: #fff;
            background: #000;
            opacity: 0.6;
            filter: alpha(opacity=60);
            display: inline-block;
            font-size: 14px;
            position: absolute;
            right: 0;
            top: 0;
        }

        .allcourses li .course_name {
            height: 29px;
            padding: 0px 6px;
            font-size: 14px;
            color: #666666;
        }

            .allcourses li .course_name span {
                line-height: 29px;
            }

            .allcourses li .course_name a {
                display: block;
                border-radius: 2px;
                padding: 5px;
                color: #fff;
                float: right;
                margin-top: 3px;
            }

        .course_enroll {
            background: #19c857;
        }

        .course_xuanxiu {
            background: #f6a20f;
        }

        .job_description {
            padding: 5px 0px;
            line-height: 22px;
            color: #666;
            font-size: 15px;
        }

        .distributed {
            margin: 5px 0px;
        }

            .distributed a {
                background: #207abd;
                padding: 7px 12px;
                font-size: 14px;
                color: #fff;
                border-radius: 2px;
                display: inline-block;
                margin-right: 5px;
            }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/js/common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/PortalJs/header.js"></script>
    <script src="/PortalJs/syslogin.js"></script>
    <script type="text/x-jquery-tmpl" id="tr_Job">
        <li class="clearfix">

            <div class="employment_list_left">
                <div class="job">
                    ${Name}
                </div>
                 <h2 class="job_description">职位描述：${Introduction}
                </h2>
            </div>
            <span class="closeshow">+</span>
            <div class="recommend_courses">
               
                <ol class="allcourses clearfix" id="${ID}_Job">
                </ol>
            </div>
        </li>
    </script>

    <script id="tr_Course" type="text/x-jquery-tmpl">
        <li>
            <div class="allcourse_img">
                {{if ImageUrl==""}}
                    <img src="/PortalImages/defaultimg.jpg" alt="" width="238" height="175" />
                {{else}}
                     <img src="${ImageUrl}" alt="" width="238" height="175" />
                {{/if}}
            </div>
            <div class="course_type course_bixiu">
                {{if IsCharge==1}}收费
                   {{else}}免费
                   {{/if}}
            </div>
            <div class="couese_title">
                ${SubjectName}
            </div>
            <p class="course_name"><span>${Name}</span></p>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField  ID="hidJobID" runat="server"/>
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
        <div id="header">
            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <img src="/PortalImages/logo.png" />
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
        <%--<!--leftnav-->
        <div class="leftnav fl">
            <h1>
                <span class="school_zn" id="hTitle">职业导向</span>
                <span class="school_zy" id="szTitle">Job</span>
            </h1>
            <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
            </div>
        </div>--%>
        <div class="width" style="margin-top: 20px;">
            <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="#" id="aTypeMenu"></a>
            </h1>
            <div class="content_detail" style="padding: 10px 20px;">
                <div class="employment_wrap">
                    
                    <div class="employment_select clearfix">
                        <%--<div class="employment_select_left fl">
                            共为你找到 <span>100+</span>职位
                        </div>--%>
                        <div class="employment_select_right fl clearfix ml10">
                            <div class="clearfix fl">
                                <label for="">关键词：</label>
                                <input type="text" placeholder="不限" id="JobName" />
                            </div>
                            <div class="clearfix fl">
                                <label for="">发布时间：</label>
                                <select name="selDate" class="select" id="selDate">
                                    <option value="">请选择</option>
                                    <option value="0">一天之内</option>
                                    <option value="1">三天之内</option>
                                    <option value="2">一周之内</option>
                                    <option value="3">一个月之内</option>
                                </select>
                            </div>
                            <div class="clearfix fl">
                                <label for="">年薪范围：</label>
                                <input type="text" id="StarMoney" /><span class="fl" style="height:30PX;line-height:35px;">-</span><input type="text" id="EndMoney" />
                            </div>
                        </div>
                        <div class="distributed fr">
                            <a href="javascript:void(0);" onclick="javascript:Query()">搜索</a>
                        </div>
                    </div>
                    <div class="employment_lists">

                        <ul id="job_items">
                        </ul>
                    </div>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
            </div>
        </div>

        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(function () {
            
            leftTree();
            getData(1, 10);
        })
        function leftTree() {
            var html = "<a href=\"#\" data-url=\"/Portal/Course/list.aspx\" class=\"on\" >职业导向</a>";
            $("#div_leftTree").html(html);
            $("#aTypeMenu").html("职业导向");
        }

        function getData(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "GetPageItemList",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    NameIntro: $("#JobName").val(),
                    CreateTime: $("#selDate").val(),
                    StarMoney: $("#StarMoney").val(),
                    EndMoney: $("#EndMoney").val(),
                    ID: $("#hidJobID").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#job_items").html('');
                        var items = json.result.retData.PagedData;
                        $("#tr_Job").tmpl(items).appendTo("#job_items");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                        if (items != null && items.length > 0) {
                            var jobIdList = [];
                            $.each(items, (function (i, item) {
                                jobIdList.push(item.ID);
                            }));
                            if (jobIdList.length > 0) getCourseItems(jobIdList.toString());
                        }
                    }
                    else {
                        $("#job_items").html("<li>暂无数据！<li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getCourseItems(ids) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: { PageName: "PortalManage/JobHandler.ashx", Func: "GetCourseListByJobIds", "JobIDs": ids },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $('#job_items li').each(function () {
                                var ol = $(this).find('.allcourses');
                                var olid = ol[0].id.replace("_Job", "");
                                var courses = [];
                                $.each(items, function (index, item) {
                                    if (item.JobID == olid) {
                                        courses.push(item);
                                    }
                                })
                                if (courses != [] && courses.length > 0) $("#tr_Course").tmpl(courses).appendTo("#"+ol[0].id);
                            })
                            
                        } else {
                            $('#job_items li').each(function () {
                                var ol = $(this).find('.allcourses');
                                $(ol[0]).html("<li>暂无数据！</li>");
                            })
                        }
                        $('.employment_lists  ul li').find('.closeshow').click(function () {
                            var thisparent = $(this);
                            thisparent.next().stop().slideToggle().end().parent().siblings().find('.recommend_courses').slideUp().end().find(".closeshow").text("+");
                            var t = $(this).text();
                            $(this).text((t == "+" ? "-" : "+"));
                        })
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }


        function GetDateDiff(startDate) {
            var endDate = GetNowFormatDate();
            var startTime = new Date(Date.parse(startDate.replace(/-/g, "/"))).getTime();
            var endTime = new Date(Date.parse(endDate.replace(/-/g, "/"))).getTime();
            var dates = Math.abs((startTime - endTime)) / (1000 * 60 * 60 * 24);
            if (dates < 1) {
                var hour = GetDateTimeDiff(startDate, endTime, "hour");
                return hour + "小时";
            } else {
                return parseInt(dates) + "天";
            }


        }

        function GetDateTimeDiff(startTime, endTime, diffType) {
            //将xxxx-xx-xx的时间格式，转换为 xxxx/xx/xx的格式 
            startTime = startTime.replace(/\-/g, "/");
            endTime = endTime.replace(/\-/g, "/");
            //将计算间隔类性字符转换为小写
            diffType = diffType.toLowerCase();
            var sTime = new Date(startTime);      //开始时间
            var eTime = new Date(endTime);  //结束时间
            //作为除数的数字
            var divNum = 1;
            switch (diffType) {
                case "second":
                    divNum = 1000;
                    break;
                case "minute":
                    divNum = 1000 * 60;
                    break;
                case "hour":
                    divNum = 1000 * 3600;
                    break;
                case "day":
                    divNum = 1000 * 3600 * 24;
                    break;
                default:
                    break;
            }
            return parseInt((eTime.getTime() - sTime.getTime()) / parseInt(divNum));
        }

        function GetNowFormatDate() {
            var date = new Date();
            var seperator1 = "-";
            var seperator2 = ":";
            var year = date.getFullYear();
            var month = date.getMonth() + 1;
            var strDate = date.getDate();
            if (month >= 1 && month <= 9) {
                month = "0" + month;
            }
            if (strDate >= 0 && strDate <= 9) {
                strDate = "0" + strDate;
            }
            var currentdate = year + seperator1 + month + seperator1 + strDate
                    + " " + date.getHours() + seperator2 + date.getMinutes()
                    + seperator2 + date.getSeconds();
            return currentdate;
        }

        function splitTHtml(treatment) {
            var spans = "";
            if (treatment != "" && treatment != null) {
                var htmls = treatment.split("、");
                for (var i = 0; i < htmls.length; i++) {
                    spans += "<span>" + htmls[i] + "</span>"
                }
            }
            return spans;
        }

        function Query() {
            getData(1, 10);
        }
    </script>
</body>
</html>
