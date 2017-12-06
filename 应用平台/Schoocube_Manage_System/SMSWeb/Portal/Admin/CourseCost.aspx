<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseCost.aspx.cs" Inherits="SMSWeb.Portal.Admin.CourseCost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="//PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
    <link href="/PortalJs/echarts/asset/css/codemirror.css" rel="stylesheet">
    <link href="/PortalJs/echarts/asset/css/monokai.css" rel="stylesheet">
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
    <script src="/PortalJs/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>

     <script id="tr_Cost" type="text/x-jquery-tmpl">
         <tr>
             <td>${pageIndex()}</td>
             <td>{{if Type==0}}
                  线上购买课程
                 {{else Type==1}}线上充值
                 {{else Type==2}}充值卡消费
                 {{/if}}
             </td>
             <td>${Name}</td>
             <td>${OriginalMoney}</td>
             <td>${Money}</td>
             <td>${CanWithdrawMoney}</td>
             <td>${CreateTime}</td>
         </tr>
     </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>

                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择消费类型：</label>
                        <select name="" class="select" id="CostType" onchange="query();">
                            <option value="">请选择消费类型</option>
                            <option value="0">线上购买课程</option>
                            <option value="1">线上充值</option>
                            <option value="2">充值卡消费</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate text" value="<%=DateTime.Now.AddDays(-7).ToString("yyyy-MM-dd") %>" id="StarDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate text" value="<%=DateTime.Now.ToString("yyyy-MM-dd") %>" id="EndDate" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                    </div>
                    <div class="distributed fr">
                         <a href="javascript:query();" ><i class="icon icon-plus"></i>查询</a>
                    </div>
                </div>
                <div class="wrap">
                    <table class="hr_mess">
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>消费类型</th>
                                <th>消费用户</th>
                                <th>原金额</th>
                                <th>消费金额</th>
                                <th>剩余金额</th>
                                <th>消费时间</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Cost"></tbody>
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
         <script type="text/javascript">
             var FirstLoad = null;
             var isLoad = false;
             $(function () {
                 getData(1, 10);
                 getChart();
                 getChart2D();
             })

             function getData(startIndex, pageSize) {
                 pageNum = (startIndex - 1) * pageSize + 1;
                 $.ajax({
                     url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                     type: "post",
                     async: false,
                     dataType: "json",
                     data: {
                         "PageName": "PortalManage/AdminManager.ashx",
                         "Func": "GetCostPageList",
                         PageIndex: startIndex,
                         PageSize: pageSize,
                         Type: $("#CostType").val(),
                         StarDate: $("#StarDate").val(),
                         EndDate: $("#EndDate").val(),
                         isPage:true
                     },
                     success: function (json) {
                         if (json.result.errNum.toString() == "0") {
                             $("#tb_Cost").html('');
                             $("#tr_Cost").tmpl(json.result.retData.PagedData).appendTo("#tb_Cost");
                             makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                         }
                     },
                     error: function (errMsg) {
                         layer.msg(errMsg);
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
                         Func: "QueryCostChart",
                         Type: $("#CostType").val(),
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

                         }
                     },
                     error: function (XMLHttpRequest, textStatus, errorThrown) {

                     }
                 });
             }

             var option = {
                 title: {
                     text: '统计消费记录',
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
                         name: '消费来源',
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
                         Func: "QueryCostEchart",
                         Type: $("#CostType").val(),
                         StarDate: $("#StarDate").val(),
                         EndDate: $("#EndDate").val(),
                         isPage: true
                     },
                     success: function (json) {
                         if (json.result.errMsg == "success") {
                             var items = json.result.retData;
                             if (items != null && items.length > 0) {
                                 var legends = [];
                                 var series = [];
                                 for (var i = 0; i < items.length; i++) {
                                     legends.push(items[i].CostName);
                                     var obj = new Object();
                                     obj.name = items[i].CostName;
                                     obj.value = items[i].COUNT;
                                     series.push(obj);
                                 }
                                 option.legend.data = legends;
                                 option.series[0].data = series;
                                 // myChart.setOption(option, true);
                                 // refresh();
                                 if (isLoad) {
                                     refresh(true);
                                 }
                                 isLoad = true;
                             } else
                             {
                                 option.legend.data = [];
                                 option.series[0].data = [];
                             }
                         }
                         else {
                             //$("#chartDiv").html("生成饼图失败！");
                             option.legend.data = [];
                             option.series[0].data = [];
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
             function updateGrid()
             {
                 var legs = myChart.component.legend.getSelectedMap();
             }

         </script>
    </form>
    <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
    <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
</body>
</html>
