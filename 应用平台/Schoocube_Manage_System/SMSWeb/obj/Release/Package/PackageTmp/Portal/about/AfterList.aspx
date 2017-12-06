<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AfterList.aspx.cs" Inherits="SMSWeb.Portal.about.AfterList" %>

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
    <script id="item_news" type="text/x-jquery-tmpl">
        <li>
            <b></b><a onclick="javascript:OpenIFrameWindow('新增数据', 'AfterListEdit.aspx?id=${MenuId}&advId=${Id}', '700px', '500px');">${NameLengthUpdate(Description,30)}</a><span>${DateTimeConvert(CreateTime,'yyyy-MM--dd')}</span>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HMenuId" runat="server" />
        <div class=" clearfix mt20 mb20" style="padding: 0px  20px;">
            <script type="text/javascript">
                var ptitle = getQueryString("ptitle");
                var title = getQueryString("title");
                document.write("<div class=\"crumbs\" style=\"padding: 0; background: #fff;\"><a href=\"\">" + ptitle + "</a> <span>&gt;</span><a href=\"\">" + title + "</a></div>");
            </script>
            <!--leftnav-->
            <div class="newcourse_select clearfix">
                <div class="distributed fr">
                    <a href="javascript:void(0);" onclick="javascript:RedirectUrl() "><i class="icon icon-plus"></i>添加</a>
                </div>
            </div>
            <div>
                <div class="content_detail">
                    <ul class="news_lists" id="newsList">
                    </ul>
                </div>
            </div>
        </div>
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
                    PageName: "PortalManage/AdvertisingHandler.ashx",
                    Func: "GetPageList",
                    //type: $("#selType").val(),
                    MenuId: $("#HMenuId").val(),
                    PageIndex: startIndex,
                    pageSize: pageSize
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#newsList").html('');
                        $("#item_news").tmpl(json.result.retData.PagedData).appendTo("#newsList");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);
                    }
                    else {
                        $("#newsList").html("<tr><td colspan='2'>暂无数据！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }

        function DeleteAdvert(delid) {
            layer.msg("确定要删除该通知?", {
                time: 0 //不自动关闭
               , btn: ['确定', '取消']
               , yes: function (index) {
                   layer.close(index);
                   $.ajax({
                       url: "/Common.ashx",
                       type: "post",
                       async: false,
                       dataType: "json",
                       data: { PageName: "PortalManage/AdvertisingHandler.ashx", Func: "UpdateAdvertising", Id: delid, IsDelete: 1 },
                       success: function (json) {
                           if (json.result.errNum.toString() == "0") {
                               layer.msg("删除成功");
                               getData(1, 10);
                           }
                           else { layer.msg('删除失败！'); }
                       },
                       error: function (errMsg) {
                           layer.msg('删除失败！');
                       }
                   });
               }
            });
        }

        function RedirectUrl() {
            OpenIFrameWindow('新增数据', 'AfterListEdit.aspx?id=' + $("#HMenuId").val(), '700px', '500px');
        }
    </script>
</body>
</html>
