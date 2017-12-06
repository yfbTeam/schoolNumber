<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test_markline(11)5.aspx.cs" Inherits="SMSWeb.analysisa.test_markline_11_5" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>《CG绘画培训》考试成绩</title>
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
                    <li currentclass="active">
                        <a href="knowledge_line(1).aspx">知识点掌握统计</a>
                    </li>
                    <li currentclass="active" class="active">
                        <a href="test_markline(11).aspx" class="active">考试成绩</a>
                    </li>
                    <li currentclass="active"><a href="work_finishline(13).aspx">作业完成情况</a></li>
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
    <div  class="bordshadrad chartsdiv" style="background: #fff;padding:20px;">
        <div class="stytem_select clearfix">
            <div class="fl" style="margin-top:5px;">
                <label style="float:left;line-height:38px;display:block;">图表类型：</label>
                <select class="select" id="select_type">
                    <option value="1" selected>3D</option>
                    <option value="2">2D</option>
                </select>
            </div>
            <div class="stytem_select_right fr">
                <a href="test_markline(11).aspx">
                    <i class="icon icon-reply"></i>
                    <span>返回上级</span>
                </a>
            </div>
        </div>
        <div id="divPieChart" align="center" style="width:1000px;height:600px;margin:0 auto;"></div>
        <div class="wrap">
            <div class="distributed fr">
                <a href="javascript:void(0);">导出数据</a>
            </div>
            <table>
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">《CG绘画培训》考试成绩</caption>
                <thead>
                    <tr>
                        <th>姓名</th>
                        <th>成绩</th>
                        <th>成绩段</th>
                    </tr> 
                </thead>
                <tbody>
                     <tr>
                       <td>罗秋香</td>
                       <td>100分</td>
                         <td>100分</td>
                   </tr>
                    <tr>
                        <td>赵灵可</td>
                        <td>96</td>
                        <td>90-99</td>
                    </tr>
                    <tr>
                        <td>谢章峰</td>
                        <td>93</td>
                        <td>90-99</td>
                    </tr>
                    <tr>
                        <td>张红</td>
                        <td>91</td>
                        <td>90-99</td>
                    </tr>
                    <tr>
                        <td>胡歌</td>
                        <td>89</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>张琳</td>
                        <td>88</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>石琳</td>
                        <td>87</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>韩寒</td>
                        <td>84</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>王丽</td>
                        <td>84</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>左义</td>
                        <td>82</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>袁熙</td>
                        <td>81</td>
                        <td>80-89</td>
                    </tr>
                    <tr>
                        <td>唐叶</td>
                        <td>78</td>
                        <td>70-79</td>
                    </tr>
                    <tr>
                        <td>郝旭</td>
                        <td>76</td>
                        <td>70-79</td>
                    </tr>
                    <tr>
                        <td>林彤</td>
                        <td>68</td>
                        <td>60-69</td>
                    </tr>
                    <tr>
                        <td>方晓</td>
                        <td>63</td>
                        <td>60-69</td>

                    </tr>
                    <tr>
                        <td>王小明</td>
                        <td>56</td>
                        <td>60分以下</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>
    <script src="../js/common.js"></script>
<script>
    $('.wrap').kkPages({
        PagesClass: 'tbody tr', //需要分页的元素
        PagesMth: 10, //每页显示个数
        PagesNavMth: 4 //显示导航个数
    });
    function initChart() {
        var xml = '<chart caption="《CG绘画培训》考试成绩" numberPrefix="个" ><set value="1" label="100分" color="AFD8F8" /><set value="3" label="90-99" color="F6BD0F" /><set value="7" label="80-89" color="8BBA00" /><set value="2" label="70-79" color="AFD8F8" /><set value="2" label="60-69" color="F6BD0F" /><set value="1" label="60分以下" color="8BBA00" /></chart>';
        var myChart = new FusionCharts("../FusionCharts/Swf/Line.swf", "myChartId_02", '1000', "600");
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
                    text: '《CG绘画培训》考试成绩',
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
                        data: ['100分', '90-99', '80-89', '70-79', '60-69', '60分以下']
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
                        name: '《CG绘画培训》考试成绩',
                        type: 'line',
                        data: [1, 3, 7, 2, 2, 1],

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
