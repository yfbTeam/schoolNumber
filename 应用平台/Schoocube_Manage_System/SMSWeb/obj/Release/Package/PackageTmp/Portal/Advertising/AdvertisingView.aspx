<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingView.aspx.cs" Inherits="SMSWeb.Portal.Advertising.AdvertisingView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../PortalCss/layout.css" rel="stylesheet" />
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../PortalJs/layout.js"></script>
    <script src="../../Scripts/Common.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <input id="AdvType" runat="server" type="hidden" />
        <iframe name="htmlHeader" src="../header.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>
        <div class="main width clearfix mt20 mb20">
            <!--leftnav-->
            <iframe name="TreeView" src="../TreeView.html" scrolling="no" allowtransparency="true" frameborder="no" width="200px" height="570px;"></iframe>
            <div class="content fr">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail">

                    <h1 class="title" id="noticeTitle"></h1>
                    <p style="text-align: center" id="noticeImg">
                    </p>
                    <p id="Contents"></p>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="../bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        var optionList = [
            { key: 0, vals: "联系我们" },
            { key: 1, vals: "网站简介" },
            { key: 2, vals: "友情链接" },
            { key: 3, vals: "学校简介" },
            { key: 4, vals: "校长寄语" },
            { key: 6, vals: "学校历史" },
            { key: 7, vals: "招生信息" },
            { key: 8, vals: "就业分配" },
            { key: 9, vals: "教学环境" },
            { key: 10, vals: "校园文化" },
            { key: 11, vals: "鉴定培训" },
            { key: 12, vals: "职业培训" },
            { key: 13, vals: "网上报名" }
        ];

        $(function () {
            initData();
        })

        function initData() {
            if ($("#AdvType").val().length > 0) {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "Types": $("#AdvType").val(),
                        "IsDelete": 0
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var item = json.result.retData;
                            if (item != null && item.length > 0) {
                                $("#Contents").html(item[0].CreativeHTML);
                                $("#aTypeMenu").html(showAdvertType(parseInt(item[0].Type)));
                            }
                        }
                    },
                    error: OnError
                });
            }
        }
    </script>
</body>
</html>
