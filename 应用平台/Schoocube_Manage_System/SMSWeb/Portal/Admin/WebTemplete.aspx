<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebTemplete.aspx.cs" Inherits="SMSWeb.Portal.Admin.WebTemplete" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <link href="//PortalCss/layout.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="//css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="//css/common.css" />
    <link rel="stylesheet" type="text/css" href="//css/repository.css" />
    <link rel="stylesheet" type="text/css" href="//css/onlinetest.css" />
    <title></title>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/PortalJs/layout.js"></script>
    <script src="/Scripts/Common.js"></script>
     <style>
        .layout{width:100px;float:left;border:1px solid #ccc;margin-left:10px;}
        .layout div{width:80px;height:80px;margin:10px auto 0px auto;}
        .DeepBlue{background:#2562ba;}
        .GreenBlue{background:#0296f4;}
        .layout p{line-height:30px;text-align:center;}
    </style>
</head>
<body style="background:#fff;" >
    <form id="form1" runat="server">
       <div class="crumbs" style="padding: 0; background: #fff;"><a href="">信息发布管理</a> <span>&gt;</span><a href="">网站页面模板</a></div>
        <div>
            <div class="layout">
                <div class="DeepBlue"></div>
                <p> <input  name="model" id="mode1" value="layout" type="radio"   runat="server"/>深水蓝</p>
            </div>
            <div class="layout">
                <div class="GreenBlue"></div>
                <p><input  name="model" id="mode2" value="layout_copy"  type="radio" runat="server" />淡水蓝</p>
            </div>
           <%-- <asp:Button  ID="btnSave" runat="server" Text="发布" OnClick="btnSave_Click" OnClientClick="javascript:layer.msg('发布成功！')"/>--%>
            <div class="clear"> </div>
            
                 <input type="button" id="btnSave" runat="server" class="btn" value="发布" onclick="showmsg();" onserverclick="btnSave_Click" />
        </div>
    </form>
    <script type="text/javascript">
        function showmsg() {
            layer.msg("发布成功！");

        }
    </script>
</body>
</html>
