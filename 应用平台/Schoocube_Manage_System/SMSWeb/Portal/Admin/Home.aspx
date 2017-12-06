<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SMSWeb.Portal.Admin.Home" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="//PortalCss/reset.css" rel="stylesheet" />
    <style>
        .header_top{padding:20px;}
        .header_top div{width:33.3%;float:left;font-size:14px;}
        .main_content{border:1px solid #EBEBEB;padding:20px;}
        .main_content div{width:33.3%;float:left;}
        .title{font-size:16px;line-height:30px;}
        .main_content div p{line-height:20px;font-size:14px;}
        .article_content{margin-top:20px;}
        .article_content .article_left{width:37%;}
        .article_content .article_right{width:60%;margin-top:10px;border:1px solid #EBEBEB;padding:20px;}
        .article_right p{line-height:25px;color:#035DBC;font-size:14px;}
        .app_list {width:100%;}
        .app_list li{margin:10px;float:left;}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding:20px;">
            <div class="header_top clearfix">
                <div>
                    本次登录IP:<asp:Label ID="CurrentIP" runat="server"></asp:Label>
                </div>
               <%-- <div>
                    上次登录IP:<asp:Label ID="PreIP" runat="server"></asp:Label>
                </div>--%>
                <div>
                    当前登录时间<asp:Label ID="PreDate" runat="server"></asp:Label>
                </div>
            </div>
            <div class="main_content clearfix">
                <h1 class="title">站点信息</h1>
                <div>
                    <p>站点名称：<asp:Label ID="siteName" runat="server" Text="SMSWeb"></asp:Label></p>
                    <p>安装目录：<asp:Label ID="installPath" runat="server"></asp:Label></p>
                    <p>服务器名称：<asp:Label ID="serviceName" runat="server"></asp:Label></p>
                    <p>操作系统：<asp:Label ID="SystemWindow" runat="server"></asp:Label></p>
                    <p>目录物理路径：<asp:Label ID="SystemPath" runat="server"></asp:Label></p>
                </div>
                <div>
                    <p>公司名称：<asp:Label ID="companyName" runat="server" Text="北京圣邦天麒科技有限公司"></asp:Label></p>
                    <p>网站管理目录：<asp:Label runat="server" ID="webPath"></asp:Label></p>
                    <p>服务器IP：<asp:Label runat="server" ID="ServiceIP" value="192.168.1.122"></asp:Label></p>
                    <p>IIS版本：<asp:Label runat="server" ID="IISConfig"></asp:Label></p>
                 <%--   <p>系统版本：<asp:Label runat="server" ID="SysVersion"></asp:Label></p>--%>
                </div>
                <div>
                    <p>网站域名：<asp:Label runat="server" ID="WebDNS"></asp:Label></p>
                    <p>附件上传目录：<asp:Label runat="server" ID="FileUploadPath"></asp:Label></p>
                    <p>NET框架版本：<asp:Label runat="server" ID="NetFramework"></asp:Label></p>
                    <p>服务器端口：<asp:Label runat="server" ID="ServiceHost"></asp:Label></p>
                  <%--  <p>系统内存：<asp:Label runat="server" ID="SystemMemory"></asp:Label></p>--%>
                </div>
            </div>
            <div class="article_content">
                <div class="article_left fl">
                    <ul class="app_list p10 clearfix" id="Menu">
                        <li>
                            <a href="/Portal/SysSetting/Setting.aspx" class="bgblue" >
                                <img src="//PortalImages/system.png" />
                            </a>
                        </li> 
                        <%--<li>
                            <a href="/Portal/Message/MessageManager.aspx" class="bgblue" >
                                <img src="//PortalImages/system1.png" />
                            </a>
                        </li> --%>
                        <li>
                            <a href="/Portal/TimingBackup/DataBackUp.aspx" class="bgblue" >
                                <img src="//PortalImages/beifen.png" />
                            </a>
                        </li> 
                        <li>
                            <a href="/Portal/Notice/NoticeManager.aspx" class="bgblue" >
                                <img src="//PortalImages/notice.png" />
                            </a>
                        </li> 
                        <%--<li>
                            <a href="/Portal/Admin/VisitRate.aspx" class="bgblue" >
                                <img src="//PortalImages/fangwen.png" />
                            </a>
                        </li>--%> 
                    </ul>
                </div>
                <div class="article_right fr">
                    <h1 class="title">建站三步曲</h1>
                    <p>1.进入后台管理中心，点击"系统参数管理"修改网站配置信息；</p>
                    <p>2.点击"菜单管理"，建立系统菜单配置路径；</p>
                    <p>2.制作好网站模板，上传到站点Portal目录下，即可完成。</p>
                    <h1 class="title">官方消息</h1>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
