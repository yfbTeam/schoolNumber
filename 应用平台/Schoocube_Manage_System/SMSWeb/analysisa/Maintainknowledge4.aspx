<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Maintainknowledge4.aspx.cs" Inherits="SMSWeb.analysisa.Maintainknowledge4" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《初一英语上册（人教版）》知识点统计</title>
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
                <img src="/images/zhishidiantongji.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul id="CourceMenu"></ul>
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
        <div class="bordshadrad" style="background: #fff;padding:20px;">
            <div class="stytem_select clearfix">
                <div class="stytem_select_right fr">
                    <a href="Maintainknowledge.aspx">
                        <i class="icon icon-reply"></i>
                        <span>返回上级</span>
                    </a>
                </div>
            </div>
            <div id="divPieChart" align="center"></div>
            <div class="wrap">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="$('#table').tableExport({ type: 'excel', escape: 'true'});">导出数据</a>
                </div>
                <table id="table">
                    <thead>
                        <tr>
                            <th>易掌握知识点</th>
                            <th>不易掌握的知识点</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>
                                字符串格式化
                            </td>
                            <td>
                                字符串的方法
                            </td>
                        </tr>
                        <tr>
                            <td>
                                字典基本操作
                            </td>
                            <td>
                                字典的方法
                            </td>
                        </tr>
                        <tr>
                            <td>
                                字典的格式化字符串.
                            </td>
                            <td>
                                dict()函数
                            </td>
                        </tr>
                        <tr>
                            <td>
                                字典的格式化字符串.
                            </td>
                            <td>
                                dict()函数
                            </td>
                        </tr>
                        <tr>
                            <td>
                                条件语句
                            </td>
                            <td>
                                语句块
                            </td>
                        </tr>
                        <tr>
                            <td>
                                模块导入
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                赋值
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                循环
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>
                                列表推导式
                            </td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>创建函数 </td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>文档字符串</td>
                        </tr>
                        <tr>
                            <td>参数</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>递归</td>
                            <td></td>
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
            var xml = '<chart caption="《初一英语上册（人教版）》知识点统计" numberSuffix=" 个"  ><set value="9" label="易掌握" color="AFD8F8" /><set value="4" label="不易掌握" color="F6BD0F" /></chart>';
            var myChart = new FusionCharts("/FusionCharts/Swf/Pie3D.swf", "myChartId_02", '1000', "600");
            myChart.setDataXML(xml);
            myChart.render("divPieChart")
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
                        text: '《初一英语上册（人教版）》知识点统计',
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
                            name: '《初一英语上册（人教版）》知识点统计',
                            type: 'pie',
                            radius: '80%',
                            center: ['50%', '50%'],
                            data: [
                                { value: 9, name: '易掌握' },
                                { value: 4, name: '不易掌握' },
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
