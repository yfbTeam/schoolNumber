<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Agreement.aspx.cs" Inherits="SMSWeb.Portal.Agreement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>用户协议</title>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link href="/PortalCss/layout.css" rel="stylesheet" id="myskin" runat="server" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/PortalJs/syslogin.js"></script>
    <script src="/PortalJs/header.js"></script>
    <style type="text/css">
        #divAgreement {
            width: 964px;
            height: auto;
            margin: 0px auto;
            color: #525252;
        }

            #divAgreement h4 {
                width: 100%;
                height: 40px;
               
                color: #333;
                font-size: 16px;
                letter-spacing: 2px;
                line-height: 40px;
                text-align: center;
            }

        .divAgreement_cont {
            padding-bottom: 8px;
            width: 934px;
            margin: 0px auto;
        }

        #divAgreement strong {
            font-size: 14px;
        }

        #divAgreement p {
            line-height: 20px;
            letter-spacing: 1.5px;
            text-indent: 2em;
            margin: 10px 0px;
            padding: 0px;
        }
    </style>
</head>
<body>
    <form id="registerform" name="registerform" class="registerform" runat="server">
        <asp:HiddenField ID="displayMenu" runat="server" />
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
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                    <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
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
            </div>
            <!--nav-->
            <div class="nav">
                <div class="nav_a width">
                    <ul class="nav_b" id="menuList"></ul>
                </div>
            </div>
        </div>
        <div class="width" style="border: 1px solid #C2C2C2; box-shadow: 0px 0px 1px #C2C2C2; border-radius: 2px; margin: 20px auto; padding-top:20px;padding-bottom: 10px; background: #fff;" id="Agreediv" runat="server">
        </div>
        <!--footer-->
        <iframe name="htmlFoot" id="htmlFoot" src="/Portal/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px" style="margin-top: 20px;"></iframe>
    </form>
    <script type="text/javascript">
        
    </script>
</body>
</html>
