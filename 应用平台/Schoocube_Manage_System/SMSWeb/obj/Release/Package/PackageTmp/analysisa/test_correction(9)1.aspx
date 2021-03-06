﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_correction(9)1.aspx.cs" Inherits="SMSWeb.analysisa.test_correction_9_1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《python基础》作业批改情况</title>
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
                <img src="/images/huodongfenxi.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul >
                    <li currentclass="active" class="active">
                        <a href="work_correction(12).aspx">作业批改</a>
                    </li>
                    <li currentclass="active">
                        <a href="question_answer(3).aspx">答疑互动</a>
                    </li>
                    <li currentclass="active"><a href="test_correction(9).aspx" class="on">试卷批改</a></li>
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
                <a href="work_correction(12).aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div id="divPieChart" align="center" style="width:1000px;height:600px;margin:0 auto;"></div>
        <div class="wrap">
            <table>
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《python基础》作业批改情况</caption>
                <thead>
                    <th>作业总次数</th>
                    <th>及时批改次数</th>
                    <th>未及时批改次数</th>
                </thead>
                <tbody>
                    <tr>
                        <td>50</td>
                        <td>48</td>
                        <td>2</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="../js/common.js"></script>
<script>
    function initChart() {
        var xml = '<chart caption="《python基础》作业批改情况" numberPrefix=" 次"  ><set value="48" label="及时批改" color="AFD8F8" /><set value="2" label="未及时批改" color="F6BD0F" /></chart>';
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
                    text: '《python基础》作业批改情况',
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
			            name: '《python基础》作业批改次数',
			            type: 'pie',
			            radius: '80%',
			            center: ['50%', '50%'],
			            data: [
			                { value: 48, name: '及时批改' },
                            { value: 2, name: '未及时批改' },

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
