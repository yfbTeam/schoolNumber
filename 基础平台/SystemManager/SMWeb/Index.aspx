<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="SMWeb.Index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>基础平台建设系统</title>
    <link type="text/css" rel="stylesheet" href="css/common.css" />
    <link type="text/css" rel="stylesheet" href="css/style.css" />
    <link type="text/css" rel="stylesheet" href="css/iconfont.css" />
    <link type="text/css" rel="stylesheet" href="css/animate.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
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
            $("#SystemName").html($("#hid_SystemName").val());
            $("#sp_LoginName").html($("#hid_UserName").val());
            //绑定左侧导航
            BindLeftNavigationMenu();
        });
        //绑定左侧导航
        function BindLeftNavigationMenu() {
            $.ajax({
                url: "Common.ashx",
                //type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "SystemSettings/MenuHandler.ashx",
                    func: "GetLeftNavigationMenu",
                    SystemKey: SystemKey,
                    InfKey: InfKey,
                    loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                    useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
                },
                success: function (json) {
                    var result = json.result;
                    if (result.errNum == 0) {
                        if (result.retData.length > 0) {
                            BindMenu($.parseJSON(result.retData), $("#ul_leftmenu"));
                            $("#menubox").find(".menuclick").click(function () {
                                $(this).parent().toggleClass("selected").siblings().removeClass("selected");
                                $(this).next().slideToggle("fast").end().parent().siblings().find(".submenu")
                                .addClass("animated flipInX")
                                .slideUp("fast").end().find("i").text("+");
                                var t = $(this).find("i").text();
                                $(this).find("i").text((t == "+" ? "-" : "+"));
                            });
                        }
                    } else {
                        layer.msg(result.errMsg);
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });
        }
        function BindMenu(menu_list, parent) { //menu_list为json数据 ,parent为要组合成html的容器              
            for (var menu in menu_list) {
                var curMenu = menu_list[menu];
                var licontent = curMenu.pid == "0" ? "<a class='menuclick' href='#'><i>+</i>" + curMenu.name + "</a>" : "<a href='javascript:void(0);' data-src='" + curMenu.url + "'>" + curMenu.name + "</a>";
                if (curMenu.children.length > 0) { //如果有子节点，则遍历该子节点  
                    var li = $("<li></li>");  //创建一个子节点li
                    //将li的文本设置好，并马上添加一个空白的ul子节点，并且将这个li添加到父亲节点中
                    $(li).append(licontent).append("<ul class='submenu' style='display:none;'></ul>").appendTo(parent);
                    BindMenu(curMenu.children, $(li).children().eq(1));  //将空白的ul作为下一个递归遍历的父亲节点传入
                }
                else {  //如果该节点没有子节点，则直接将该节点li以及文本创建好直接添加到父亲节点中
                    $("<li></li>").append(licontent).appendTo(parent);
                }
            }
        }
        function logout() {
            layer.msg("确定注销？", {
                time: 0 //不自动关闭
                , btn: ['确定', '取消']
                , yes: function () {
                    location.href = "Index.aspx?action=loginOut";
                }
            });
        }
    </script>
    <script type="text/javascript" src="js/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/tz_slider.js"></script>

</head>
<body>
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <input type="hidden" id="hid_SystemName" runat="server" />
    <input type="hidden" id="hid_UserName" runat="server" />
    <div class="wrap">
        <!--头部-->
        <div class="top ms-dialogHidden">
            <div class="topcon">
                <div class="top_con">
                    <div class="top_left fl">
                        <div class="logo fl">
                            <!--<img src="images/logo.png"/>-->
                            <!--基础平台建设系统-->
                            <span id="SystemName"></span>
                        </div>
                    </div>
                    <div class="top_right fr">
                        <!--search-->
                        <!--<div class="search fl">
				      <div class="sear">
				    	 <img src="/wpresources/zssc/images/search.png" class="img" />
			             <input type="text" class="search_bg" name="search_bg" value="请输入关键字" onclick="if(this.value=='请输入关键字'){this.value=''}"onblur="if(this.value==''){this.value='请输入关键字'}"  />
	              	   </div>
                  </div>  -->
                        <!--photo email-->
                        <div class="rightcontent fl">
                            <div class="login fl">
                                <a href="#"><%--<em>
                                <img src="images/photo.jpg" /></em>--%><em><span id="sp_LoginName" name="sp_LoginName" runat="server"></span></em></a>
                                <a href="javascript:;" onclick="logout()" style="padding: 5px 8px; background: #ffd800;">退出</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--头部结束-->
        <div class="clear"></div>
        <div class="center">
            <!--内容区域-->
            <div class="box">
                <!--左边-->
                <div class="left" id="sliderbox">
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
                <div class="right">
                    <iframe id="iframbox" src="Teacher/TeacherManager.aspx" width="100%" frameborder="0" height="100%"></iframe>
                </div>
            </div>
        </div>
        <div class="clear"></div>
    </div>
</body>

</html>
