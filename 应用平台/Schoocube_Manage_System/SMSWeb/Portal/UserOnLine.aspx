<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserOnLine.aspx.cs" Inherits="SMSWeb.Portal.UserOnLine" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    
    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <link href="/PortalCss/layout.css" rel="stylesheet" />
  
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
     <script src="//Scripts/jquery.cookie.js"></script>
    <script type="text/javascript" src="//js/menu_top.js"></script>
     <script src="//PortalJs/syslogin.js"></script>
     <script src="//Scripts/layer/layer.js"></script>
    <script src="//PortalJs/header.js"></script>
    <script id="tr_online" type="text/x-jquery-tmpl">
         <li style="height:auto;" class="clearfix">
             <div class="fl" style="text-align:center;">
             <img  src="${Photo}" style="height:50px;width:50px;"/> 
                 <p>${UserName}</p>
                 
             </div>
             <div class="fl" style="margin-left:35%;line-height:75px;">
                 ${IP}
             </div>
             <span style="line-height:75px;">${DateTimeConvert(CreateDate,'yyyy-MM-dd HH:mm:ss')}</span>
        </li>
    </script>
</head>
<body>
    <form id="form1" runat="server">
         <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <a href="#htmlFoot" name="#htmlFoot">
                        <div class="weixin fl" style="color: #fff">
                            <span></span>
                            官方微信

                        </div>
                    </a>
                    <a href="/Portal/Certificate/Query.aspx" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <div id="header">
            <!--logo-->
            <div class="logo_search width clearfix">
                <div class="logo fl">
                    <a href="/Portal/index.aspx">
                        <img src="/PortalImages/logo.png" /></a>
                </div>
                <!--<div class="search fr">
                <input type="text" placeholder="请输入关键词" />
                <input type="submit" value="搜索" />
            </div>-->
            </div>
            <!--nav-->
            <div class="nav">
                <div class="nav_a width">
                    <ul class="nav_b" id="menuList"></ul>
                </div>
            </div>
        </div>
        <div class="main width clearfix  mb20" style="margin-top: 20px;">
            <!--leftnav-->
            <div class="content" style="width:1200px;">
                <div class="content_detail">
                    <ul class="news_lists" id="onlineList">
                    </ul>
                    <div class="page mt10">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" id="htmlFoot" src="bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>

    </form>
    <script type="text/javascript">
        $(function () {
            initData();
        })

        function initData()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MonitorRecordHandler.ashx",
                    Func: "GetUserOnLineList"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var dtJson = json.result.retData;
                        if (dtJson != null) {
                            $("#onlineList").html('');
                            $("#tr_online").tmpl(dtJson).appendTo("#onlineList");
                        }
                    } else {
                        $("#onlineList").html("系统异常！");
                    }
                },
                error: function (errMsg) {

                }
            });
        }
    </script>
</body>
</html>
