<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SMSWeb.Portal.Admin.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>北京仪器仪表高级技工学校-管理后台</title>
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <link type="text/css" rel="stylesheet" href="../../PortalCss/common.css" />
    <link type="text/css" rel="stylesheet" href="../../PortalCss/style.css" />
    <link type="text/css" rel="stylesheet" href="../../PortalCss/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="../../PortalCss/animate.css" />


    <link href="../../Scripts/jscrollpane/style/jquery.jscrollpane.css" rel="stylesheet" />
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="../../Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../Scripts/jquery.cookie.js"></script>
    <script src="../../Scripts/Common.js"></script>
    <script type="text/javascript">
        $(function () {

            function reSize() {
                $('.box .left').height($(window).height() - 60 + 'px');
                $('.box .right,#iframbox').height($(window).height() - 60 + 'px');
            }
            reSize();
            $(window).resize(function () {
                reSize();
            })
            
        })
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="LoginName" />
        <div class="wrap">
            <!--头部-->
            <div class="top ms-dialogHidden">
                <div class="topcon">
                    <div class="top_left fl">
                        <div class="logo fl">
                           <a href="/Portal/admin/index.aspx"><img src="../../PortalImages/logoBefore.png" style="margin-top:0;"/></a> 
                        </div>
                       
                    </div>
                     <div class="top_right fr">
                           <div class="login fl"><a href="/Portal/index.aspx" target="_blank" >返回前台</a></div>
                            <div class="rightcontent fl">
                              
                                <div class="login fl" style="position:relative;cursor:pointer;">
                                    
                                    <a href="#"><span id="sp_LoginName" name="sp_LoginName" runat="server"></span><b class="jiantou" style="font-weight:bold;font-size:12px;">▼</b></a>  
                                    <div class="login_none" style="position:absolute;top:100%;right:10px;width:90px;border-bottom:0;border:1px solid #ccc;background:#fff;z-index:999;display:none;">
           
                                        <a href="#" onclick="sysloginOut()" style="line-height:30px;text-align:center;display:block;width:100%;height:30px;color:#666;">退出</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                </div>
            </div>
            <script>
                $(function () {
                    $('.login').hover(function () {
                        $(this).find('.jiantou').addClass('active');
                        $(this).find('.login_none').stop().slideDown();
                    }, function () {
                        $(this).find('.jiantou').removeClass('active');
                        $(this).find('.login_none').stop().slideUp();
                    })
                    $('.login_none>span,.login_none>a').hover(function () {
                        $(this).css({ 'background': '#65ce67', 'color': '#fff' });
                    }, function () {
                        $(this).css({ 'background': '#fff', 'color': '#666' });
                    })
                })

                   </script> 
            <!--头部结束-->
            <div class="clear"></div>
            <div class="center">
                <!--内容区域-->
                <div class="box">
                    <!--左边-->
                    <div class="left" id="sliderbox" style="height: 918px;">
                        <div class="menubox">
                            <div class="aside" style="display: block;"></div>
                            <!--菜单区域-->
                            <div class="menu" id="menubox">
                                <ul id="ul_leftmenu"></ul>
                            </div>
                            <!--end 菜单区域-->
                        </div>
                    </div>
                    <!--右边-->
                    <div class="right" style="height: 918px;">
                        <iframe id="iframbox" src="/Portal/Admin/Home.aspx" width="100%" frameborder="0" height="100%" style="height: 918px;"></iframe>
                    </div>
                </div>
            </div>
            <div class="clear"></div>

        </div>
        <script type="text/javascript">
            function loading() {

                var silderBox = document.getElementById("sliderbox");//dom对象
                var adoms = silderBox.getElementsByTagName("a");//这是一个集合对象HTMLCollection对象
                //document.getElementsByClassName document.querySelectorAll(".items");
                var len = adoms.length;
                while (len--) {
                    adoms[len].onclick = function () {
                        var src = this.getAttribute("data-src");

                        //$(".submenu li").each(function(){
                        //$(this).removeClass("selected");
                        // });

                        $(this).parent().addClass("selected").siblings().removeClass("selected");
                        if (src != null) {
                            document.getElementById("iframbox").src = src;
                        }
                    }
                };
            };
            window.onload = loading;
            $(document).ready(function () {
                //绑定左侧导航
                getUserInfoCookie();
                BindLeftNavigationMenu();
                loading();
                
            });
            //绑定左侧导航
            function BindLeftNavigationMenu() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdminManager.ashx",
                        "func": "GetLeftNavigationMenu",
                        "BeforeAfter": "1",
                        "Display": 0,
                        "IsDelete": 0,
                        "isParam": true,
                        "Creator": $("#LoginName").val()
                    },
                    success: function (data) {
                        if (data.result != null) {
                            $("#ul_leftmenu").html(data.result.retData);   //绑定菜单

                            $("#menubox").find(".menuclick").click(function () {
                                $(this).parent().toggleClass("selected").siblings().removeClass("selected").find('span').toggleClass('active');
                                $(this).find('span').toggleClass('active');
                                $("#menubox").find('span').not($(this).find('span')).removeClass('active');
                                $(this).next().stop(true, true).slideToggle("fast").end().parent().siblings().find(".submenu")
                                .addClass("animated flipInX").stop(true, true)
                                .slideUp("fast").end();
                            });

                        }
                    },
                    error: function (textStatus) {
                        layer.msg("获取导航出现问题了,请通知管理员!");
                    }
                });
            }


            function getUserInfoCookie() {
                if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                    var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                    if (UserInfo != null) {
                        $("#sp_LoginName").html(UserInfo.Name);
                        $("#LoginName").val(UserInfo.LoginName);
                    }
                }
            }

            function sysloginOut() {
                $.cookie('LoginCookie_Cube', null);
                window.location = "/Portal/index.aspx";
            }
        </script>
    </form>
</body>
</html>
