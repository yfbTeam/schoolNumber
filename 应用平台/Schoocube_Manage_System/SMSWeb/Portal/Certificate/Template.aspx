<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Template.aspx.cs" Inherits="SMSWeb.Portal.Certificate.Template" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>证书模板</title>
   
    <link href="//PortalCss/reset.css" rel="stylesheet" />
     <link href="//PortalCss/layout.css" rel="stylesheet" />
     
    <script src="//Scripts/jquery-1.11.2.min.js"></script>
    <script src="//PortalJs/layout.js"></script>
    <script src="//Scripts/Common.js"></script>
    <script src="//Scripts/layer/layer.js"></script>
    <script src="//Scripts/jquery.tmpl.js"></script>
    <script src="//Scripts/PageBar.js"></script>
    <script type="text/javascript" src="//js/menu_top.js"></script>
    <script src="//Scripts/jquery.cookie.js"></script>
    <script src="//PortalJs/syslogin.js"></script>
    <script src="//PortalJs/header.js"></script>
    <script id="tr_data" type="text/x-jquery-tmpl">
        <li><a href="javascript:downFile('${ImageUrl}')"><img src="${ImageUrl}" /><p>${Name}</p></a></li>
    </script>

    
</head>
<body>
    <form id="form1" runat="server">
   <asp:HiddenField ID="HMenuId" runat="server" />
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="Hid_ClassID" runat="server" />
        <input type="hidden" id="HRoleType" runat="server" />
        <input  type="hidden" id="HCertificateName" />
       <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <div class="weixin fl">
                        <span></span>
                        官方微信

                    </div>
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
                    <img src="/PortalImages/logo.png" />
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
         <div class="main width clearfix  mb20" style="margin-top:20px;">
            <!--leftnav-->
            <div class="leftnav">
                <h1>
                    <span class="school_zn" id="hTitle"></span>
                    <span class="school_zy" id="szTitle"></span>
                </h1>
                <div class="leftnav_detail" style="min-height: 480px;" id="div_leftTree">
                </div>
            </div>
            <div class="content">
                <h1 class="crumbs">您当前的位置：<a href="/Portal/index.aspx">网站首页</a> <span>&gt;</span> <a href="" id="aTypeMenu"></a>
                </h1>
                <div class="content_detail" style="padding: 10px 0px;">
                    <div>
                        <ul id="tb_data" class="certicate_lists">
                        </ul>
                    </div>
                     <!--分页-->
                </div>
            </div>
        </div>
        <style>
            .certicate_lists {width:461px;margin-left:10px;}
            .certicate_lists li{margin-top:10px;}
             .certicate_lists li a img{width:461px;height:338px;overflow:hidden;}
             .certicate_lists li a p{line-height:32px;color:#666;font-size:14px;text-align:center;}
            .search_wrap{margin:0px 10px;}
            .search_wrap input[type=text]{float: left;
                height: 26px;
                border: 1px solid #9ec5e2;
                border-radius: 2px;
                width: 278px;
                text-indent:10px;
            }
            .search_wrap input[type=button] {
                background: #1472b9;
                padding: 7px 10px;
                font-size: 14px;
                color: #fff;
                border-radius: 0px 0px 2px 2px;border:none;
            }
        </style>
        <!--footer-->
        <iframe name="htmlFoot" src="/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
    </form>
    <script type="text/javascript">
        $(document).ready(function () {
            getUserInfoCookie();
            leftTree();
            initCertificate();
            $(".leftnav_detail a").on('click', function () {
                var obj = $(this).attr("data-url");
                window.location.href = obj;
            })
        });

        function initCertificate()
        {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Certificate/Certificate.ashx",
                    Func: "GetModolList"
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        $("#tb_data").html('');
                        var items = json.result.retData;
                        if (items != null && items.length > 0) {
                            $("#tr_data").tmpl(items).appendTo("#tb_data");
                        } else {
                            $("#tb_data").html(" <li> 暂无数据！ </li>");
                        }
                    }
                    else {
                        $("#tb_data").html(" <li> 暂无数据！ </li>");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }


        function leftTree() {
            var html = "<a href=\"#\" data-url=\"/Portal/Certificate/Query.aspx?id=" + $("#HMenuId").val() + "\" >证书搜索</a>";
            html += "<a href=\"#\" data-url=\"/Portal/Certificate/Query.aspx?id=" + $("#HMenuId").val() + "&Template=true\" class=\"on\" >证书模板</a>";
            $("#div_leftTree").html(html);
            $("#aTypeMenu").html("证书搜索");
            $("#hTitle").html("证书搜索");
            $("#szTitle").html("Certificate");
        }

        function getUserInfoCookie() {
            if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                if (UserInfo != null) {
                    $("#HUserIdCard").val(UserInfo.IDCard);
                    $("#HUserName").val(UserInfo.LoginName);
                    $("#Hid_ClassID").val(UserInfo.ClassID);
                    $("#HRoleType").val(UserInfo.SF);
                }
            }
        }

        function downFile(path) {
            $.ajax({
                url: "/OnlineLearning/DownLoadHandler.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    filepath: path
                },
                success: function (json) {
                    if (json == -1) {
                        layer.msg("资源不存在！");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("资源不存在！");
                }
            });
        }
    </script>
</body>
</html>
