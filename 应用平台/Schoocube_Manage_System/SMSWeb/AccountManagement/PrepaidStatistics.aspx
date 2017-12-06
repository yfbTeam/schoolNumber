<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepaidStatistics.aspx.cs" Inherits="SMSWeb.AccountManagement.PrepaidStatistics" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>消费统计</title>
    <!--图标样式-->
    <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <link rel="stylesheet" href="/css/plan.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="/AccountManagementMenu.js"></script>

    <script src="/Scripts/echarts-all.js"></script>
</head>
<body>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HSF" runat="server" />
        <div class="width repository_header clearfix">
            <a href="/HZ_Index.aspx" class="logo fl">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl ">
                <img src="/images/chongzhikaguanli.png" />
            </div>
            <nav class="navbar menu_mid fl">
                <ul id="AccountMenu">
                    <%--<li currentclass="active"><a href="PrepaidCardHistory.aspx">消费记录</a></li>
                    <li currentclass="active"><a href="PrepaidStatistics.aspx">消费统计</a></li>--%>
                    <%--<li currentclass="active"><a href="PrepaidCardHistory.aspx" target="_blank">充值记录</a></li>
                    <li currentclass="active"><a href="PrepaidCount.aspx" target="_blank">充值统计</a></li>--%>
                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="javascript:;" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">0</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" class="login_area clearfix">
                            <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <%--<a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>--%>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90 pr ">
        <div class="bordshadrad" style="background: #fff; padding: 20px;">
            <div class="stytem_select clearfix">
                <div class="fl" style="margin-top: 5px;">
                    <label style="float: left; line-height: 38px; display: block;">统计类型：</label>
                    <select class="select" id="select_type">
                        <option value="1" selected="selected">按时间统计</option>
                        <option value="2">按课程类别统计</option>
                    </select>
                </div>
                <div class="fl" style="margin-top:5px;">
                <label style="float:left;line-height:38px;display:block;">图表类型：</label>
                <select class="select" id="select_typeCourse">
                    <option value="0" selected="selected">线性统计</option>
                    <option value="1" >3D统计</option>
                    <option value="2">2D统计</option>
                </select>
            </div>
                <div class="stytem_select_right fr">
                    <a href="javascript:void(0);" onclick="ExportCardPriceHistory()">导出数据</a>
                </div>
            </div>
            <div id="divPieChart" align="center"></div>
            <div id="divPieChart1" align="center" style="width:1000px;height:600px;margin:0 auto;display:none;"></div>
            <%--<div class="wrap">
                <div class="distributed fr" style="margin-top: 30px">
                    <a href="javascript:void(0);" onclick="ExportCardPriceHistory()">导出数据</a>
                </div>
            </div>--%>
        </div>
    </div>
    <script src="/js/common.js"></script>
    <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            var type = UrlDate.type;
            if (type == "1") {
                $("#AccountName").text('账户管理');
                $("img[src='/images/chongzhikaguanli.png']").attr("src", "/images/zhanghuguanli.png");
                $("#AccountMenu").append("<li currentclass=\"active\"><a href=\"/GoPay/Pay_Index.aspx\">我的账户</a></li><li currentclass=\"active\"><a href=\"/GoPay/GoPay.aspx\">充值</a></li><li currentclass=\"active\" class='active'><a href=\"/AccountManagement/PrepaidStatistics.aspx?type=1\" >消费统计</a></li>");
            }
            else {
                AccountMenu();
                $("#HUserIdCard").val('');
            }

            if ($("#HSF").val() == "学生") {
                $("div[class='setting_none']").append("<a href=\"/Gopay/GoPay.aspx\"><span>账户管理</span></a><a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
            } else {
                $("div[class='setting_none']").append("<a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
            }
            // AccountMenu();
            getData();
            setchart("/FusionCharts/Swf/Line.swf", "myChartId_06","");
        })
        var arrTimesPrice = [];
        function getData() {
            var IdCard = "";
            IdCard = $("#HUserIdCard").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/CardPriceHistoryHander.ashx", "Func": "GetPageList", "IdCard": IdCard, "Ispage": false, "HistoryStatistics": "Month(ConsumingTime)"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        arrTimesPrice = [];
                        $(json.result.retData).each(function (i, n) {
                            var obj = new Object();
                            if (n.ConsumingTime != "") {
                                obj.arrTimes = n.ConsumingTime;
                            }
                            obj.arrPrice = n.ConsumptionPrice;
                            arrTimesPrice.push(obj);
                        });

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }       

        var timeArray = [];
        function dataWeek() {
            var colNum = 0;
            timeArray = [];
            var formatDate = function (date) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1);
                var day = date.getDate();
                var week = date.getDay();
                month = month < 10 ? "0" + month : month;
                day = day < 10 ? "0" + day : day;
                return year + "-" + month + "-" + day;
            };
            var addDate = function (date, n) {
                date.setDate(date.getDate() + n);
                return date;
            };
            var setDate = function (date) {
                var week = date.getDay() - 1;
                date = addDate(date, week * -1);
                currentFirstDate = new Date(date);
                for (var i = 0; i < 7; i++) {
                    timeArray += formatDate(i == 0 ? date : addDate(date, 1)) + ",";

                }
            };
            setDate(new Date());
        }
        

        //年统计 1月~12月份统计
        function setchart(swf,name,isColor) {
            var strTimeDate = [];
            //getDateAndPrice();
            var price = "";
            var intPrice = 0;
            var monthTime = "";
            var xml = "";
            var color = "";
            //dataWeek();
            xml += "<chart caption=\"消费统计\" numberPrefix=\"金额\" >";
            for (var strMonth = 1; strMonth < 13; strMonth++) {
                monthTime = "";
                for (var i = 0; i < arrTimesPrice.length; i++) {
                    intPrice = 0;
                    if (arrTimesPrice[i].arrTimes == strMonth) {
                        price = arrTimesPrice[i].arrPrice;
                        intPrice += parseInt(price);
                        monthTime = arrTimesPrice[i].arrTimes + "月";
                        color = "F6BD0F";
                        break;
                    }
                }
                if (monthTime == "") {
                    monthTime = strMonth + "月";
                    color = "8BBA00";
                }
                if (isColor == "") {
                    xml += "<set value='" + intPrice + "'  label='" + monthTime + "' color=\"AFD8F8\" />";
                } else {
                    xml += "<set value='" + intPrice + "'  label='" + monthTime + "' color='" + color + "' />";
                }
                
            }
            xml += "</chart>";
            var myChart = new FusionCharts(swf, name, '1000', "600");
            myChart.setDataXML(xml);
            myChart.render("divPieChart");

        }

        $("#select_type").change(function () {
            var value = $(this).children('option:selected').val();
            var course = $('#select_typeCourse option:selected').val();
            if (value == 1) {
                getData();
                if (course == 0) {
                    $("#divPieChart").show();
                    $("#divPieChart1").hide();
                    setchart("/FusionCharts/Swf/Line.swf", "myChartId_02", "");
                } else if (course == 1) {
                    $("#divPieChart").show();
                    $("#divPieChart1").hide();
                    setchart("/FusionCharts/Swf/Column3D.swf", "myChartId_02", "true");
                } else {
                    $("#divPieChart").hide();
                    $("#divPieChart1").show();
                    //2D可拖拽的统计图需要改善没有做完
                    set2DChart();
                }
                
            } else {
                getDataByType();
                if (course == 0) {
                    $("#divPieChart").show();
                    settypechart("/FusionCharts/Swf/Line.swf", "myChartId_01","");
                } else if (course == 1) {
                    $("#divPieChart").show();
                    settypechart("/FusionCharts/Swf/Column3D.swf", "myChartId_01", "true");
                } else {
                    $("#divPieChart").hide();
                    $("#divPieChart1").show();
                    //2D可拖拽的统计图需要改善没有做完
                    set2DTypeChart();
                    //settypechart("/FusionCharts/Swf/Column2D.swf", "myChartId_01", "");
                }
                
            }
        })

        function ExportCardPriceHistory() {
            window.open('/AccountManagement/ExportHistoryRecords.ashx', "myIframe");
        }
        //获取课程类别统计数据
        function getDataByType() {
            var IdCard = "";
            IdCard = $("#HUserIdCard").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/CardPriceHistoryHander.ashx", "Func": "GetPageList", "IdCard": IdCard, "Ispage": false, "TypeHistoryStatistics": "CardPriceUse"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        arrTimesPrice = [];
                        $(json.result.retData).each(function (i, n) {
                            var obj = new Object();
                            if (n.CardPriceUse != "") {
                                obj.arrCardPriceUse = n.CardPriceUse;
                            }
                            obj.arrPrice = n.ConsumptionPrice;
                            arrTimesPrice.push(obj);
                        });

                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
        //按课程类别统计
        function settypechart(swf, name, isColor) {
            var strTimeDate = [];
            //getDateAndPrice();
            var price = "";
            var intPrice = 0;
            var cardPriceUse = "";
            var xml = "";
            //dataWeek();
            xml += "<chart caption=\"消费统计\" numberPrefix=\"金额\" >";

            for (var i = 0; i < arrTimesPrice.length; i++) {
                intPrice = 0;
                price = arrTimesPrice[i].arrPrice;
                intPrice += parseInt(price);
                cardPriceUse = arrTimesPrice[i].arrCardPriceUse;
                if (isColor == "") {
                    xml += "<set value='" + intPrice + "'  label='" + cardPriceUse + "' color=\"AFD8F8\" />";
                } else {
                    xml += "<set value='" + intPrice + "'  label='" + cardPriceUse + "' color=\"8BBA00\" />";
                }
                
            }
            xml += "</chart>";
            var myChart = new FusionCharts(swf, name, '1000', "600");
            myChart.setDataXML(xml);
            myChart.render("divPieChart");

        }

        $('#select_typeCourse').change(function () {
            var val = $(this).children('option:selected').val();
            var value = $("#select_type option:selected").val();
            if (val == 0) {
                $("#divPieChart").show();
                $("#divPieChart1").hide();
                if (value == 1) {
                    getData();
                    setchart("/FusionCharts/Swf/Line.swf", "myChartId_03", "");
                } else {
                    getDataByType();
                    settypechart("/FusionCharts/Swf/Line.swf", "myChartId_04", "");
                }
                //initChart();
            } else if (val == 1) {
                $("#divPieChart").show();
                $("#divPieChart1").hide();
                if (value == 1) {
                    getData();
                    setchart("/FusionCharts/Swf/Column3D.swf", "myChartId_03", "true");
                    } else {
                        getDataByType();
                        settypechart("/FusionCharts/Swf/Column3D.swf", "myChartId_04", "true");
                    }
            } else {
                if (value == 1) {
                    getData();
                    set2DChart();
                }
                else {
                    getDataByType();
                    set2DTypeChart();
                }
                $("#divPieChart").hide();
                $("#divPieChart1").show();
                
                
             
            }
        })
        //设置时间的2D图形需要改善没有做完
        function set2DChart() {
            var arr = new Array();
            for (var strMonth = 1; strMonth < 13; strMonth++) {
                var monthTime = "";
                for (var i = 0; i < arrTimesPrice.length; i++) {
                    intPrice = 0;
                    if (arrTimesPrice[i].arrTimes == strMonth) {
                        price = arrTimesPrice[i].arrPrice;
                        intPrice += parseInt(price);
                        monthTime = arrTimesPrice[i].arrTimes+"月";
                        break;
                    }
                }
                if (monthTime == "") {
                    var obj = new Object();
                    obj.price = intPrice;
                    obj.monthTime = strMonth + "月";
                    arr.push(obj);
                } else {
                    var obj = new Object();
                    obj.price = intPrice;
                    obj.monthTime = monthTime;
                    arr.push(obj);
                }
            }
            console.log(arr)
            var json = JSON.stringify(arr);
            var myChart = echarts.init(document.getElementById('divPieChart1'));
            option1 = {
                title: {
                    text: '消费统计',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: []
                    }
                ],
                yAxis: [
                   {
                       type: 'value',
                       axisLabel: {
                           formatter: '{value} '
                       }
                   }
                ],
                series: [
                    {
                        name: '金额',
                        type: 'bar',
                        data: []//json

                    },
                    {
                        name: '金额',
                        type: 'line',
                        data: []//json

                    },
                ]
            };
            
            for (var i = 0; i < arr.length; i++) {
                (option1.xAxis[0].data).push( arr[i].monthTime);
                (option1.series[0].data).push(arr[i].price);
            }
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option1);
        }

        //设置课程类别的2D图形需要改善没有做完
        function set2DTypeChart() {
            var json = JSON.stringify(arrTimesPrice);
            console.log(json)
            var myChart = echarts.init(document.getElementById('divPieChart1'));
            option1 = {
                title: {
                    text: '消费统计',
                    x: 'center'
                },
                tooltip: {
                    trigger: 'axis'
                },
                calculable: true,
                xAxis: [
                    {
                        type: 'category',
                        data: []
                    }
                ],
                yAxis: [
                   {
                       type: 'value',
                       axisLabel: {
                           formatter: '{value} '
                       }
                   }
                ],
                series: [
                    {
                        name: '消费统计',
                        type: 'bar',
                        data: []//json

                    },
                    {
                        name: '消费统计',
                        type: 'line',
                        data: []//json

                    },
                ]
            };
            
            for (var i = 0; i < arrTimesPrice.length; i++) {
                (option1.xAxis[0].data).push(arrTimesPrice[i].arrCardPriceUse);
                (option1.series[0].data).push(arrTimesPrice[i].arrPrice);
            }
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option1);
        }

    </script>
</body>
</html>
