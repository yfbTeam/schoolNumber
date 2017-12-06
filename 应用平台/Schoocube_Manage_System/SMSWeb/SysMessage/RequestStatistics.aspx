<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestStatistics.aspx.cs" Inherits="SMSWeb.SysMessage.RequestStatistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="format-detection" content="telephone=no">
    <title>访问率分析</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/PortalJs/echarts/asset/css/codemirror.css" rel="stylesheet">
    <link href="/PortalJs/echarts/asset/css/monokai.css" rel="stylesheet">
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}
            </td>
            <td>${名称}</td>
            <td>{{if RequestType==0}}课程
                {{else RequestType==1}}知识点
                {{else RequestType==2}}资源
                {{else RequestType==3}}新闻通知
                 {{else RequestType==4}}知识库
                 {{else RequestType==5}}登录
                {{else}}暂无
                {{/if}}
            </td>
            <td>${RequestDate}</td>
            <td>${内部学员}</td>
            <td>${外部学员}</td>
            <td><a href="javascript:;" onclick="javascript: OpenIFrameWindow('查看', 'RequestQuery.aspx?courseId=${RequestSourceID}&date=${RequestDate}', '580px', '360px');"><i class="icon icon-eye-open"></i>查看</a></td>
        </tr>
    </script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style>
        .wrap table tbody tr td a {
            display: inline-block;
            background: none;
            color: #5493d7;
        }

        * {
            box-sizing: border-box;
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
         .main {
            height: 400px;
            /*width: 778px !important;*/
            overflow: hidden;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #e3e3e3;
            -webkit-border-radius: 4px;
            -moz-border-radius: 4px;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            -moz-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
            box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0.05);
        }
    </style>
</head>
<body>
    <div class="onlinetest_item pr ">
        <div class=" chartsdiv" style="background: #fff; padding: 10px;">
            <div class="stytem_select clearfix">
                <div class="fl" style="margin-top: 5px;">
                    <label style="float: left; line-height: 38px; display: block;">选择类型：</label>
                    <select class="select" name="selType" id="selType" onchange="query();">
                        <option value="">请选择类型</option>
                        <option value="0">课程</option>
                        <option value="1">知识点</option>
                        <option value="2">资源</option>
                        <option value="3">新闻通知</option>
                        <option value="4">知识库</option>
                        <option value="5">登录</option>
                    </select>
                </div>
                <div class="clearfix fl course_select">
                    <label for="">选择日期：</label>
                    <input type="text" class="Wdate" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                    <input type="text" class="Wdate" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                </div>
            </div>
            <div class="wrap">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="query()">查询</a>
                </div>
                <table>
                    <thead>
                        <tr>
                            <th class="number">序号</th>
                            <th>名称</th>
                            <th>类型</th>
                            <th>日期</th>
                            <th>内部学员访问点击量</th>
                            <th>外部学院点击量</th>
                            <th>查看记录</th>
                        </tr>
                    </thead>
                    <tbody id="tb_record">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--分页-->
    <div class="page">
        <span id="pageBar"></span>
    </div>
    <div id="chartDiv"></div>
    <div id="main" class="main"></div>
        <div>
            <button type="button" class="btn btn-sm btn-success" onclick="refresh(true)">刷 新</button>
            <span class="text-primary">切换主题</span>
            <select id="theme-select"></select>

            <span id='wrong-message' style="color: red"></span>
        </div>

    <script src="/js/common.js"></script>
    <script type="text/javascript">
        var FirstLoad = null;
        var isLoad = false;
        $(document).ready(function () {
            getData(1, 10);
            getChart();
            getChart2D();
        });
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "GetPageList",
                    RequestType: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_record").html('');
                        $("#tr_record").tmpl(json.result.retData.PagedData).appendTo("#tb_record");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_record").html("<tr><td colspan='8'>暂无系统记录！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function getChart() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "QueryChart",
                    RequestType: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    FirstLoad: FirstLoad
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        if (FirstLoad == "success") {
                            chart_VisitRate.setDataXML(json.result.retData);
                            chart_VisitRate.render("VisitRateDiv")
                        } else {
                            $("#chartDiv").html(json.result.retData);
                        }
                        $("#chartDiv").css('width','100%','height','300px;')
                        FirstLoad = "success";
                    }
                    else {
                        //$("#chartDiv").html("生成饼图失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        var option = {
            title: {
                text: '访问率分析',
                subtext: '访问数据',
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
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "QeuryChartForRequest",
                    RequestType: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {

                            var legends = [];
                            var series = [];
                            for (var i = 0; i < items.length; i++) {
                                legends.push(items[i].名称);
                                var obj = new Object();
                                obj.name = items[i].名称;
                                obj.value = items[i].总记录数;
                                series.push(obj);
                            }
                            option.legend.data = legends;
                            option.series[0].data = series;
                            if (isLoad) {
                                refresh(true);
                            }
                            isLoad = true;
                        }
                    }
                    else {
                        //$("#chartDiv").html("生成饼图失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function query() {
            getData(1, 10);
            getChart();
            getChart2D();
        }

        function updateGrid() {
            var legs = myChart.component.legend.getSelectedMap();
        }

    </script>
     <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
        <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
</body>
</html>
