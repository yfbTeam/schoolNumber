<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdvertisingImgView.aspx.cs" Inherits="SMSWeb.Portal.Advertising.AdvertisingImgView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <input id="AdvType" runat="server" type="hidden" />
        <iframe name="htmlHeader" src="/header.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="480px"></iframe>
        <div class="main width clearfix mt20 mb20">
            <!--leftnav-->
            <iframe name="TreeView" src="/TreeView.html" scrolling="no" allowtransparency="true" frameborder="no" width="200px" height="570px;"></iframe>
            <div class="content">
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
        <iframe name="htmlFoot" src="/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script>
        $(function () {
            initData();
        })

        function initData()
        {

        }

    </script>
</body>
</html>
