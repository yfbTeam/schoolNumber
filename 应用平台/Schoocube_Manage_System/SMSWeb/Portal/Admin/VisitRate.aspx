<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitRate.aspx.cs" Inherits="SMSWeb.Portal.Admin.VisitRate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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
    <script type="text/javascript" src="//js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>

    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>
    

    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
        .main {
            margin:0 auto;
            height: 400px;
            /* width: 778px !important; */
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
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}
            </td>
            <td>${ICookie}</td>
            <td>
                {{if UserName==-1}}游客
                {{else}}${UserName}
                {{/if}}
            </td>
            <td>${IP}</td>
            <td>${Address}</td>
            <td>${CreateTime}</td>
            <td>${refer}</td>
        </tr>
    </script>

    
</head>
<body>
    <form id="form1" runat="server">

        <div class="onlinetest_item ">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="query();">
                            <option value="">请选择类型</option>
                            <option value="0">游客</option>
                            <option value="1">普通用户</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})"  runat="server"/>
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})"  runat="server"/>

                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                    </div>
                </div>
                <div class="wrap">
                    <table class="PL_form">
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                 <th>电脑编号</th>
                                <th>用户名称</th>
                                <th>IP地址</th>
                                <th>所在地区</th>
                                <th>访问时间</th>
                                <th>设备</th>
                            </tr>
                        </thead>
                        <tbody id="tb_record"></tbody>
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

    </form>
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
                    Func: "GetVisitRatePageList",
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    UserName: $("#selType").val(),
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
                        $("#tb_record").html("<tr><td colspan='8'>暂无系统通知！</td></tr>");
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

        var chart_VisitRate;
        function getChart()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "QueryNetworkflowChart",
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    UserName: $("#selType").val(),
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
                text: '网站流量统计变化',
                subtext: '流量比例'
            },
            tooltip: {
                trigger: 'axis'
            },
            legend: {
                data: ['游客', '学员']
            },
            toolbox: {
                show: true,
                feature: {
                    mark: { show: true },
                    dataView: { show: true, readOnly: false },
                    magicType: { show: true, type: ['line', 'bar'] },
                    restore: { show: true },
                    saveAsImage: { show: true }
                }
            },
            calculable: true,
            xAxis: [
                {
                    type: 'category',
                    boundaryGap: false,
                    data: []
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        formatter: '{value} PV'
                    }
                }
            ],
            series: [
                {
                    name: '游客',
                    type: 'line',
                    data: [],
                    markPoint: {
                        data: [
                            //{ type: 'max', name: '最大值' },
                            //{ type: 'min', name: '最小值' }
                        ]
                    },
                    markLine: {
                        data: [
                            //{ type: 'average', name: '平均值' }
                        ]
                    }
                },
                {
                    name: '学员',
                    type: 'line',
                    data: [],
                    markPoint: {
                        data: [
                            //{ name: '周最低', value: -2, xAxis: 1, yAxis: -1.5 }
                        ]
                    },
                    markLine: {
                        data: [
                            //{ type: 'average', name: '平均值' }
                        ]
                    }
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
                    Func: "QueryNetworkflowEChart",
                    UserName: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            var legends = [];
                            var series1 = [];
                            var series2 = [];
                            for (var i = 0; i < items.length; i++) {
                                series1.push(items[i].游客);
                                series2.push(items[i].学员);
                                legends.push(items[i].时间);
                            }
                            option.xAxis[0].data = legends;
                            option.series[0].data = series1;
                            option.series[1].data = series2;
                            // myChart.setOption(option, true);
                            // refresh();
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
    </script>
    <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
    <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
</body>
</html>
