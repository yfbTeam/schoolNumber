<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepaidStatistics.aspx.cs" Inherits="SMSWeb.AccountManagement.PrepaidStatistics" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>消费统计</title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <link rel="stylesheet" href="../css/Css.css"/>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script type="text/javascript" src="../Scripts/FusionChart/js/fusioncharts.js"></script>
    <script src="../AccountManagementMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../js/jquery.kkPages.js"></script>
</head>
<body>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HSF" runat="server" />
        <div class="width repository_header clearfix">
            <a href="../HZ_Index.aspx" class="logo fl">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl ">
                <img src="../images/chongzhikaguanli.png" />
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
                        <a href="" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">0</span>
                        </a>
                    </li>
                    <li>
                        <a href="" class="login_area clearfix">
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
            <div id="divPieChart" align="center"></div>
            <div class="wrap">
                <div class="distributed fr" style="margin-top: 30px">
                    <a href="javascript:void(0);" onclick="ExportCardPriceHistory()">导出数据</a>
                </div>
            </div>
        </div>
    </div>
    <script src="../js/common.js"></script>
    <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
    <script>
        var UrlDate = new GetUrlDate();
        $(function () {
            var type = UrlDate.type;
            if (type == "1") {
                $("#AccountName").text('账户管理');
                $("img[src='../images/chongzhikaguanli.png']").attr("src", "../images/zhanghuguanli.png");
                $("#AccountMenu").append("<li currentclass=\"active\"><a href=\"/GoPay/Pay_Index.aspx\">我的账户</a></li><li currentclass=\"active\"><a href=\"/GoPay/GoPay.aspx\">充值</a></li><li currentclass=\"active\" class='active'><a href=\"/AccountManagement/PrepaidStatistics.aspx?type=1\" >消费统计</a></li>");
            } else {
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
            setchart();
        })
        var arrTimesPrice = [];
        function getData() {
            var IdCard = "";
            IdCard = $("#HUserIdCard").val();
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/CardPriceHistoryHander.ashx", "Func": "GetPageList", "IdCard": IdCard, "Ispage": false, "HistoryStatistics": 1
                },
                success: OnSuccess,
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

        //获取数据成功显示列表
        function OnSuccess(json) {
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

        //当月统计
        //function setdaychart() {
        //    var year = date.getFullYear();
        //    var month = (date.getMonth() + 1);
        //    var new_date = new Date(year, month, '1');
        //    var day = (new Date(new_date.getTime() - 1000 * 60 * 60 * 24)).getDate();
        //    for (var strMonth = 1; strMonth < day; strMonth++) {
        //        monthTime = "";
        //        for (var i = 0; i < arrTimesPrice.length; i++) {
        //            intPrice = 0;
        //            if (arrTimesPrice[i].arrTimes == strMonth) {
        //                price = arrTimesPrice[i].arrPrice;
        //                intPrice += parseInt(price);
        //                monthTime = arrTimesPrice[i].arrTimes + "月";
        //                break;
        //            }
        //        }
        //        if (monthTime == "") {
        //            monthTime = strMonth + "月";
        //        }
        //        xml += "<set value='" + intPrice + "'  label='" + monthTime + "' color=\"AFD8F8\" />";
        //    }
        //}
        //function getDateAndPrice() {
        //    $("#tb_PayHistory tr ").each(function () {
        //        arrTimes = $(this).children('td').eq(1).text();
        //        arrPrice = $(this).children('td').eq(2).text();
        //        var obj = new Object();
        //        obj.arrTimes = arrTimes;
        //        obj.arrPrice = arrPrice;
        //        arrTimesPrice.push(obj);
        //    })
        //}
        $('.wrap').kkPages({
            PagesClass: 'tbody tr', //需要分页的元素
            PagesMth: 10, //每页显示个数
            PagesNavMth: 4 //显示导航个数
        });

        //年统计 1月~12月份统计
        function setchart() {
            var strTimeDate = [];
            //getDateAndPrice();
            var price = "";
            var intPrice = 0;
            var monthTime = "";
            var xml = "";
            //dataWeek();
            xml += "<chart caption=\"消费统计\" numberPrefix=\"金额\" >";
            //timeArray = timeArray.substring(0, timeArray.length - 1);
            //if (timeArray.length > 0) {
            //    strTimeDate = timeArray.split(",");
            //}

            //for (var i = 0; i < arrTimesPrice.length; i++) {
            //    intPrice = 0;
            //    if (arrTimesPrice[i].arrPrice != "") {
            //        intPrice += parseInt(arrTimesPrice[i].arrPrice) + ",";
            //    }
            //    if (arrTimesPrice[i].arrTimes != "") {
            //        monthTime += arrTimesPrice[i].arrTimes + ",";
            //    }
            //}


            for (var strMonth = 1; strMonth < 13; strMonth++) {
                //for (var arr = 0; arr < arrMonthTime.length; i++) {
                //    if (arrMonthTime[arr] == strMonth) {
                //        monthTime += arrMonthTime[arr];
                //        break;
                //    } else {
                //        monthTime += "";
                //    }
                //}
                //if (monthTime == "") {
                //    monthTime += strMonth + "月";
                //} else {
                //    monthTime += monthTime;
                //}
                monthTime = "";
                for (var i = 0; i < arrTimesPrice.length; i++) {
                    intPrice = 0;
                    if (arrTimesPrice[i].arrTimes == strMonth) {
                        price = arrTimesPrice[i].arrPrice;
                        intPrice += parseInt(price);
                        monthTime = arrTimesPrice[i].arrTimes + "月";
                        break;
                    }
                    //if (arrTimesPrice[i].arrPrice != "") {
                    //    price = arrTimesPrice[i].arrPrice;
                    //    intPrice += parseInt(price);
                    //}
                    //if (arrTimesPrice[i].arrTimes != "") {
                    //    monthTime += arrTimesPrice[i].arrTimes;
                    //}
                }
                if (monthTime == "") {
                    monthTime = strMonth + "月";
                }
                xml += "<set value='" + intPrice + "'  label='" + monthTime + "' color=\"AFD8F8\" />";
            }
            // monthTime += monthTime + "月";
            //xml += "<set value='" + intPrice + "'  label='" + monthTime + "' color=\"AFD8F8\" />";
            xml += "</chart>";
            var myChart = new FusionCharts("../FusionCharts/Swf/Line.swf", "myChartId_02", '1000', "600");
            myChart.setDataXML(xml);
            myChart.render("divPieChart");

        }

        function ExportCardPriceHistory() {
            window.open('/AccountManagement/ExportHistoryRecords.ashx', "myIframe");
        }
    </script>
</body>
</html>
