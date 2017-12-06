<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PageSpecial.aspx.cs" Inherits="SMSWeb.Portal.Admin.PageSpecial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        .layout{width:198px;float:left;border:1px solid #ccc;margin-left:10px;}
        .layout img{width:198px;}
        .layout p{line-height:30px;text-align:center;}
    </style>
</head>
<body style="background:#fff;">
    <form id="form1" runat="server">
       <div class="crumbs" style="padding: 0; background: #fff;"><a href="">信息发布管理</a> <span>&gt;</span><a href="">个性化环境</a></div>
        <div>
            <div class="layout">
                <img src="/PortalImages/left.jpg" />
                <p>
                <input  name="model" id="mode1" value="left" type="radio"   runat="server"/>布局一</p>
            </div>
            <div class="layout">
                <img src="/PortalImages/right.jpg" />
                <p><input  name="model" id="mode2" value="right"  type="radio" runat="server" />布局二</p>
            </div>
            
            <div class="clear"> </div>
                 <input type="button" id="btnSave" runat="server" class="btn" value="发布"  onserverclick="btnSave_Click"  onclick="showmsg();" />
           
        </div>
    </form>
    <script type="text/javascript">
        function showmsg()
        {
            layer.msg("发布成功！");
            
        }
    </script>
</body>
</html>
