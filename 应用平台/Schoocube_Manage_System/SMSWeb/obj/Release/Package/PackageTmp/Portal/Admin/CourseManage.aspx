<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseManage.aspx.cs" Inherits="SMSWeb.Portal.Admin.CourseManage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../../css/onlinetest.css" />
    <style type="text/css">
        .main {
    height: 400px;
    /*width: 778px !important;*/
    overflow: hidden;
    padding : 10px;
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
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/js/jquery.jqprint.js"></script>
    <script src="/Scripts/jquery-migrate-1.1.0.js"></script>
    <script src="/Scripts/html2canvas.js"></script>

     <script src="/PortalJs/echarts/www/js/echarts.js"></script>
    <script src="/PortalJs/echarts/asset/js/codemirror.js"></script>
    <link href="/PortalJs/echarts/asset/css/codemirror.css" rel="stylesheet">
    <link href="/PortalJs/echarts/asset/css/monokai.css" rel="stylesheet">

     <script id="tr_Course" type="text/x-jquery-tmpl">
         <tr>
             <td>${pageIndex()}</td>
             <td>${Name}</td>
             <td>{{if CourceType==2}}线上课程
            {{else}}线下课程
                  {{/if}}
             </td>
             <td>{{if IsCharge==1}}收费
            {{else}}免费
                  {{/if}}
             </td>
             <td>${CoursePrice}</td>
             <td>${GradeName}</td>
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
                        <label for="">选择课程类型：</label>
                        <select name="" class="select" id="CourseType" onchange="query();">
                            <option value="">请选择课程类型</option>
                            <option value="2">线下课程</option>
                            <option value="1">线上课程</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择收费类型：</label>
                        <select name="" class="select" id="IsCharge" onchange="query();">
                            <option value="">请选择课程类型</option>
                            <option value="1">收费</option>
                            <option value="0">免费</option>
                        </select>
                    </div>
                  <%--  <div class="clearfix fl course_select">
                        <label for="">选择统计图类型：</label>
                        <select name="" class="select" id="ChartType" onchange="query();">
                            <option value="1">2D</option>
                            <option value="0">3D</option>
                        </select>
                    </div>--%>
                     <div class="distributed fr">
                         <div class="clearfix fl course_select">
                        <label for="">选择导出格式：</label>
                        <select name="" class="select" id="exportType">
                            <option value="excel">Excel</option>
                            <option value="pdf">PDF</option>
                            <option value="word">Word</option>
                        </select>
                    </div>
                         <a href="javascript:void(0);" id="print"><i class="icon icon-plus"></i>打印</a>
                         <a href="javascript:void(0);" id="export"><i class="icon icon-plus"></i>导出</a>
                    </div>
                </div>
                <div class="wrap">
                    <table class="hr_mess">
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>课程名称</th>
                                <th>类型</th>
                                <th>收费方式</th>
                                <th>价格</th>
                                <th>年级</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Course"></tbody>
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
        $(function () {
            getData(1, 10);
            getChart();
            getChart2D();
            $("#print").click(function () {
                $("#chartDiv").jqprint({
                    debug: false, //如果是true则可以显示iframe查看效果（iframe默认高和宽都很小，可以再源码中调大），默认是false
                    importCSS: true, //true表示引进原来的页面的css，默认是true。（如果是true，先会找$("link[media=print]")，若没有会去找$("link")中的css文件）
                    printContainer: true, //表示如果原来选择的对象必须被纳入打印（注意：设置为false可能会打破你的CSS规则）。
                    operaSupport: true//表示如果插件也必须支持歌opera浏览器，在这种情况下，它提供了建立一个临时的打印选项卡。默认是true
                });
            })
            $("#export").on("click", function () {

                window.open('/Portal/Admin/ExportInfo.ashx?Func=ExportCourse&CourseType=' + $("#CourseType").val() + '&ExportType=' + $("#exportType").val(), "myIframe");

                //$.ajax({
                //    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                //    type: "post",
                //    async: false,
                //    dataType: "json",
                //    data: { "PageName": "PortalManage/AdminManager.ashx", "Func": "ExportCourse", CourseType: $("#CourseType").val(), ExportType: $("#exportType").val() },
                //    success: function (json) {
                //        if (json.result.errNum.toString() == "0") {

                //        }
                //    },
                //    error: function (errMsg) {
                //        layer.msg(errMsg);
                //    }
                //    //$('.allcourses li .allcourse_img img')
                //});
            })

        })
        function getData(startIndex, pageSize) {
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "PortalManage/AdminManager.ashx", "Func": "GetCoursePageList", PageIndex: startIndex, pageSize: pageSize, CourseType: $("#CourseType").val(), IsCharge: $("#IsCharge").val() },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_Course").html('');
                        $("#tr_Course").tmpl(json.result.retData.PagedData).appendTo("#tb_Course");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
                //$('.allcourses li .allcourse_img img')
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
                    Func: "QueryCourseChart",
                    CourseType: $("#CourseType").val(),
                    IsCharge: $("#IsCharge").val(),
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
                    data:[]
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
                    Func: "QueryCourseEchart",
                    CourseType: $("#CourseType").val(),
                    IsCharge: $("#IsCharge").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items!=null && items.length>0) {
                            var legends = [];
                            var series = [];
                            for (var i = 0; i < items.length; i++) {
                                legends.push(items[i].CourseName);
                                var obj = new Object();
                                obj.name = items[i].CourseName;
                                obj.value = items[i].COUNT;
                                series.push(obj);
                            }
                            option.legend.data = legends;
                            option.series[0].data = series;
                           // myChart.setOption(option, true);
                           // refresh();
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
        }

        //选中Legend
        function updateGrid()
        {
            var legs = myChart.component.legend.getSelectedMap();
        }

    </script>
    <script src="/PortalJs/echarts/asset/js/bootstrap.min.js"></script>
    <script src="/PortalJs/echarts/asset/js/echartsExample.js"></script>
</body>
</html>
