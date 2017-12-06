<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="student_feedbackDetail.aspx.cs" Inherits="SMSWeb.analysisa.student_feedback_14_1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学生反馈情况</title>
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
    <script src="/Scripts/echarts-all.js"></script>
    <link rel="stylesheet" href="/css/Css.css">
    <script src="/js/jquery.kkPages.js"></script>
    <script src="/Scripts/Common.js"></script>
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
                            <li currentclass="active"><a href="ExamResultAnalyse.aspx">考试成绩</a></li>
                            <li currentclass="active"><a href="study_process(4).aspx">学习进度</a></li>
                            <li currentclass="active"><a href="knowledgemastery(2).aspx">章节掌握程度</a></li>
                            <li currentclass="active"><a href="teacher_task(8).aspx">教师工作量</a></li>
                            <li currentclass="active"><a href="teached_quality(6).aspx">教学质量</a></li>
                            <li currentclass="active" class="active"><a href="student_feedback.aspx" class="on">学生反馈</a></li>
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
                    <div class="stytem_select clearfix">
                        <div class="fl" style="margin-top: 5px;">
                            <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                            <select class="select" id="select_type">
                                <option value="1" selected>3D</option>
                                <option value="2">2D</option>
                            </select>
                        </div>
                        <div class="stytem_select_right fr">
                            <a href="student_feedback.aspx">
                                <i class="icon icon-reply"></i>
                                <span>返回上级</span>
                            </a>
                        </div>
                    </div>
                    <div id="divPieChart" align="center" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                    <%--<div class="wrap">
                        <table>
                            <caption style="line-height: 40px; text-align: center; font-weight: bold;" id="CourseName">《python基础》学生评价情况</caption>
                            <thead>
                                <th>姓名</th>
                                <th>对老师评价</th>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>罗秋香</td>
                                    <td>非常棒</td>
                                </tr>
                                <tr>
                                    <td>赵灵可</td>
                                    <td>非常棒</td>
                                </tr>
                                <tr>
                                    <td>谢章峰</td>
                                    <td>非常棒</td>
                                </tr>
                                <tr>
                                    <td>张红</td>
                                    <td>非常棒</td>
                                </tr>
                                <tr>
                                    <td>胡歌</td>
                                    <td>非常棒</td>
                                </tr>
                                <tr>
                                    <td>张琳</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>石琳</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>韩寒</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>王丽</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>左义</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>袁熙</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>唐叶</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>郝旭</td>
                                    <td>很好</td>
                                </tr>
                                <tr>
                                    <td>林彤</td>
                                    <td>一般</td>
                                </tr>
                                <tr>
                                    <td>方晓</td>
                                    <td>一般</td>
                                </tr>
                                <tr>
                                    <td>王小明</td>
                                    <td>差</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>--%>
                </div>
            </div>
            <script src="/js/common.js"></script>
            <script>
                $(function () {

                    getChart2D();
                    initChart();

                })
                var UrlDate = new GetUrlDate();
                var xmlHtml = '<chart caption="' + decodeURI(UrlDate.CourseName) + '" numberSuffix=" 分"  >';//<set value="5" label="非常棒" color="AFD8F8" /><set value="8" label="很好" color="F6BD0F" /><set value="2" label="一般" color="8BBA00" /><set value="1" label="差" color="AFD858"/></chart>';

                function initChart() {
                    var xml = xmlHtml;// '<chart caption="《python基础》学生反馈情况" numberSuffix=" 人"  ><set value="5" label="非常棒" color="AFD8F8" /><set value="8" label="很好" color="F6BD0F" /><set value="2" label="一般" color="8BBA00" /><set value="1" label="差" color="AFD858"/></chart>';
                    //var xml = '<chart caption="摄影初级班" numberSuffix=" 人"  > <set value="王丽" label="3" color="AFD8F8"/> <set value="罗秋香" label="4" color="AFD8F8"/> <set value="韩寒" label="3" color="AFD8F8"/> <set value="张琳" label="5" color="AFD8F8"/> <set value="胡歌" label="2" color="AFD8F8"/></chart>';
                    var myChart = new FusionCharts("/FusionCharts/Swf/Pie3D.swf", "chartobject-1", '1000', "600");
                    myChart.setDataXML(xml);
                    myChart.render("divPieChart");
                }
                $('#select_type').change(function () {
                    var val = $(this).val();
                    if (val == 1) {
                        initChart()
                    } else if (val == 2) {
                        var myChart = echarts.init(document.getElementById('divPieChart'));
                        /*option = {
                            title: {
                                text: '课程评价详情',
                                // subtext: '纯属虚构',
                                x: 'center'
                            },
                            tooltip: {
                                trigger: 'item',
                                formatter: "{a} <br/>{b} : {c} ({d}%)"
                            },
                            calculable: true,
                            series: [
                                {
                                    name: '《python基础》学生反馈情况',
                                    type: 'pie',
                                    radius: '80%',
                                    center: ['50%', '50%'],
                                    data: [
                                        { value: 5, name: '非常棒' },
                                        { value: 8, name: '很好' },
                                        { value: 2, name: '一般' },
                                        { value: 1, name: '差' }
                                    ]
                                }
                            ]
                        };*/
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option);
                    }
                })
                var option = {
                    title: {
                        text: '课程评价详情',
                        subtext: '评价分数',
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
                function getChart2D() {
                    $.ajax({
                        url: "/analysisa/Analisy.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            Func: "CouseEvalue",
                            CourseID: UrlDate.CourseID,
                            IsPage: "false"
                        },
                        success: function (json) {
                            if (json.result.errNum == "0") {
                                var items = json.result.retData;
                                if (items != null && items.length > 0) {

                                    var legends = [];
                                    var series = [];
                                    for (var i = 0; i < items.length; i++) {
                                        var tname = items[i].CreateName;
                                        if (tname != undefined) {
                                            legends.push(tname);
                                            var obj = new Object();
                                            obj.name = tname;
                                            obj.value = items[i].Evalue;
                                            var color = "AFD8F8";
                                            if (i % 2 == 0) {
                                                color = "8BBA00";
                                            }
                                            series.push(obj);
                                            xmlHtml += " <set value=\"" + items[i].Evalue + "\" label=\"" + tname + "\" color=\"" + color + "\"/>";
                                        }


                                    }
                                    option.legend.data = legends;
                                    option.series[0].data = series;
                                    //if (isLoad) {
                                    //    refresh(true);
                                    //}
                                    //isLoad = true;
                                } else {
                                    option.legend.data = [];
                                    option.series[0].data = [];
                                    //if (isLoad) {
                                    //    refresh(true);
                                    //}
                                }
                            }
                            else {
                                option.legend.data = [];
                                option.series[0].data = [];
                                //if (isLoad) {
                                //    refresh(true);
                                //}
                            }
                            xmlHtml += "</chart>";
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {

                        }
                    });
                }
            </script>
        </div>
    </form>
</body>
</html>
