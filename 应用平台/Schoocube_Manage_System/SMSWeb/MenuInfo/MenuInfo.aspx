<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MenuInfo.aspx.cs" Inherits="SMSWeb.MenuInfo.MenuInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="JS/jquery-1.11.2.min.js"></script>
    <script src="JS/jquery.tmpl.js"></script>
    <link href="CSS/animate.css" rel="stylesheet" />
    <link href="CSS/common.css" rel="stylesheet" />
    <link href="CSS/iconfont.css" rel="stylesheet" />
    <link href="CSS/style.css" rel="stylesheet" />
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="Teaching_plan_management">
            <h1 class="Page_name" id="h1_title">功能菜单管理</h1>
            <div class="menubox1 left_navcon fl">
                <!--头部-->
                 <h1><span class="tit_name">父节点</span><span class="fr btn"><a href="#" onclick="BorrowDetails()">新增父节点</a></span></h1>
                <!--菜单区域-->
                <div class="menu">
                    <ul>
                        <li>
                            <ul class="submenu1" id="ul_building"></ul>
                        </li>
                    </ul>
                </div>
                <!--end 菜单区域-->
            </div>
            <div class="right_dcon fr">
                <div class="tit_top">
                    <p>
                        <span class="left_tit fl">子节点</span>

                    </p>
                </div>
                <div class="clear"></div>
                <div class="S_conditions">
                    <div id="div_layerroom" class="screenBox screenBackground"></div>
                </div>
                <div class="clear"></div>
                <!--展示区域-->
                <div class="Display_form">
                    <div class="Resources_tab">
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
<script type="text/javascript">
    $(document).ready(function () {

        BindBuilding();
    });

    //绑定父节点
    function BindBuilding() {
        $.ajax({
            url: "MenuInfo.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { action: "BindBuilding" },
            success: function (json) {
                if (json.result != null) {
                    $("#ul_building").html(json.result);   //绑定菜单
                    GetLayersAndRoomsById(json.id);
                  
                }
            },
            error: function () {
                alert("获取失败！");
            }
        });
    }

    function BuildLiClick(obj) {
        $(obj).addClass("selected_build").siblings().removeClass("selected_build");
        GetLayersAndRoomsById(obj.id.replace('buildli_', ''));
    }


    ///绑定子节点
    function GetLayersAndRoomsById(id) {
        $.ajax({
            url: "MenuInfo.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: { id: id, action: "Get_id_MenuInfo" },
            success: function (json) {
                var data = decodeURIComponent(json.result);
                $("#div_layerroom").html(data);
                $(".screenBox dl dd label").hover(function () {
                    $(this).find(".del").show().end().siblings();
                }, function () {
                    $(this).find(".del").hide();
                })
            },
            error: function (textStatus) {
                alert("获取子节点出现问题!");
            }
        });
    }

    function BorrowDetails() {
        OpenIFrameWindow('新增父节点', 'FMenuInfoEdit.aspx', '400px', '200px');
      
    }


</script>



</html>
