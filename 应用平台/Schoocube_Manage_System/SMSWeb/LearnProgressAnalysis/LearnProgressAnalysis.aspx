<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LearnProgressAnalysis.aspx.cs" Inherits="SMSWeb.LearnProgressAnalysis.LearnProgressAnalysis" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>个人学习进度分析</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/FusionChart/js/fusioncharts.js"></script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <%--<input type="hidden" id="Hid_ClassID" value="<%=ClassID %>" />--%>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
           <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li><a href="/CourseManage/students_index.aspx">学生首页</a></li>
                    <li><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                    <li><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                    <li><a href="#">在线考试</a></li>
                    <li class="active"><a href="#">个人学习进度分析</a></li>
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
                           <%-- <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %></h2>--%>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90">
        <div class="myexam bordshadrad">
            <div class="mycourse">
                <div id="chartContainer1"></div>
                <div id="chartContainer2"></div>
                <div id="divPieChart1"></div>
                <div id="divPieChart2"></div>
            </div>
        </div>
    </div>
    <script src="/js/common.js"></script>
</body>
<script type="text/javascript">   
    $(document).ready(function () {
        var jsonobj ={chart:{xAxisName:"x",yAxisName:"y",allowDrag:1},data:[{ "label": "aa", "value": 10, "color": "76A5DB" },{ "label": "bb", "value": 20, "color": "76A5DB" }]};
        var prefix = "/Scripts/FusionChart/";
        DrawFusionChart(prefix + "Swf/Line.swf", "chartContainer1", "100%", 200, "json", jsonobj);
        //饼状图
        DrawFusionChart(prefix + "Pie3D.swf", "divPieChart1", "831", "396", "xml", '<chart caption="测试" numberPrefix="$" allowDrag="1"><set value="25" label="Item A" color="AFD8F8" /><set value="17" label="Item B" color="F6BD0F" /><set value="23" label="Item C" color="8BBA00" isSliced="1" /></chart>');

        var initchart = InitFusionChartByJson("column3d", "chartContainer2", 500, 300,
        { caption: "caption", subCaption: "subCaption", xAxisName: "Month", yAxisName: "Revenues (In USD)", theme: "theme"},
        [{ label: "Jan", value: "420000", text: "测试", allowDrag: 1 }, { label: "Feb", value: "810000", allowDrag: 1 }, { label: "Mar", value: "720000", text: "测试", allowDrag: 1 }]);
        //alert(initchart.getChartData("json"));
        //alert(initchart.getJSONData());
    });
    /*
    swfurl：swf文件相对路径；
    controlid：绑定chart的控件id；
    datatype的值可取如下：xml,xmlurl,json,jsonurl；
    data：xml或json文件路径、xml或json数据
    */
    function DrawFusionChart(swfurl, controlid, width, height, datatype, data) {
        var chart = new FusionCharts(swfurl, new Date().getTime(), width, height);
        if (datatype == "xmlurl") { data = ConstructHttpString(xmlUrl);}
        chart.setChartData(data, datatype);
        //chart.addParam("wmode", "Opaque");
        chart.render(controlid);
    }
    function ConstructHttpString(myURL) {
        myURL += "?rnd=" + new Date().getTime();
        return encodeURIComponent(myURL.toString());
    }
    
    /*
    swftype：图标类型；
    controlid：绑定chart的控件id；
    chartsour：{ caption: "标题", subCaption: "子标题", xAxisName: "x轴名称", yAxisName: "y轴名称", theme: "theme",clickURL:"整个图形的点击事件" }
    datasour：[{ label: "Jan", value: "420000",link: "可以是链接，也可以是js脚本" }, { label: "Feb", value: "810000",link: "JavaScript:textalert(1);" }}]
    dataformat：数据格式 （json（默认）、jsonurl、xml、xmlurl、csv）
    */
    function InitFusionChartByJson(swftype, controlid, width, height, chartsour, datasour, dataformat) {
        dataformat = arguments[6] || "json";
        var revenueChart;
        //FusionCharts.ready(function () {
            revenueChart = new FusionCharts({
                type: swftype,
                renderAt: controlid,
                width: width,
                height: height,
                dataFormat: dataformat,
                dataSource: {
                    chart: chartsour,
                    data: datasour
                }
            });
            revenueChart.render();
        //});
        return revenueChart;
    }
</script>
</html>
