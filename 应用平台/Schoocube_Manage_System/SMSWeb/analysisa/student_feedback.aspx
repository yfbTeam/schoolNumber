<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student_feedback.aspx.cs" Inherits="SMSWeb.analysisa.student_feedback_14_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>教学质量评价</title>
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
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/layer/layer.js"></script>

    <link rel="stylesheet" href="/css/Css.css">
    <script src="/js/jquery.kkPages.js"></script>
    <style>
        .wrap table tbody tr td a {
            display: inline-block;
            background: none;
            color: #5493d7;
        }

        .wrap table tbody tr td .icon {
            width: 16px;
            height: 16px;
            display: inline-block;
            font-size: 16px;
            line-height: 16px;
            cursor: pointer;
            margin: 0px 2px;
            vertical-align: middle;
            color: #5493d7;
        }
    </style>

    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td>${CourseEvalue}</td>
            <td>${EvalueTimes}</td>
            <td>${Math.round(CourseEvalue/EvalueTimes) / 1.00} </td>
            <td><a style="cursor: pointer;" onclick="EvalueDetail(${CouseID},'${Name}')">评价详情</a></td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <!--header-->
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                        <img src="/images/logo.png" />
                    </a>
                    <div class="wenzi_tips fl">
                        <img src="/images/xuexixiaoguo.png" />
                    </div>
                    <nav id="teacher" class="navbar menu_mid fl">
                        <ul id="CourceMenu">
                            <li currentclass="active"><a href="/analysisa/ExamResultAnalyse.aspx">考试成绩</a></li>
                            <li currentclass="active"><a href="/analysisa/study_process(4).aspx">学习进度</a></li>
                            <li currentclass="active"><a href="/analysisa/knowledgemastery(2).aspx">章节掌握程度</a></li>
                            <li currentclass="active"><a href="/analysisa/teacher_task(8).aspx">教师工作量</a></li>
                            <li currentclass="active"><a href="/analysisa/teached_quality(6).aspx">教学质量</a></li>
                            <li currentclass="active"><a href="/analysisa/student_feedback.aspx">学生反馈</a></li>
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
            <div class="onlinetest_item width pt90 pr ">
                <div class="bordshadrad" style="background: #fff; padding: 20px;">
                    <div class="newcourse_select clearfix">
                        <div class="clearfix course_form_div fl">
                            <label for="">课程名称：</label>
                            <input type="text" id="CourseName" class="text" />
                        </div>

                        <div class="distributed fr">
                            <a href="javascript:void(0);" onclick="query()">查询</a>
                            <%--<a href="javascript:void(0);" id="export"><i class="icon icon-plus"></i>导出</a>--%>
                        </div>
                    </div>
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>序号</th>
                                    <th>课程名称</th>
                                    <th>总评价数</th>
                                    <th>评价次数</th>
                                    <th>综合评分</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_record">
                            </tbody>
                        </table>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
            <script src="/js/common.js"></script>
            <%--<script>
                $('.wrap').kkPages({
                    PagesClass: 'tbody tr', //需要分页的元素
                    PagesMth: 10, //每页显示个数
                    PagesNavMth: 4 //显示导航个数
                });

            </script>--%>
        </div>
    </form>
    <script type="text/javascript">
        $(function () {
            getData(1, 10);
        })
        function query() {
            getData(1, 10);
        }
        function EvalueDetail(CourseID, Name) {
            window.location.href = "/analysisa/student_feedbackDetail.aspx?CourseID=" + CourseID + "&CourseName=" + encodeURI(Name);
            //OpenIFrameWindow("/analysisa/student_feedbackDetail.aspx?CourseID=" + CourseID + "&CourseName=" + Name);
        }
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/analysisa/Analisy.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: "CouseEvalue",
                    CourseName: $("#CourseName").val(),
                    PageIndex: startIndex,
                    PageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_record").html('');
                        $("#tr_record").tmpl(json.result.retData.PagedData).appendTo("#tb_record");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_record").html("<tr><td colspan='8'>暂无系统记录！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
