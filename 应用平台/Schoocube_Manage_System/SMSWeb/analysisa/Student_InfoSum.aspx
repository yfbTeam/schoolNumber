<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Student_InfoSum.aspx.cs" Inherits="SMSWeb.analysisa.Student_InfoSum" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>信息汇总</title>
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
    <link rel="stylesheet" href="/css/Css.css" />
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
        <div class="onlinetest_item width pr ">
            <div class="bordshadrad " style="background: #fff;">
               <div class="" style="margin-top:5px;">
                    <label style="float:left;line-height:38px;display:block;">图表类型：</label>
                    <select class="select" id="select_type">
                        <option value="1" selected>3D</option>
                        <option value="2">2D</option>
                    </select>
                </div>
                <div id="divPieChart" align="center" style="width:1000px;height:600px;margin:0 auto;"></div>
        <div class="wrap">
            <div class="distributed fr">
                <a href="javascript:void(0);">导出数据</a>
            </div>
            <table>
                <caption style="line-height: 40px;text-align:center;font-weight: bold;">信息汇总</caption>
                <thead>
                <th>新发布的作业，考试</th>
                <th>已经批改的作业，考试</th>
                </thead>
                <tbody>
                   <tr>
                       <td>
                           高二语文测试
                       </td>
                       <td>
                           大三化学测试
                       </td>
                   </tr>
                   <tr>
                       <td>
                           初一下册语文综合考试
                       </td>
                       <td>
                           高二语文测试
                       </td>
                   </tr>
                     <tr>
                       <td>
                           大二语文测试
                       </td>
                       <td>
                           大三数学测试
                       </td>
                   </tr>
                     <tr>
                       <td>
                           大学语文测试
                       </td>
                       <td>
                           大一年终考试
                       </td>
                   </tr>
                    <tr>
                       <td>
                           高中语文测试
                       </td>
                       <td>
                           期末语文考试（初一下册）
                       </td>
                   </tr>
                    <tr>
                       <td>
                           初中语文测试
                       </td>
                       <td>
                           高二
                       </td>
                   </tr>
                     <tr>
                       <td>
                           初中测试
                       </td>
                       <td>
                           高一
                       </td>
                   </tr>
                     <tr>
                       <td>
                          大二期末考试
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                          大一期末月考
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                          语文测试试卷
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                          大四期中月考
                       </td>
                       <td>

                       </td>
                   </tr>
                     <tr>
                       <td>
                           大四期末月考
                       </td>
                       <td>

                       </td>
                   </tr>
                   <tr>
                       <td>
                            大四月考
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            大三月考
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            大二期中
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            大四毕业测验
                       </td>
                       <td>

                       </td>
                   </tr>
                   <tr>
                       <td>
                            大三总结测验
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            2015期末考试
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            高一上半期月考一
                       </td>
                       <td>

                       </td>
                   </tr>
                     <tr>
                       <td>
                            期中考试（初一下册）
                       </td>
                       <td>

                       </td>
                   </tr>
                     <tr>
                       <td>
                           期中考试（七年级下）
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                           2016高一期末考试
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            高二年终
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            高一年终
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            高三下册
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            初三上册
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                            高三期中
                       </td>
                       <td>

                       </td>
                   </tr>
                     <tr>
                       <td>
                           调查问卷
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                           初一年终
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                           初一上册期中
                       </td>
                       <td>

                       </td>
                   </tr>
                    <tr>
                       <td>
                           初三试卷
                       </td>
                       <td>

                       </td>
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
                var xml = '<chart caption="信息汇总" numberSuffix="个"  ><set value="31" label="新发布的作业，考试" color="AFD8F8" /><set value="7" label="已经批改的作业，考试" color="F6BD0F" /></chart>';
                var myChart = new FusionCharts("/FusionCharts/Swf/Column3D.swf", "myChartId_02", '1000', "600");
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
                            text: '信息汇总',
                            x: 'center'
                        },
                        tooltip: {
                            trigger: 'axis'
                        },
                        calculable: true,
                        xAxis: [
                            {
                                type: 'category',
                                data: ['新发布的作业，考试', '已经批改的作业，考试']
                            }
                        ],
                        yAxis: [
                            {
                                type: 'value'
                            }
                        ],
                        series: [
                            {
                                name: '信息汇总',
                                type: 'bar',
                                data: [31, 7],

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
