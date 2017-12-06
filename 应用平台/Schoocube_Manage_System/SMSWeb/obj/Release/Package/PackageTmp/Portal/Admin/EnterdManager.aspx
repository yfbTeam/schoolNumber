<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnterdManager.aspx.cs" Inherits="SMSWeb.Portal.Admin.EnterdManager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" type="text/css" href="../../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../../css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../../js/menu_top.js"></script>
    <script src="../../Scripts/My97DatePicker/WdatePicker.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}
            </td>
            <td>${Name}</td>
            <td>${CreateTime}</td>
            <td>${Phone}</td>
            <td>${Age}</td>
            <td>{{if Sex==0}}女
              {{else}}男
                {{/if}}</td>
            <td>{{if Status==0}}未审批
              {{else}}已审批
                {{/if}}
            </td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改数据', 'EnterdView.aspx?EnterdId=${Id}', '580px', '360px');"><i class="icon icon-road"></i>查看</a>
                {{if Status==0}}
                <a href="javascript:;" onclick="Operation('${Id}','',1)"><i class="icon icon-road"></i>审批通过</a>
                 {{/if}}
                <a href="javascript:;" onclick="Operation('${Id}',1,'')"><i class="icon icon-road"></i>删除</a>
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <div class="onlinetest_item ">
            <div class="course_manage bordshadrad">
                <script type="text/javascript">
                    var ptitle = getQueryString("ptitle");
                    var title = getQueryString("title");
                    document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
                </script>
                <div class="newcourse_select clearfix">
                    <div class="clearfix fl course_select">
                        <label for="">选择类型：</label>
                        <select name="" class="select" id="selType" onchange="getData(1, 10);">
                            <option value="">请选择类型</option>
                            <option value="0">未审批</option>
                            <option value="1">已审批</option>
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
                                <th>申请人姓名</th>
                                <th>申请日期</th>
                                <th>电话</th>
                                <th>年龄</th>
                                <th>性别</th>
                                <th>类型</th>
                                <th>操作</th>
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
    </form>
    <script type="text/javascript">
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
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "GetWebEnteredList",
                    Status: $("#selType").val(),
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
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
                        $("#tb_record").html("<tr><td colspan='8'>暂无申请信息！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function Operation(Id, IsDelete, Status) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "UpdateWebEnterd",
                    Status: Status,
                    IsDelete: IsDelete,
                    Id: Id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg("操作成功！");
                        query();
                    }
                    else {
                        layer.msg("操作失败！");
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
