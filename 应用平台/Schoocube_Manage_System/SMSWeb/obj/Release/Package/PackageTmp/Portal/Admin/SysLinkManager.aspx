<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysLinkManager.aspx.cs" Inherits="SMSWeb.Portal.Admin.SysLinkManager" %>

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
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../PortalJs/layout.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script src="../../Scripts/jquery.tmpl.js"></script>
    <script src="../../Scripts/PageBar.js"></script>
    <script src="../../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script id="tr_Link" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>${Title}</td>
            <td>
                <img src="${ImageUrl}" alt="" class="imgShow" /></td>
            <td>${SortId}</td>
            <td>${Href}</td>
            <td>${DateTimeConvert(CreateTime)}</td>
            <td>
                <a href="javascript:;" onclick="javascript: OpenIFrameWindow('修改数据', 'SysLinkEdit.aspx?Id=${Id}', '580px', '360px');"><i class="icon icon-edit"></i>修改</a>
                <a href="javascript:;" onclick="DelLink('${Id}')"><i class="icon icon-road"></i>删除</a>
            </td>
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
                        <label for="">选择日期：</label>
                        <input type="text" class="Wdate" id="StarDate" onfocus="WdatePicker({maxDate:'#F{$dp.$D(\'EndDate\',{d:-1});}'})" />
                        <input type="text" class="Wdate" id="EndDate" onfocus="WdatePicker({minDate:'#F{$dp.$D(\'StarDate\',{d:0});}'})" />

                    </div>
                    <div class="distributed fr">
                        <a href="javascript:void(0);" onclick="javascript: OpenIFrameWindow('新增数据', 'SysLinkEdit.aspx', '580px', '360px');"><i class="icon icon-plus"></i>添加</a>
                        <a href="javascript:void(0);" onclick="query()"><i class="icon icon-plus"></i>查询</a>
                    </div>
                </div>
                <div class="wrap">
                    <table>
                        <thead>
                            <tr>
                                <th class="number">序号</th>
                                <th>标题</th>
                                <th>图片信息</th>
                                <th>排序</th>
                                <th>链接地址</th>
                                <th>创建时间</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Link"></tbody>
                    </table>
                </div>
            </div>
        </div>
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
                    Func: "GetLinkList",
                    StarDate: $("#StarDate").val(),
                    EndDate: $("#EndDate").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_Link").html('');
                        $("#tr_Link").tmpl(json.result.retData.PagedData).appendTo("#tb_Link");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#tb_Link").html("<tr><td colspan='8'>暂无信息！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DelLink(Id) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/AdminManager.ashx",
                    Func: "UpdateLink",
                    IsDelete: 1,
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
