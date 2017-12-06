<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="knowledge_line4.aspx.cs" Inherits="SMSWeb.analysisa.knowledge_line4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《初一英语上册（人教版）》掌握程度</title>
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
                <img src="/images/zuoyepigai.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul>
                    <li currentclass="active"> <a href="work_quality.aspx">作业整体质量</a></li>
                    <li currentclass="active" class="active"><a href="knowledge_line.aspx">知识点掌握程度</a></li>
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
            <div class="stytem_select_right fr">
                <a href="knowledge_line.aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div id="divPieChart" align="center"></div>
        <div class="wrap">
            <div class="distributed fr">
                <a href="javascript:void(0);">导出数据</a>
            </div>
            <table>
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《初一英语上册（人教版）》掌握程度</caption>
                <thead>
                <th>姓名</th>
                <th>已掌握程度</th>
                </thead>
                <tbody>
                   <tr>
                       <td>罗秋香</td>
                       <td>90%</td>
                   </tr>
                    <tr>
                        <td>赵灵可</td>
                        <td>90%</td>
                    </tr>
                    <tr>
                        <td>谢章峰</td>
                        <td>90%</td>
                    </tr>
                    <tr>
                        <td>张红</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>胡歌</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>张琳</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>石琳</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>韩寒</td>
                        <td>80%</td>
                    </tr>
                    <tr>
                        <td>王丽</td>
                        <td>70%</td>
                    </tr>
                    <tr>
                        <td>左义</td>
                        <td>70%</td>
                    </tr>
                    <tr>
                        <td>袁熙</td>
                        <td>70%</td>
                    </tr>
                    <tr>
                        <td>唐叶</td>
                        <td>60%</td>
                    </tr>
                    <tr>
                        <td>郝旭</td>
                        <td>60%</td>
                    </tr>
                    <tr>
                        <td>林彤</td>
                        <td>50%</td>
                    </tr>
                    <tr>
                        <td>方晓</td>
                        <td>50%</td>
                    </tr>
                    <tr>
                        <td>王小明</td>
                        <td>40%</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="../js/common.js"></script>
<script>
    $('.wrap').kkPages({
        PagesClass:'tbody tr', //需要分页的元素
        PagesMth:10, //每页显示个数
        PagesNavMth:4 //显示导航个数
    });
    function initChart() {
        var xml = '<chart caption="《初一英语上册（人教版）》掌握程度" numberPrefix=" 个"  ><set value="3" label="90%" color="AFD8F8" /><set value="5" label="80%" color="F6BD0F" /><set value="3" label="70%" color="8BBA00" /><set value="2" label="60%" color="AFD8F8" /><set value="2" label="50%" color="F6BD0F" /><set value="1" label="40%" color="8BBA00" /></chart>';
        var myChart = new FusionCharts("../FusionCharts/Swf/Column3D.swf", "myChartId_02", '1000', "600");
        myChart.setDataXML(xml);
        myChart.render("divPieChart")
    }
    initChart();
    $('#select_type').change(function () {
        var val = $(this).val();
        if(val == 1){
            initChart();
        }else if(val==2){
            var myChart = echarts.init(document.getElementById('divPieChart'));
            option = {
                title: {
                    text: '《初一英语上册（人教版）》掌握程度',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['90%', '80%', '70%', '60%', '50%', '40%']
                    }
                ],
                yAxis: [
                    {
                        type: 'value'
                    }
                ],
                series: [
                    {
                        name: '《初一英语上册（人教版）》掌握程度',
                        type: 'bar',
                        data: [3, 5, 3, 2, 2, 1],

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
