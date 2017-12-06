<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Pay_Index.aspx.cs" Inherits="SMSWeb.ziaxianzhifu.Pay_Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>账户管理</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
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
    <style>
        .teacher_left {
            padding: 15px 20px;
            width: 353px;
            background: #fff;
            height: 152px;
        }

        .account_balance {
            padding: 15px 20px;
            background: #fff;
            width: 743px;
            height: 152px;
        }

        .teacher_names .personal_img {
            width: 146px;
            height: 146px;
            border: 2px solid #bac2c8;
            border-bottom: none;
            margin: 0 auto;
            overflow: hidden;
        }

        .teacher_names .personal_a {
            height: 4px;
            background: #1776bd;
            border-radius: 2px;
            width: 170px;
        }

        .teacher_left .personal_detail {
            width: 163px;
        }

            .teacher_left .personal_detail .people {
                text-align: left;
            }

            .teacher_left .personal_detail .school, .teacher_left .personal_detail .subject {
                line-height: 25px;
            }

        .account_balance {
            font-size: 18px;
            color: #555;
        }

        .account_balancea {
            text-align: center;
            width: 320px;
            margin: 50px auto;
        }

            .account_balancea span {
                display: block;
                float: left;
                font-size: 16px;
                color: #666666;
                height: 30px;
                margin-top: 6px;
            }

                .account_balancea span i {
                    font-size: 30px;
                    color: #ff5b00;
                    display: inline-block;
                    margin-left: 10px;
                }

            .account_balancea a {
                width: 96px;
                height: 36px;
                display: block;
                text-align: center;
                line-height: 36px;
                float: left;
                color: #fff;
                background: #0074bd;
                font-size: 16px;
                border: none;
                border-radius: 2px;
                margin-left: 35px;
            }

        .lastsale {
            margin-top: 20px;
        }

            .lastsale h1 {
                color: #555;
                font-size: 18px;
                padding: 0px 20px;
                border-bottom: 1px solid #DCDCDC;
                height: 45px;
                line-height: 45px;
                position: relative;
            }

        .sale_wrap {
            display: inline-block;
            position: absolute;
            top: 12px;
            left: 110px;
        }

            .sale_wrap span {
                cursor: pointer;
                display: block;
                float: left;
                width: 80px;
                height: 22px;
                border-right: 1px solid #ccc;
                text-align: center;
                font-size: 16px;
                color: #0074bd;
                line-height: 22px;
            }

                .sale_wrap span:last-child {
                    border: none;
                }

        .sale_record {
            padding: 10px 20px;
        }
    </style>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/AccountManagementMenu.js"></script>
    <script id="tr_CardHistory" type="text/x-jquery-tmpl">
        <tr>
            <td>${UserName}<input type="hidden" id="HID" value="${Id}" /></td>
            <td>${CardNo}</td>
            <td>${Price}</td>
            <td>${DateTimeConvert(PayTime)}</td>
        </tr>
    </script>
    <script id="tr_PayHistory" type="text/x-jquery-tmpl">
        <tr>
            <td>${CreateName}<input type="hidden" id="HID" value="${Id}" /></td>
            <td>${DateTimeConvert(ConsumingTime)}</td>
            <td>${ConsumptionPrice}</td>
        </tr>
    </script>
