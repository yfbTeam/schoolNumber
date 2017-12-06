<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CardHistory.aspx.cs" Inherits="SMSWeb.AccountManagement.CardHistory" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>充值记录</title>
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
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/AccountManagementMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script id="tr_CardHistory" type="text/x-jquery-tmpl">
        <tr>
            <td>${UserName}<input type="hidden" id="HID" value="${Id}" /></td>
            <td>${CardNo}</td>
            <td>${Price}</td>
            <td>${DateTimeConvert(PayTime)}</td>
        </tr>
    </script>
</head>
<body>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HSF" runat="server" />
        <div class="width repository_header clearfix">
            <a href="/HZ_Index.aspx" class="logo fl">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl ">
                <img src="/images/chongzhikaguanli.png" />
             </div>
            <nav class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <%--<li currentclass="active"><a href="PrepaidCardCenter.aspx" target="_blank">充值卡管理</a></li>
                    <li currentclass="active"><a href="PrepaidCardHistory.aspx" target="_blank">充值记录</a></li>--%>
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
                        <i class="icon icon-cog" style="height: 70px;"></i>
                    </a>
                    <div class="setting_none">
                       <%-- <a href="/Gopay/GoPay.aspx"><span>账户管理</span></a>--%>
                       <%--<a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>--%>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--time-->
    <div class="time_wrap pt90 width clearfix">
        <!---->
        <div class="bordshadrad" style="padding:20px;">
            <div class="stytem_select">
                <div class="stytem_select_right fl">
                    <div class="fr">
                        <span>面值：</span>
                        <%--<input type="radio" name="radioButton" value="1" checked="checked">50元
							<input type="radio" name="radioButton" value="2">100元
							<input type="radio" name="radioButton" value="3">500元--%>
                        <input type="text" value="" style="text-align: right; width: 70px"  id="searchPrice">
							<span style="margin-left: 30px;">用户：</span>
                        <input type="text" value="" style="text-align: right; width: 70px"  id="searchName">
                        <a href="javascript:;" class="add_res" onclick="getData(1,10)">
                            <i class="icon icon-plus" style="color: #fff"></i>搜索
                        </a>
                    </div>
                </div>
            </div>
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

    </div>
    <script src="/js/common.js"></script>
    <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
    <script>
        $(function () {
            //AccountMenu();
            var type = UrlDate.type;
            if (type == "1") {
                $("#AccountName").text('账户管理');
                $("img[src='/images/chongzhikaguanli.png']").attr("src", "/images/zhanghuguanli.png");
                $("#AccountMenu").append("<li currentclass=\"active\"><a href=\"/Gopay/Gopay.aspx\">充值</a></li><li currentclass=\"active\" class=\"active\"><a href=\"CardHistory.aspx?type=1\">充值记录</a></li><li currentclass=\"active\"><a href=\"PrepaidCardHistory.aspx?type=1\">消费记录</a></li><li currentclass=\"active\"><a href=\"PrepaidStatistics.aspx?type=1\">消费统计</a></li>");
            } else {
                AccountMenu();
                $("#HUserIdCard").val('');
            }

            if ($("#HSF").val() == "学生") {
                $("div[class='setting_none']").append("<a href=\"/Gopay/GoPay.aspx\"><span>账户管理</span></a><a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
            } else {
                $("div[class='setting_none']").append("<a href=\"/PersonalSpace/PersonalSpace_Teacher.aspx\" target=\"_blank\"><span>个人中心</span></a> <span onclick=\"logOut()\">退出</span>")
            }
            getData(1, 10);
        })

        function getData(startIndex, pageSize) {
            var price = "";
            var name = "";
            var IdCard = "";
            //price = $("input[type='radio'][name='radioButton']:checked").val();
            price = $("#searchPrice").val();
            name = $("#searchName").val();
            IdCard = $("#HUserIdCard").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/UserCardInfoHander.ashx", "Func": "GetPageList", "PageIndex": startIndex, "PageSize": pageSize, "UserName": name, "Price": price, "IdCard": IdCard
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
    </script>
</body>
</html>
