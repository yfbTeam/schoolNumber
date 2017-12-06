<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="VisitRate.aspx.cs" Inherits="SMSWeb.Portal.Admin.VisitRate" %>

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
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}
            </td>
            <td>${ICookie}</td>
            <td>
                {{if UserName==-1}}游客
                {{else}}${UserName}
                {{/if}}
            </td>
            <td>${IP}</td>
            <td>${Address}</td>
            <td>${CreateTime}</td>
            <td>${refer}</td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="onlinetest_item ">
            <div class="course_manage bordshadrad">
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="getData(1, 10);">
                            <option value="">请选择类型</option>
                            <option value="0">游客</option>
                            <option value="1">普通用户</option>
                        </select>
                    </div>
                    <div class="clearfix fl course_select">
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                    </div>
                </div>
                <div class="wrap">
                    <table class="PL_form">
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                 <th>电脑编号</th>
                                <th>用户名称</th>
                                <th>IP地址</th>
                                <th>所在地区</th>
                                <th>访问时间</th>
                                <th>设备</th>
                            </tr>
                        </thead>
                        <tbody id="tb_record"></tbody>
                    </table>
                </div>
            </div>
        </div>

        <div id="main"></div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>

        <div id="chartDiv"></div>
    </form>
    <script type="text/javascript">
        var FirstLoad = null;
        $(document).ready(function () {
            getData(1, 10);
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
                    Func: "GetVisitRatePageList",
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    UserName: $("#selType").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_record").html('');
                        $("#tr_record").tmpl(json.result.retData.PagedData).appendTo("#tb_record");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_record").html("<tr><td colspan='8'>暂无系统通知！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }



        function query() {
            getData(1, 10);

        }
    </script>
</body>
</html>
