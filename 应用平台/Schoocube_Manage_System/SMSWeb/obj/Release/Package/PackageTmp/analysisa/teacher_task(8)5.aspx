<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="teacher_task(8)5.aspx.cs" Inherits="SMSWeb.analysisa.teacher_task_8_5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《 CG绘画培训》教师工作量</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="../css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="../css/common.css"/>
    <link rel="stylesheet" type="text/css" href="../css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css"/>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="../js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script type="text/javascript" src="../Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="../Scripts/echarts-all.js"></script>
    <link rel="stylesheet" href="../css/Css.css">
    <script src="../js/jquery.kkPages.js"></script>
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
            <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" />
            </a>
            <div class="wenzi_tips fl">
                <img src="/images/xuexixiaoguo.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active"><a href="test_mark(10).aspx">考试成绩</a></li>
                    <li currentclass="active"> <a href="study_process(4).aspx">学习进度</a></li>
                    <li currentclass="active"><a href="knowledgemastery(2).aspx">章节掌握程度</a></li>
                    <li currentclass="active" class="active"><a href="teacher_task(8).aspx">教师工作量</a></li>
                    <li currentclass="active"><a href="teached_quality(6).aspx">教学质量</a></li>
                    <li currentclass="active"><a href="student_feedback(14).aspx" class="on">学生反馈</a></li>
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
    <div  class="bordshadrad" style="background: #fff;padding:20px;">
        <div class="stytem_select clearfix">
            <div class="fl" style="margin-top:5px;">
                <label style="float:left;line-height:38px;display:block;">图表类型：</label>
                <select class="select" id="select_type">
                    <option value="1" selected>3D</option>
                    <option value="2">2D</option>
                </select>
            </div>
            <div class="stytem_select_right fr">
                <a href="teacher_task(8).aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div id="divPieChart" align="center" style="width:1000px;height:600px;margin:0 auto;"></div>
        <div class="wrap">
            <table>
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《 CG绘画培训》课程完成情况</caption>
                <thead>
                    <th>课时总数</th>
                    <th>已完成课时数</th>
                    <th>未完成课时数</th>
                </thead>
                <tbody>
                    <tr>
                        <td>50</td>
                        <td>40</td>
                        <td>10</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="../js/common.js"></script>
<script>
    function initChart() {
        var xml = '<chart caption="《CG绘画培训》课程完成情况" numberPrefix="%" ><set value="40" label="已完成" color="AFD8F8" /><set value="10" label="未完成" color="F6BD0F" /></chart>';
        var myChart = new FusionCharts("../FusionCharts/Swf/Pie3D.swf", "myChartId_02", '1000', "600");
        myChart.setDataXML(xml);
        myChart.render("divPieChart");
    }
    initChart();
    $('#select_type').change(function () {
        var val = $(this).val();
        if (val == 1) {
            initChart();
        } else if (val == 2) {
            var myChart = echarts.init(document.getElementById('divPieChart'));
            option = {
                title: {
                    text: '《CG绘画培训》课程完成情况',
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
                        name: '《CG绘画培训》课程完成情况',
                        type: 'pie',
                        radius: '80%',
                        center: ['50%', '50%'],
                        data: [
                            { value: 40, name: '已完成' },
                            { value: 10, name: '未完成' },
                        ]
                    }
                ]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    })
</script>
    </div>
    </form>
</body>
</html>
