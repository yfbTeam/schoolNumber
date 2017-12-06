<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitRateView.aspx.cs" Inherits="SMSWeb.Monitor.VisitRateView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>访问率分析</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link href="/PortalJs/echarts/asset/css/codemirror.css" rel="stylesheet" />
    <link href="/PortalJs/echarts/asset/css/monokai.css" rel="stylesheet" />
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
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script type="text/javascript" src="/js/common.js"></script>
    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>

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
            <td><a href="javascript:;" onclick="javascript: OpenIFrameWindow('查看', 'Query.aspx?courseId=${RequestSourceID}&date=${RequestDate}', '580px', '360px');"><i class="icon icon-edit"></i>查看</a></td>
        </tr>
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <%if (SF == "教师") { %>
                <a class="logo fl" href="/HZ_Index.aspx">
                  <%}  else { %>
                <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                 <%} %>
                    <img src="/images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="/images/fangwenlvfenxi.png" />
                </div>
                <nav class="navbar menu_mid fl">

                    <ul id="CourceMenu">
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
        <div class="onlinetest_item width pt90">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
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
                        <input type="text" class="Wdate text" value="<%=DateTime.Now.AddDays(-1).ToString("yyyy-MM-dd") %>" id="StarDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate text" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" id="EndDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择导出格式：</label>
                        <select name="" class="select" id="exportType">
                            <option value="excel">Excel</option>
                            <option value="pdf">PDF</option>
                            <option value="word">Word</option>
                        </select>
                    </div>

                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="query()">查询</a>
                        <a href="javascript:void(0);" id="export"><i class="icon icon-plus"></i>导出</a>
                    </div>
                </div>
                <div class="wrap">
                    <table class="PL_form">
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
                 <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                </div>
                <div id="chartDiv"></div>
                <div id="main" class="main" style="margin:0 auto;"></div>
                <div>
                    <button type="button" class="btn btn-sm btn-success" onclick="refresh(true)">刷 新</button>
                    <span class="text-primary">切换主题</span>
                    <select id="theme-select"></select>

                    <span id='wrong-message' style="color: red"></span>
                </div>
            </div>
        </div>
       

        <script src="/js/common.js"></script>
        <script type="text/javascript">
            var FirstLoad = null;
            var chart_VisitCourse;
            var isLoad = false;
            $(document).ready(function () {
                getData(1, 10);
                getChart();
                getChart2D();
                $("#export").on("click", function () {
                    window.open('/Portal/Admin/ExportInfo.ashx?Func=ExportVisitRate&RequestType=' + $("#selType").val() + '&StarDate=' + $("#StarDate").val() + '&EndDate=' + $("#EndDate").val() + '&ExportType=' + $("#exportType").val(), "myIframe");

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
                        PageName: "PortalManage/MonitorRecordHandler.ashx",
                        Func: "GetPageList",
                        RequestType: $("#selType").val(),
                        StarDate: $("#StarDate").val(),
                        EndDate: $("#EndDate").val(),
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
                                    var tname = items[i].名称;
                                    if (tname == "登录" && $("#selType").val() == "5") {
                                        tname = items[i].RequestDate;
                                        legends.push(items[i].RequestDate);
                                    } else {
                                        legends.push(tname);
                                    }
                                    var obj = new Object();
                                    obj.name = tname;
                                    obj.value = items[i].总记录数;
                                    series.push(obj);
                                }
                                option.legend.data = legends;
                                option.series[0].data = series;
                                if (isLoad) {
                                    refresh(true);
                                }
                                isLoad = true;
                            } else {
                                option.legend.data = [];
                                option.series[0].data = [];
                                if (isLoad) {
                                    refresh(true);
                                }
                            }
                        }
                        else {
                            option.legend.data = [];
                            option.series[0].data = [];
                            if (isLoad) {
                                refresh(true);
                            }
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

            //选中Legend
            function updateGrid() {
                var legs = myChart.component.legend.getSelectedMap();
            }
        </script>
        <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
        <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
    </form>
</body>
</html>
