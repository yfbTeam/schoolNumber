﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Knowledge_track4.aspx.cs" Inherits="SMSWeb.analysisa.Knowledge_track4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《 初一英语上册（人教版）》知识点跟踪</title>
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
                    <a href="/HZ_Index.aspx" class="logo fl">
                        <img src="/images/logo.png" /></a>
                    <nav class="navbar menu_mid fl">
                        <ul>
                            <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                            <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                            <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                            <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                            <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                            <li currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                            <li currentclass="active" class="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
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
                        <div class="settings fl pr">
                            <a href="javascript:;">
                                <i class="icon icon-cog"></i>
                            </a>
                            <div class="setting_none">
                                <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                                <a href="/PersonalSpace/PersonalSpace_Student.aspx"><span>个人中心</span></a>
                                <span onclick="logOut()">退出</span>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <div class="onlinetest_item width pt90 pr ">
                <div class="bordshadrad" style="background: #fff; padding: 20px;">
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="student_studyprocess(4).aspx">课时跟踪</a>
                            <a href="student_knowledgemastery(2).aspx">掌握程度</a>
                            <a href="Knowledge_track.aspx" class="on">知识点跟踪</a>
                            <a href="Online_Answer.aspx">在线答疑</a>

                        </div>
                        <div class="stytem_select_right fr">
                            <a href="Knowledge_track.aspx">
                                <i class="icon icon-reply"></i>
                                <span>返回上级</span>
                            </a>
                        </div>
                    </div>
                    <div style="margin-top: 5px;" class="clearfix">
                        <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                        <select class="select" id="select_type">
                            <option value="1" selected>3D</option>
                            <option value="2">2D</option>
                        </select>
                    </div>
                    <div id="divPieChart" align="center" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                    <div class="wrap">
                        <table>
                            <caption style="line-height: 40px; text-align: center; font-weight: bold;">《初一英语上册（人教版）》知识点跟踪</caption>
                            <thead>
                                <tr>
                                    <th>知识点名称</th>
                                    <th>习题个数</th>
                                    <th>回答习题正确个数</th>
                                    <th>知识点掌握程度</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>字符串格式化
                                    </td>
                                    <td>20</td>
                                    <td>20</td>
                                    <td>100%</td>
                                </tr>
                                <tr>
                                    <td>字典基本操作
                                    </td>
                                    <td>15</td>
                                    <td>15</td>
                                    <td>100%</td>
                                </tr>
                                <tr>
                                    <td>模块导入
                                    </td>
                                    <td>30</td>
                                    <td>25</td>
                                    <td>95%</td>
                                </tr>
                                <tr>
                                    <td>字典的格式化字符串.
                                    </td>
                                    <td>24</td>
                                    <td>18</td>
                                    <td>93%</td>
                                </tr>
                                <tr>
                                    <td>条件语句
                                    </td>
                                    <td>10</td>
                                    <td>7</td>
                                    <td>91%</td>
                                </tr>
                                <tr>
                                    <td>赋值
                                    </td>
                                    <td>15</td>
                                    <td>10</td>
                                    <td>88%</td>
                                </tr>
                                <tr>
                                    <td>循环
                                    </td>
                                    <td>20</td>
                                    <td>15</td>
                                    <td>88%</td>
                                </tr>
                                <tr>
                                    <td>列表推导式
                                    </td>
                                    <td>27</td>
                                    <td>19</td>
                                    <td>85%</td>
                                </tr>
                                <tr>
                                    <td>字符串的方法
                                    </td>
                                    <td>26</td>
                                    <td>16</td>
                                    <td>79%</td>
                                </tr>
                                <tr>
                                    <td>字典的方法
                                    </td>
                                    <td>15</td>
                                    <td>6</td>
                                    <td>76%</td>
                                </tr>
                                <tr>
                                    <td>dict()函数
                                    </td>
                                    <td>9</td>
                                    <td>5</td>
                                    <td>75%</td>
                                    <tr>
                                        <td>语句块
                                        </td>
                                        <td>18</td>
                                        <td>11</td>
                                        <td>70%</td>
                                    </tr>
                                    <tr>
                                        <td>创建函数
                                        </td>
                                        <td>20</td>
                                        <td>13</td>
                                        <td>70%</td>
                                    </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <script src="/js/common.js"></script>
            <script>
                $('.wrap').kkPages({
                    PagesClass: 'tbody tr', //需要分页的元素
                    PagesMth: 10, //每页显示个数
                    PagesNavMth: 4 //显示导航个数
                });
                function initChart() {
                    var xml = '<chart caption="《初一英语上册（人教版）》知识点跟踪" numberSuffix=" 个"  ><set value="2" label="100%" color="AFD8F8" /><set value="3" label="90%-99%" color="F6BD0F" /><set value="3" label="80%-89%" color="8BBA00" /><set value="5" label="70%-79%" color="AFD8F8" /></chart>';
                    var myChart = new FusionCharts("/FusionCharts/Swf/Line.swf", "myChartId_02", '1000', "600");
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
                                text: '《初一英语上册（人教版）》知识点跟踪',
                                x: 'center'
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    boundaryGap: false,
                                    data: ['100%', '90%-99%', '80%-89%', '70%-79%']
                                }
                            ],
                            yAxis: [
                               {
                                   type: 'value',
                                   axisLabel: {
                                       formatter: '{value} 个'
                                   }
                               }
                            ],
                            series: [
                                {
                                    name: '《初一英语上册（人教版）》知识点掌握个数',
                                    type: 'line',
                                    data: [2, 3, 3, 5],

                                },

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
