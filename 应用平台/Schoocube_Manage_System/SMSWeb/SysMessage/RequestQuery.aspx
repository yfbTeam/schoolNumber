<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RequestQuery.aspx.cs" Inherits="SMSWeb.SysMessage.RequestQuery" %>

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
    <script id="tr_record" type="text/x-jquery-tmpl">
        <tr>
            <td>${pageIndex()}</td>
            <td>{{if Creator==-1}}游客
                 {{else}}${Creator}
                 {{/if}}
            </td>
            <td>{{if RequestUserType==0}}内部学员
                 {{else}}外部学员
                  {{/if}}
            </td>
            <td>${Counts}
            </td>
        </tr>
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="HCourseId" runat="server" />
        <asp:HiddenField ID="HDate" runat="server" />
        <div class="wrap">
            <table class="PL_form">
                <thead>
                    <tr>
                        <th class="number">序号</th>
                        <th>学员</th>
                        <th>学员类型</th>
                        <th>观看次数</th>
                    </tr>
                </thead>
                <tbody id="tb_record">
                </tbody>
            </table>
        </div>
        <!--分页-->
        <div class="page">
            <span id="pageBar"></span>
        </div>
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
                    Func: "GetLookPersonPageList",
                    Id: $("#HCourseId").val(),
                    Date: $("#HDate").val(),
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
                        $("#tb_record").html("<tr><td colspan='8'>暂无记录！</td></tr>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
