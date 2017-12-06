<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="study_process(4).aspx.cs" Inherits="SMSWeb.analysisa.study_process_4_" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学习进度</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/PortalJs/echarts/asset/css/codemirror.css" rel="stylesheet">
    <link href="/PortalJs/echarts/asset/css/monokai.css" rel="stylesheet">

    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <link rel="stylesheet" href="/css/Css.css">
    <script src="/js/jquery.kkPages.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}</td>
            <%--<td>${TaskName}</td>--%>
            <td>${CreateName}</td>
            <td>${CompleteWeight}</td>
            <td>${AllWeigth}
            </td>
            <td>
                <a onclick="Detail('${CreateUID}','${Name}')"><i class="icon icon-eye-open" title="某学生任务完成详情"></i></a>
            </td>
        </tr>
    </script>
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
    <script type="text/javascript">
        var FirstLoad = null;
        var chart_VisitCourse;
        $(function () {
            getData(1, 10);
            getChart(1, 10);
        })
        function Detail(CreateUID, StuName) {
            window.location.href = "/analysisa/study_process(4)1.aspx?CreateUID=" + CreateUID;
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
                    Func: "CouseCompleteAnalis",
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
                        $("#tb_record").html("<tr><td colspan='8'>暂无数据！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
        function getChart(startIndex, pageSize) {
            $.ajax({
                url: "/analysisa/Analisy.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: "CouseCompleteChart",
                    FirstLoad: FirstLoad,
                    PageIndex: startIndex,
                    PageSize: pageSize

                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        if (FirstLoad == "success") {
                            chart_VisitRate.setDataXML(json.result.retData);
                            chart_VisitRate.render("VisitRateDiv")
                        } else {
                            $("#chartDiv").html(json.result.retData);
                        }

                        FirstLoad = "success";
                    }
                    else {
                        //$("#chartDiv").html("生成饼图失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        var option = {
            title: {
                text: '考试成绩分析',
                subtext: '考试成绩',
                x: 'center'
            },
            tooltip: {
                trigger: 'item',
                formatter: "{a} <br/>{b} : {c} ({d}%)"
            },
            legend: {
                orient: 'vertical',
                x: 'left',
                data: []
            },
            toolbox: {
                show: true,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: {
                        show: true,
                        type: ['pie', 'funnel'],
                        option: {
                            funnel: {
                                x: '25%',
                                width: '50%',
                                funnelAlign: 'left',
                                max: 1548
                            }
                        }
                    },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            series: [
                {
                    name: '数据来源',
                    type: 'pie',
                    radius: '55%',
                    center: ['50%', '60%'],
                    data: []
                }
            ]
        };
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
                    <div class="wrap">
                        <table>
                            <thead>
                                <tr>
                                    <th>课程名称</th>
                                    <%--<th>任务名称</th>--%>
                                    <th>学生名称</th>
                                    <th>完成比重</th>
                                    <th>任务总比重</th>
                                    <th>操作</th>
                                </tr>
                            </thead>
                            <tbody id="tb_record">
                                <%-- <tr>
                        <td>
                            python基础
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            大教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="study_process(4)1.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            MySQL入门
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            四号会议室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="study_process(4)2.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            文学修养（人教版）
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            三号教师
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="study_process(4)3.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>

                    <tr>
                        <td>
                            初一英语上册（人教版）
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            小教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="study_process(4)4.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            CG绘画培训
                        </td>
                        <td>
                            选修课
                        </td>
                        <td>
                            小教室
                        </td>
                        <td>
                            16
                        </td>
                        <td>
                            <a href="study_process(4)5.aspx"><i class="icon icon-eye-open"></i></a>
                        </td>
                    </tr>--%>
                            </tbody>
                        </table>
                    </div>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                    <div id="chartDiv"></div>
                </div>
            </div>
            <script src="/js/common.js"></script>
            <script>
                $('.wrap').kkPages({
                    PagesClass: 'tbody tr', //需要分页的元素
                    PagesMth: 10, //每页显示个数
                    PagesNavMth: 4 //显示导航个数
                });
            </script>
        </div>
    </form>
</body>
</html>
