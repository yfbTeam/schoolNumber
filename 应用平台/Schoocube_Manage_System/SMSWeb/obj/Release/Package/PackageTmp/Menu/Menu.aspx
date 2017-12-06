<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Menu.aspx.cs" Inherits="SMSWeb.Menu.Menu" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <link href="CSS/style.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="JS/jquery.tmpl.js"></script>
    <script src="../Scripts/Common.js"></script>


    <style>
        .meuu_edit {
            border-bottom: 2px solid #99C7E5;
            padding-left: 10px;
        }

            .meuu_edit span {
                font-size: 14px;
                color: #2086C9;
                line-height: 50px;
            }

        .app_list {
            margin-left: -24px;
        }

            .app_list li {
                width: 110px;
                height: 110px;
                margin-top: 10px;
                margin-left: 24px;
                margin-bottom: 10px;
                float: left;
            }

                .app_list li a {
                    display: block;
                    width: 110px;
                    height: 110px;
                    position: relative;
                }

                    .app_list li a i {
                        width: 50px;
                        height: 50px;
                        display: block;
                        position: absolute;
                        top: 20px;
                        left: 50%;
                        margin-left: -25px;
                    }

        .app_name {
            width: 100%;
            height: 30px;
            line-height: 30px;
            color: #fff;
            font-size: 14px;
            text-align: center;
            bottom: 0;
            position: absolute;
        }
       .ul_items li{ height: 34px;
        border-bottom: 1px solid #e4e4e4;
        padding: 0px 10px;
        font-size: 14px;
        color: #666666;
        line-height: 34px;
        padding-left: 20px;cursor:pointer;}
       .ul_items li.selected_build{border-bottom: 1px dotted #e4e4e4;
        background: #fff;
        border-left: 2px solid #1cc2ea;
        margin-left: -1px;}
    </style>

    <script id="list" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}</td>
            <td>${MenuCode}</td>
            <td>${Url}
            </td>
            <td>
                <input type="button" class="Topic_btn" value="编辑" onclick="javascript: AddZMenuEdit('${Id}', '${Name}', '${Url}', '${MenuCode}');" />
                <input type="button" class="Topic_btn" value="删除" onclick="javascript: deleteMenu('${Id}', '${Pid}');" />
            </td>
        </tr>
    </script>


</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="hid_Pid" value="" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>

                <nav class="navbar menu_mid fl">
                    <ul id="ResourceMenu">
                    </ul>
                </nav>
                <div class="search_account fr clearfix">
                    <ul class="account_area fl">
                        <li>
                            <a href="" class="dropdown-toggle">
                                <i class="icon icon-envelope" style="color: #fff;"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="" class="login_area clearfix">
                                <%--<div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name%>
                            </h2>--%>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr">
                        <a href="javascript:;">
                            <i class="icon icon-cog"></i>
                        </a>
                        <div class="setting_none">
                            <span onclick="logOut()">退出</span>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="time_wrap pt90 width clearfix">
            <div class="menu fl" style="min-height: 400px; background: #F0F7FB;">
                <!--头部-->
                <div class="detail_items_title">
                    父节点
					<div class="fr add" onclick="BorrowDetails()">新增父节点</div>
                </div>
                <!--菜单区域-->
                <%--<div class="menu">
                    <ul>
                        <li>
                           
                        </li>
                    </ul>
                </div>--%>
               <ul class="submenu1 ul_items" id="ul_building"></ul>
                <!--end 菜单区域-->
            </div>
            <!---->
            <div class="onlinetest_right fr bordshadrad">
                <div class="meuu_edit clearfix">
                    <span class="fl">一级导航</span>

                </div>
                <div class="">
                    <ul class="app_list  clearfix" id="Menu">
                    </ul>
                </div>
                <div class="meuu_edit clearfix">
                    <span class="fl">二级导航</span>
                    <div class="distributed fr">
                        <a href="#" onclick="AddZMenuEdit(0, '', '', '')">添加二级导航</a>
                    </div>
                </div>
                <div class="time_base">

                    <table class="table_wrap mt10">
                        <thead class="thead">
                            <tr class="trth">
                                <th>名称</th>
                                <th>样式</th>
                                <th>地址</th>
                                <th>操作</th>
                            </tr>
                        </thead>
                        <tbody class="tbody" id="tbody">
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            BindBuilding();
        });

        //绑定父节点
        function BindBuilding() {
            $.ajax({
                url: "Menu.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { action: "BindBuilding", id: 0 },
                success: function (json) {
                    if (json.result != null) {
                        $("#ul_building").html(json.result);   //绑定菜单
                        GetLeftNavigationMenu(json.id);
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
            GetLeftNavigationMenu(obj.id.replace('buildli_', ''));
            GetLayersAndRoomsById(obj.id.replace('buildli_', ''));
        }

        ///绑定图片
        function GetLeftNavigationMenu(id) {
            $.ajax({
                url: "Menu.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { action: "Get_Pid_MenuInfo", id: id, Pid: 0 },//  <a href="#" onclick="AddZMenuEdit(0, '', '', '')">添加二级导航</a>
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#Menu").html('');
                        $(json.result.retData).each(function () {
                            var li = " <li style='height:140px;'><a href=\"javascript:;\" onclick=\"MenuEdit(" + this.Id + ",'" + this.Name + "')\" class=\"bgblue\"><i><img src=\"../" + this.MenuCode + "\" /></i><p class=\"app_name\">" +
                                this.Name + "</p></a> <div class=\"change_picture\"> </div></li>";
                            $("#Menu").append(li);

                        });
                    }
                },
                error: function (errMsg) {
                    //  layer.msg('操作失败！');
                    alert("操作失败")
                }
            });
        }


        ///绑定子节点
        function GetLayersAndRoomsById(Pid) {
            $("#hid_Pid").val(Pid);
            $.ajax({
                url: "Menu.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {  id: Pid, action: "Get_id_MenuInfo" },
                success: function (json) {
                    $("#tbody").html('');
                    var list = $("#tbody");
                    var data = json.result.retData;
                    $("#list").tmpl(data).appendTo(list);
                },
                error: function (textStatus) {
                    alert("获取子节点出现问题!");
                }
            });
        }

        function BorrowDetails() {
            OpenIFrameWindow('新增父节点', 'MenuEdit.aspx?id=0&Name=""', '600px', '400px');

        }

        function MenuEdit(id,Name) {
            OpenIFrameWindow('编辑父节点', 'MenuEdit.aspx?id='+id+'&Name='+Name+'', '600px', '400px');

        }


        function AddZMenuEdit(id, Name, Url, MenuCode) {
            var Pid = $("#hid_Pid").val();
            OpenIFrameWindow('新增子节点', 'ZMenuEdit.aspx?id=' + id + '&Name=' + Name + '&Pid=' + Pid + '&Url=' + Url + '&MenuCode=' + MenuCode + '', '600px', '300px');
        }

        ///删除子节点
        function deleteMenu(id, pid) {
            layer.msg("确定要删除该子节点吗?", {
                time: 0 //不自动关闭
                , btn: ['确定', '取消']
                , yes: function (index) {
                    layer.close(index);
                    $.ajax({
                        url: " Menu.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: { "id": id, "action": "DeleteMenu" },
                        success: function (json) {
                            if (json.result == "OK") {
                                parent.layer.msg('删除成功!');
                                GetLayersAndRoomsById(pid);

                            } else {
                                layer.msg("删除失败！");
                            }
                        },
                        error: function (textStatus) {
                            layer.msg("删除失败！");
                        }
                    });
                }
            });

        }

    </script>
</body>
</html>

