<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Course_Analysis.aspx.cs" Inherits="SMSWeb.CourseManage.Course_Analysis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>授课统计</title>
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
    <link rel="stylesheet" href="/css/Css.css" />
    <script src="/js/jquery.kkPages.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/CourseMenu.js"></script>
    <script src="/Scripts/Power.js"></script>
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
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <div>
            <!--header-->
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                        <img src="/images/logo.png" />
                    </a>
                    <div class="wenzi_tips fl">
                        <img src="/images/kechengguanli.png" />
                    </div>
                    <nav id="teacher" class="navbar menu_mid fl">
                        <ul id="CourceMenu">
                            <%--<li currentclass="active"><a href="Course_Analysis.aspx">授课统计</a></li>--%>
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
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" class="on">当前课程统计</a>
                            <a href="javascript:;">历史课程统计</a>
                        </div>
                    </div>
                    <div class="charts_wrap">
                        <div class="chartsa">
                            <div style="margin-top: 5px;" class="clearfix">
                                <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                                <select class="select" id="select_type1">
                                    <option value="1" selected="selected">3D</option>
                                    <option value="2">2D</option>
                                </select>
                            </div>
                            <div id="divPieChart1" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                        </div>
                        <div class="chartsa none">
                            <div style="margin-top: 5px;" class="clearfix">
                                <label style="float: left; line-height: 38px; display: block;">图表类型：</label>
                                <select class="select" id="select_type2">
                                    <option value="1" selected="selected">3D</option>
                                    <option value="2">2D</option>
                                </select>
                            </div>
                            <div id="divPieChart2" style="width: 1000px; height: 600px; margin: 0 auto;"></div>
                        </div>
                    </div>

                </div>
            </div>
            <script src="/js/common.js"></script>
            <script>
                $(function () {
                    initChart1();
                    CourceMenu();
                })

                //绑定数据

                $('.stytem_select_left a').on('click', function () {
                    $(this).addClass('on').siblings().removeClass();
                    var n = $(this).index();
                    $('.charts_wrap .chartsa').eq(n).show().siblings().hide();
                })
                function initChart1() {
                    var xml1 = '<chart caption="当前课程统计" numberSuffix="门" ><set value="7" label="线上课程" color="AFD8F8" /><set value="1" label="线下课程" color="F6BD0F" /></chart>';
                    var myChart = new FusionCharts("/FusionCharts/Swf/Column3D.swf", "myChartId_02", '1000', "600");
                    myChart.setDataXML(xml1);
                    myChart.render("divPieChart1");
                }

                $('#select_type1').change(function () {
                    var val = $(this).val();
                    if (val == 1) {
                        initChart1();
                    } else if (val == 2) {
                        var myChart = echarts.init(document.getElementById('divPieChart1'));
                        /*$.ajax({
                            url: "/Common.ashx",
                            type: "post",
                            async: false,
                            dataType: "json",
                            data: {
                                PageName: "/CourseManage/CourceManage.ashx",
                                Func: "CouseTypeAnalis",
                                Type: ">"
                            },
                            success: function (json) {
                                if (json.result.errNum.toString() == "0") {
                                    alert(json.result.retData);
                                    myChart.setOption({ //加载数据图表
                                        title: {
                                            text: '当前课程统计',
                                            x: 'center'
                                        },
                                        tooltip: {
                                            trigger: 'axis'
                                        },
                                        calculable: true,
                                        xAxis: [
                                            {
                                                type: 'category',
                                                data: ['线上课程', '线下课程']
                                            }
                                        ],
                                        yAxis: [
                                           {
                                               type: 'value',
                                               axisLabel: {
                                                   formatter: '{value} 门'
                                               }
                                           }
                                        ],
                                        series: [
                                            {
                                                name: '当前课程统计',
                                                type: 'bar',
                                                data: json.result.retData

                                            },

                                        ]

                                    });
                                }
                                else {
                                    alert(json.result.errMsg);
                                }
                            },
                            error: function (errMsg) {
                                alert(errMsg);
                            }
                        });
                    }*/
                        option1 = {
                            title: {
                                text: '当前课程统计',
                                x: 'center'
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    data: ['线上课程', '线下课程']
                                }
                            ],
                            yAxis: [
                               {
                                   type: 'value',
                                   axisLabel: {
                                       formatter: '{value} 门'
                                   }
                               }
                            ],
                            series: [
                                {
                                    name: '当前课程统计',
                                    type: 'bar',
                                    data: [7, 1],

                                },

                            ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option1);
                    }
                })
                function initChart2() {
                    var xml1 = '<chart caption="历史课程统计" numberSuffix="门" ><set value="10" label="线上课程" color="AFD8F8" /><set value="7" label="线下课程" color="F6BD0F" /></chart>';
                    var myChart = new FusionCharts("/FusionCharts/Swf/Column3D.swf", "myChartId_05", '1000', "600");
                    myChart.setDataXML(xml1);
                    myChart.render("divPieChart2");
                }
                initChart2();
                $('#select_type2').change(function () {
                    var val = $(this).val();
                    if (val == 1) {
                        initChart2();
                    } else if (val == 2) {
                        var myChart = echarts.init(document.getElementById('divPieChart2'));
                        /*$.ajax({
                            url: "/Common.ashx",
                            type: "post",
                            async: false,
                            dataType: "json",
                            data: {
                                PageName: "/CourseManage/CourceManage.ashx",
                                Func: "CouseTypeAnalis",
                                Type: "<"
                            },
                            success: function (json) {
                                if (json.result.errNum.toString() == "0") {
                                    myChart.setOption({ //加载数据图表
                                        title: {
                                            text: '当前课程统计',
                                            x: 'center'
                                        },
                                        tooltip: {
                                            trigger: 'axis'
                                        },
                                        calculable: true,
                                        xAxis: [
                                            {
                                                type: 'category',
                                                data: ['线上课程', '线下课程']
                                            }
                                        ],
                                        yAxis: [
                                           {
                                               type: 'value',
                                               axisLabel: {
                                                   formatter: '{value} 门'
                                               }
                                           }
                                        ],
                                        series: [
                                            {
                                                name: '当前课程统计',
                                                type: 'bar',
                                                data: json.result.retData
                                            },

                                        ]

                                    });
                                }
                                else {

                                    alert(json.result.errMsg);
                                }
                            },
                            error: function (errMsg) {
                                alert(errMsg);
                            }
                        });*/
                        option2 = {
                            title: {
                                text: '历史课程统计',
                                x: 'center'
                            },
                            tooltip: {
                                trigger: 'axis'
                            },
                            calculable: true,
                            xAxis: [
                                {
                                    type: 'category',
                                    data: ['线上课程', '线下课程']
                                }
                            ],
                            yAxis: [
                               {
                                   type: 'value',
                                   axisLabel: {
                                       formatter: '{value} 门'
                                   }
                               }
                            ],
                            series: [
                                {
                                    name: '历史课程统计',
                                    type: 'bar',
                                    data: [10, 7],

                                },

                            ]
                        };
                        // 使用刚指定的配置项和数据显示图表。
                        myChart.setOption(option2);
                    }
                })
            </script>
        </div>
    </form>
</body>
</html>
