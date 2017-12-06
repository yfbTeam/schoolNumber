<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PrepaidCardCenter.aspx.cs" Inherits="SMSWeb.AccountManagement.PrepaidCardCenter" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>充值卡管理</title>
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
    <%--<script src="/CourseMenu.js"></script>--%>
    <script src="/AccountManagementMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script id="tr_CardList" type="text/x-jquery-tmpl">
        <tr>
            <td><input type="hidden" id="HID" value="${Id}" />${CardNo}</td>
            <td>${Pwd}</td>
            <td>${Price}</td>
            <td>{{if CardStatus==0}}未激活{{/if}}
                {{if CardStatus==1}}已激活{{/if}}
            </td>
            <td>
                <span class="enable_wrap">{{if UseStatus==0}}<a href="javascript:;" class="enable" onclick="javascript:ChangeStatus(this,${Id},'0')">启用</a>
                    <a href="javascript:;" onclick="javascript:ChangeStatus(this,${Id},'1')">禁用</a>
                    {{else}}	
                    <a href="javascript:;" onclick="javascript:ChangeStatus(this,${Id},'0')">启用</a>
                    <a class="disable" href="javascript:;" onclick="javascript:ChangeStatus(this,${Id},'1')">禁用</a>{{/if}}
                </span>
            </td>
            <td>
                <%--<a href="javascript:;" onclick="ViewBookCar(${Id})"><i class="icon icon-eye-open"></i></a>
                <a href="javascript:;" onclick="EditBookCar(this,${Id},${ApprovalStutus})"><i class="icon">
                    <img src="/images/shenpi.png" alt="" /></i></a>--%>
                {{if CardStatus==0}}
                <a href="javascript:;" onclick="ChangeCardStatus(this,${Id})"><i class="icona" title="激活"><img src="/images/注册激活.png" /></i></a>
                {{else}}
                <a href="javascript:;" ><i class="icona" title="已激活" style="cursor:default"><img src="/images/注册激活.png" /></i></a>
                {{/if}}
                <a href="javascript:;" onclick="DelCardInfo(this,${Id})"><i class="icona icon-trash" title="删除"></i></a>
            </td>
        </tr>
    </script>
</head>
<body>
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <div class="width repository_header clearfix">
            <a href="/HZ_Index.aspx" class="logo fl">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl ">
                <img src="/images/chongzhikaguanli.png" />
             </div>
            <nav class="navbar menu_mid fl">
                <ul id="AccountMenu">
                    <%--<li currentclass="active"><a href="PrepaidCardCenter.aspx">充值卡管理</a></li>
                    <li currentclass="active"><a href="CardHistory.aspx" >充值记录</a></li>--%>
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
                        <%--<a href="/Gopay/GoPay.aspx"><span>账户管理</span></a>--%>
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                            <span onclick="logOut()">退出</span>
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
                        <span>面值:</span>
                        <input type="radio" name="radioButton" value="1" checked="checked">50元
							<input type="radio" name="radioButton" value="2">100元
							<input type="radio" name="radioButton" value="3">500元
							<span style="margin-left: 30px;">个数</span>
                        <input type="text" value="100" style="text-align: right; width: 70px" maxlength="7" id="number">
                        <a href="javascript:;" class="add_res" onclick="CreatPrepaidCar()">
                            <i class="icon icon-plus" style="color: #fff"></i>生成
                        </a>
                    </div>
                </div>
            </div>
            <div class="time_base">
                <table class="table_wrap mt10">
                    <thead class="thead">
                        <th>序列号</th>
                        <th>密码</th>
                        <th>面值</th>
                        <th>激活状态</th>
                        <th>卡状态</th>
                        <th>操作</th>
                    </thead>
                    <tbody class="tbody" id="tb_CardList">
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
            AccountMenu();
            getData(1, 10);
        })

        function getData(startIndex, pageSize) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "GetPageList", "PageIndex": startIndex, "PageSize": pageSize
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
                $("#tb_CardList").html('');
                $("#tr_CardList").tmpl(json.result.retData.PagedData).appendTo("#tb_CardList");
                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

            } else {
                var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                $("#tb_CardList").html(html);

            }
        }

        function CreatPrepaidCar() {
            var num = "";//个数
            var price = "";//面值
            var headNum = 0;//卡号前4位
            var pwd = 0;//密码
            var cardPwd = 0;
            var cardInfo = [];//卡信息
            num = $("#number").val();
            if (num == "") {
                layer.msg("请输入生成充值卡的数量！");
                return;
            }
            price = $("input[type='radio'][name='radioButton']:checked").val();
            if (price == "1") {
                price = "50";
            } else if (price == "2") {
                price = "100";
            } else {
                price = "500";
            }
           
            for (var n = 0; n < num; n++) {
                headNum = "";
                pwd = "";
                var random = "";
                headNum = parseInt(Math.random() * (1000 - 10000) + 10000);
                pwd = parseInt(Math.random() * (100000 - 1000000) + 1000000);
                var data = formatDate(new Date());
                var cardNo = headNum + data;

                var obj = new Object();
                obj.CardNo = cardNo;
                obj.Pwd = pwd;
                obj.Price = price;
                cardInfo.push(obj);
            }

            var jsonCardInfo = JSON.stringify(cardInfo);
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/PrepaidCardCenterHander.ashx",
                    Func: "AddCard", "JsonCardInfo": jsonCardInfo, "UserName": $("#HUserName").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == "0") {
                        getData(1, 10);

                    } else {
                        layer.msg("生成失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });


        }
        function formatDate(date) {
            var year = date.getFullYear();
            var month = (date.getMonth() + 1);
            var day = date.getDate();
            var hours = date.getHours();
            var minutes = date.getMinutes();
            var seconds = date.getSeconds();
            month = month < 10 ? "0" + month : month;
            day = day < 10 ? "0" + day : day;
            hours = hours < 10 ? "0" + hours : hours;
            minutes = minutes < 10 ? "0" + minutes : minutes;
            seconds = seconds < 10 ? "0" + seconds : seconds;
            return year + month + day + hours + minutes + seconds;
        }

        function DelCardInfo(obj, id) {
            layer.msg("确定要删除么?", {
                time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "AccountManagement/PrepaidCardCenterHander.ashx",
                    Func: "DelCard", "Id": id, "UserName": $("#HUserName").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == "0") {
                        layer.msg("删除成功！");
                        getData(1, 10);

                    } else {
                        layer.msg("删除失败！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
           }
            });
        }

        function ChangeStatus(obj, id, status) {
            var UserName = $("#HUserName").val();
            if (id != null && id != "") {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "ChangeStatus",
                        Id: id, Status: status, "UserName": UserName
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            getData(1, 10);
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (request) {
                        layer.msg("操作失败");
                    }
                });
            }
        }
        
        function ChangeCardStatus(obj, id) {
            var UserName = $("#HUserName").val();
            var IdCard = $("#HUserIdCard").val();
            if (id != null && id != "") {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "AccountManagement/PrepaidCardCenterHander.ashx", "Func": "ChangeCardStatus",
                        Id: id, "UserName": UserName, "IdCard": IdCard
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            getData(1, 10);
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (request) {
                        layer.msg("操作失败");
                    }
                });
            }
        }
    </script>
</body>
</html>

