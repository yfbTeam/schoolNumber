<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebSiteQuery.aspx.cs" Inherits="SMSWeb.Portal.Admin.WebSiteQuery" %>

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
    <style type="text/css">
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
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Name}</td>
            <td>{{if IsCharge==1}}收费
            {{else}}免费
                  {{/if}}
            </td>
            <td>${CoursePrice}</td>
            <td>${ClickNum}</td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HType" runat="server" />
        <div class="newcourse_select clearfix">
            <div class="distributed fr">
                <div class="clearfix fl course_select">
                    <label for="">选择导出格式：</label>
                    <select name="" class="select" id="exportType">
                        <option value="excel">Excel</option>
                        <option value="pdf">PDF</option>
                        <option value="word">Word</option>
                    </select>
                </div>
                <a href="javascript:void(0);" id="export"><i class="icon icon-plus"></i>导出</a>
            </div>
        </div>
        <div class="wrap">
            <table class="PL_form">
                <thead>
                    <tr>
                        <th class="number">序号</th>
                        <th>课程名称</th>
                        <th>是否收费</th>
                        <th>价格</th>
                        <th>点击量</th>
                    </tr>
                </thead>
                <tbody id="tb_record">
                </tbody>
            </table>
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
        $(document).ready(function () {
            getData(1, 10);
            getChart();
            getChart2D();
            $("#export").on("click", function () {

                window.open('/Portal/Admin/ExprotInfoForWebSite.ashx?Func=ExportCourse&CourseType=' + $("#HType").val() + '&ExportType=' + $("#exportType").val(), "myIframe");
            })
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
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "QueryCourseHistory",
                    type: $("#HType").val(),
                    PageIndex: startIndex,
                    PageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_record").html('');
                        $("#tr_record").tmpl(json.result.retData.PagedData).appendTo("#tb_record");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_record").html("<tr><td colspan='8'>暂无记录！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        var chart_VisitCourse;
        function getChart() {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "QueryCourseChartForWebSite",
                    CourseType: $("#HType").val(),
                    FirstLoad: FirstLoad
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        if (FirstLoad == "success") {
                            chart_VisitCourse.setDataXML(json.result.retData);
                            chart_VisitCourse.render("VisitCourseDiv")
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
                text: '统计培训课程',
                subtext: '比例数据',
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
                    name: '课程来源',
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
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "QueryCourseEchartForWebSite",
                    CourseType: $("#HType").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            var legends = [];
                            var series = [];
                            for (var i = 0; i < items.length; i++) {
                                legends.push(items[i].Name);
                                var obj = new Object();
                                obj.name = items[i].Name;
                                obj.value = items[i].ClickNum;
                                series.push(obj);
                            }
                            option.legend.data = legends;
                            option.series[0].data = series;
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


        //选中Legend
        function updateGrid() {
            var legs = myChart.component.legend.getSelectedMap();
        }
    </script>
      <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
    <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
</body>
</html>