</head>
<body style="background: #fff;">
    <form id="form1" runat="server">
        <div>
            <input type="hidden" id="HSF" runat="server" />
            <input type="hidden" id="HUserIdCard" runat="server" />
            <input type="hidden" id="HUserName" runat="server" />
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a href="/HZ_Index.aspx" class="logo fl">
                        <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl ">
                        <img src="/images/zhanghuguanli.png" />
                    </div>
                    <nav class="navbar menu_mid fl">
                        <ul>
                            <li currentclass="active" class="active"><a href="/GoPay/Pay_Index.aspx">我的账户</a></li>
                            <li currentclass="active"><a href="/GoPay/GoPay.aspx">充值</a></li>
                            <li currentclass="active"><a href="/AccountManagement/PrepaidStatistics.aspx?type=1">消费统计</a></li>
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
                                    <h2><%=Name %>
                                    </h2>
                                </a>
                            </li>
                        </ul>
                        <div class="settings fl pr ">
                            <a href="javascript:;">
                                <i class="icon icon-cog"></i>
                            </a>
                            <div class="setting_none">
                                <%--<a href="/Gopay/GoPay.aspx"><span>账户管理</span></a>
                            <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>--%>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <div class="onlinetest_item width pt90 clearfix">
                <div class="teacher_left fl bordshadrad clearfix">
                    <div class="teacher_names fl">
                        <div class="personal_img">
                            <img src="<%=PhotoURL %>" />
                        </div>
                        <div class="personal_a"></div>
                    </div>
                    <div class="personal_detail fr">
                        <p class="people"><i class="icon icon-user"></i><%=Name %></p>
                        <p class="school">所在学校：<span>北京仪器仪表高级技工学校</span></p>
                    </div>
                </div>
                <div class="account_balance fr bordshadrad">
                    <h1>账户余额</h1>
                    <div class="account_balancea clearfix">
                        <span id="accountBalance"></span>
                        <a href="/GoPay/GoPay.aspx">立即充值</a>
                    </div>
                </div>
                <div class="clear"></div>
                <div class="clearfix lastsale bordshadrad">
                    <h1>最近交易
                        <div class="sale_wrap">
                            <span>充值记录</span><span>消费记录</span>
                        </div>
                    </h1>
                    <div class="sale_record">
                        <div>

                            <div class="time_base">
                                <table class="table_wrap mt10">
                                    <thead class="thead">
                                        <th>用户</th>
                                        <th>卡号</th>
                                        <th>面值</th>
                                        <th>充值时间</th>
                                    </thead>
                                    <tbody class="tbody" id="tb_CardHistory">
                                    </tbody>
                                </table>
                            </div>
                            <!--分页-->
                            <div class="page">
                                <span id="pageBar"></span>
                            </div>
                        </div>
                        <div class="none">
                            <div class="wrap">
                                <table class="table_wrap mt10">
                                    <thead class="thead">
                                        <th>名称</th>
                                        <th>消费日期</th>
                                        <th>消费金额</th>
                                    </thead>
                                    <tbody class="tbody" id="tb_PayHistory" style="width: 80%">
                                    </tbody>
                                </table>
                            </div>
                            <!--分页-->
                            <div class="page">
                                <span id="pageBar1"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <script src="/js/common.js"></script>
            <script>
                $(function () {
                    $('.sale_wrap span').click(function () {
                        var n = $(this).index();
                        $('.sale_record>div').eq(n).show().siblings().hide();
                    })
                    if ($("#HSF").val() == "学生") {
                        $("div[class='setting_none']").append("<a href=\"/Gopay/GoPay.aspx\"><span>账户管理</span></a><a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
                    } else {
                        $("div[class='setting_none']").append("<a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
                    }
                    GetAccountBalance();
                    getData(1, 10);
                    getData1(1, 10);
                })

                function getData(startIndex, pageSize) {
                    IdCard = $("#HUserIdCard").val();
                    $.ajax({
                        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "AccountManagement/UserCardInfoHander.ashx", "Func": "GetPageList", "PageIndex": startIndex, "PageSize": pageSize, "IdCard": $("#HUserIdCard").val()
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
                        $("#tb_CardHistory").html('');
                        $("#tr_CardHistory").tmpl(json.result.retData.PagedData).appendTo("#tb_CardHistory");
                        $(".page").show();
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

                    } else {
                        $(".page").hide();
                        var html = '<tr><td colspan="100"><div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#tb_CardHistory").html(html);

                    }
                }
                function getData1(startIndex, pageSize) {
                    $.ajax({
                        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            "PageName": "AccountManagement/CardPriceHistoryHander.ashx", "Func": "GetPageList", "PageIndex": startIndex, "PageSize": pageSize, "IdCard": $("#HUserIdCard").val()
                        },
                        success: OnSuccess1,
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            layer.msg("操作失败！");
                        }
                    });
                }

                //获取数据成功显示列表
                function OnSuccess1(json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_PayHistory").html('');
                        $("#tr_PayHistory").tmpl(json.result.retData.PagedData).appendTo("#tb_PayHistory");
                        makePageBar(getData1, document.getElementById("pageBar1"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

                    } else {
                        var html = '<tr><td colspan="100"><div style="background:#fff url(/images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                        $("#tb_PayHistory").html(html);

                    }
                }

                function GetAccountBalance() {
                    var idCard = "";
                    idCard = $("#HUserIdCard").val();
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "AccountManagement/AccountInfoHandler.ashx", Func: "GetPageList",
                            "IdCard": idCard, "Ispage": false
                        },
                        success: function (json) {
                            if (json.result.errNum.toString() == "0") {
                                $(json.result.retData).each(function (i, n) {
                                    $("span[id=accountBalance]").append("账户余额<i>" + n.Balance + "</i>元");
                                });

                            }
                            else {
                                $("span[id=accountBalance]").append("账户余额<i>0.00</i>元");
                            }
                        },
                        error: function (errMsg) {
                            $("span[id=accountBalance]").append("账户余额<i>0.00</i>元");
                        }
                    });
                }
            </script>
        </div>
    </form>
</body>
</html>
