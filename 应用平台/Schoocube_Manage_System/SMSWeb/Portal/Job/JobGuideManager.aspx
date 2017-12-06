<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="JobGuideManager.aspx.cs" Inherits="SMSWeb.Portal.Job.JobGuideManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="//PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
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
            position:relative;
        }
        .employment_lists ul li .distributed{position:absolute;right:50px;top:50%;margin-top:-14px;}
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
                padding: 5px 135px 5px 0px;
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
    <script src="/PortalJs/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>

    <script type="text/x-jquery-tmpl" id="tr_Job">
        <li class="clearfix">

            <div class="employment_list_left">
                <div class="job">
                    ${Name}
                </div>
                <h2 class="job_description">职位描述：${Introduction}
                </h2>
            </div>
            <div class="distributed">
                <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('添加课程', 'JobManager.aspx?id=${ID}', '880px', '560px');">添加课程</a>
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
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>

                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">关键词：</label>
                        <input type="text" placeholder="不限" id="JobName" />
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />
                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="query()">查询</a>
                    </div>
                </div>
                <div class="employment_wrap">
                    <div class="employment_lists">

                        <ul id="job_items">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            getData(1, 10);
        })

        function getData(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/JobHandler.ashx",
                    Func: "GetPageJobGuide",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    keyWord: $("#JobName").val()
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
                                if (courses != [] && courses.length > 0) $("#tr_Course").tmpl(courses).appendTo("#" + ol[0].id);
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
                        $('.employment_lists  ul li:eq(0)').find('.closeshow').text('-');
                        $('.employment_lists  ul li:eq(0)').find('.recommend_courses').show();
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        //function getData(startIndex, pageSize) {
        //    pageNum = (startIndex - 1) * pageSize + 1;
        //    $.ajax({
        //        url: "/Common.ashx",
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: {
        //            PageName: "PortalManage/JobHandler.ashx",
        //            Func: "GetPageJobGuide",
        //            PageIndex: startIndex,
        //            pageSize: pageSize,
        //            StarDate: $("#StarDate").val(),
        //            EndDate: $("#EndDate").val(),
        //            keyWord: $("#JobName").val()
        //        },
        //        success: function (json) {
        //            if (json.result.errMsg == "success") {
        //                $("#job_items").html('');
        //                var items = json.result.retData.PagedData;
        //                $("#tr_Job").tmpl(items).appendTo("#job_items");
        //                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
        //                if (items != null && items.length > 0) {
        //                    var jobIdList = [];
        //                    $.each(items, (function (i, item) {
        //                        jobIdList.push(item.ID);
        //                    }));
        //                    if (jobIdList.length > 0) getCourseItems(jobIdList.toString());
        //                }
        //            }
        //            else {
        //                $("#job_items").html("<li>暂无数据！<li>");
        //            }
        //        },
        //        error: function (XMLHttpRequest, textStatus, errorThrown) {

        //        }
        //    });
        //}

        function query()
        {
            getData(1, 10);
        }
    </script>
</body>
</html>
