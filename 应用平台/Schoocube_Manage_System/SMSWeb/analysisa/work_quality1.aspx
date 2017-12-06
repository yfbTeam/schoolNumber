<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="work_quality1.aspx.cs" Inherits="SMSWeb.analysisa.work_quality1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《python基础》作业整体质量</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css"/>
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/Scripts/echarts-all.js"></script>
    <link rel="stylesheet" href="/css/Css.css">
    <script src="/js/jquery.kkPages.js"></script>
    <script src="/Scripts/tableExport/tableExport.js"></script>
    <script src="/Scripts/tableExport/jquery.base64.js"></script>
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
                <img src="/images/zuoyepigai.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active" class="active"> <a href="work_quality.aspx">作业整体质量</a></li>
                    <li currentclass="active"><a href="knowledge_line.aspx">知识点掌握程度</a></li>
                     <li currentclass="active"><a href="common_question.aspx">常见问题</a></li>
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
            <div class="stytem_select_left fl">
                <a href="javascript:;" onclick="initChart(this,'Column3D','1')" class="on">柱状图</a>
                <a href="javascript:;" onclick="initChart(this,'Pie3D','2')">饼状图</a>
            </div>
            <div class="stytem_select_right fr">
                <a href="work_quality.aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div class="fl" style="margin-top:5px;">
            <label style="float:left;line-height:38px;display:block;">图表类型：</label>
            <select class="select" id="select_type">
                <option value="1" selected>3D</option>
                <option value="2">2D</option>
            </select>
        </div>
        <div id="divPieChart" align="center" style="width:1000px;height:600px;margin:0 auto;"></div>
        <div class="wrap">
            <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="$('#table').tableExport({ type: 'excel', escape: 'true'});">备份数据</a>
                </div>
            <table id="table">
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《python基础》作业整体质量</caption>
                <thead>
                <th>优</th>
                <th>良</th>
                <th>中</th>
                <th>差</th>
                </thead>
                <tbody>
                <tr>
                    <td>4</td>
                    <td>7</td>
                    <td>4</td>
                    <td>1</td>
                </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="/js/common.js"></script>
<script>
    function initChart(obj,chartType,number) {
        $(obj).addClass('on').siblings().removeClass('on');
        var xml = '<chart caption="《python基础》作业整体质量" numberSuffix=" 个"  ><set value="4" label="优" color="AFD8F8" /><set value="7" label="良" color="F6BD0F" /><set value="4" label="中" color="AFD8F8" /><set value="1" label="差" color="F6BD0F" /></chart>';
        var myChart = new FusionCharts("/FusionCharts/Swf/" + chartType + ".swf", "my_chart"+number+"", '1000', "600");
        myChart.setDataXML(xml);
        myChart.render("divPieChart");
        $('#select_type').val('3D')
    }
    initChart('', 'Column3D','1')
    $('#select_type').change(function () {
        var val = $(this).val();
        if (val == 1) {
            var test = $('.stytem_select_left a');
            if (test.eq(0).hasClass('on')) {
                initChart('','Column3D','1')
            } else if (test.eq(1).hasClass('on')) {
                initChart('', 'Pie3D','2')
            }
        } else if (val == 2) {
           
            chartType();
        }
    })
    function chartType() {
        var myChart = echarts.init(document.getElementById('divPieChart'));
        var test = $('.stytem_select_left a');
        if(test.eq(0).hasClass('on')){
            option = {
                title: {
                    text: '《python基础》作业整体质量',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: ['优', '良', '中', '差']
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
                        name: '《python基础》作业整体质量',
                        type: 'bar',
                        data: [4, 7, 4, 1],

                    },

                ]
            };
        } else if (test.eq(1).hasClass('on')) {
            option = {
                title: {
                    text: '《python基础》作业整体质量',
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
                        name: '《python基础》作业整体质量',
                        type: 'pie',
                        radius: '80%',
                        center: ['50%', '50%'],
                        data: [
                            { value: 4, name: '优' },
                            { value: 7, name: '良' },
                            { value: 4, name: '中' },
                            { value: 1, name: '差' }
                        ]
                    }
                ]
            };
        }
        // 使用刚指定的配置项和数据显示图表。
        myChart.setOption(option);
    }
</script>
    </div>
    </form>
</body>
</html>
