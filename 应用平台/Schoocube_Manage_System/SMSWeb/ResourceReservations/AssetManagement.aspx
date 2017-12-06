<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AssetManagement.aspx.cs" Inherits="SMSWeb.ResourceReservations.AssetManagement" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>资产管理</title>
    <!--图标样式-->
    <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" href="/css/repository.css" />
    <link rel="stylesheet" href="/css/plan.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
        <script src="/ResourceReservationMenu.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script id="tr_AssetList" type="text/x-jquery-tmpl">
        <tr>
            <td>${Name}<input type="hidden" id="HUseStatus" value="${UseStatus}" /></td>
            <td>${AssetModel}</td>
            <td>${Number}
            </td>
            <td>${AdressName}
            </td>
            <td>${UseUnits}
            </td>
            <td>
                <span class="enable_wrap">{{if UseStatus == 0}}
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'0')" class="disable">未用</a>
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'1')">已用</a>
                    {{else}}
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'0')">未用</a>
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'1')" class="enable">已用</a>
                    {{/if}}
                </span>
            </td>


            <td>
                <a href="javascript:;" onclick="EditAsset(this,${Id},1)"><i class="icona icon-eye-open" title="查看"></i></a>
                <a href="javascript:;" onclick="EditAsset(this,${Id},2)"><i class="icona icon-edit" title="编辑"></i></a>
                <a href="javascript:;" onclick="DeleteAsset(this,${Id})"><i class="icona icon-trash" title="删除"></i></a>
            </td>
        </tr>
    </script>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
    <input type="hidden" id="HUserIdCard" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a href="/HZ_Index.aspx" class="logo fl">
                    <img src="/images/logo.png" /></a>
               <div class="wenzi_tips fl">
                   <img src="/images/shixuenshiguanli.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="ResourceMenu">
                        <%--<li currentclass="active"><a href="ResourceReservationInfo.aspx">基础数据维护</a></li>
                    <li currentclass="active"><a href="ResourceTimesManagement.aspx">时间段维护</a></li>
                    <li currentclass="active"><a href="BookingCar.aspx">资源预定</a></li>
                    <li currentclass="active" ><a href="AssetManagement.aspx">资产管理</a></li>--%>
                    </ul>
                </nav>
                <div class="search_account fr clearfix">

                    <ul class="account_area fl">
                        <li>
                            <a href="" class="dropdown-toggle">
                                <i class="icon icon-envelope" style="color:#fff;"></i>
                                <span class="badge">3</span>
                            </a>
                        </li>
                        <li>
                            <a href="" class="login_area clearfix">
                                <div class="avatar">
                                    <img src="<%=PhotoURL %>" />
                                </div>
                                <h2><%=Name %>
                                </h2>
                            </a>
                        </li>
                    </ul>
                    <div class="settings fl pr">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
                </div>
            </div>
        </header>
        <div class="time_wrap pt90 width">
            <div class="booking_wrap bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">资产管理</a>
                    </div>
                    <div class="stytem_select_right fr" style="width: auto;">
                        <a href="javascript:;" class="add_res" onclick="AddAsset()">
                            <i class="icon icon-plus" style="color: #fff;"></i>
                            <span>新增资产</span>
                        </a>
                    </div>
                </div>
                <div class="asset_manage mt10">
                    <table class="table_wrap">
                        <thead class="thead">
                            <th>资产名称</th>
                            <th>型号</th>
                            <th>数量</th>
                            <th>存放地名称</th>
                            <th>使用单位</th>
                            <th>状态</th>
                            <th>操作</th>
                        </thead>
                        <tbody class="tbody" id="tb_AssetList">
                        </tbody>
                    </table>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
            </div>
        </div>
  <%--  </form>--%>
    <script src="/js/common.js"></script>
    <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
        $(function () {
            ResourceMenu();
            getData(1, 10);
        })
        function getData(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/AssetManagementHandler.ashx", "Func": "GetPageList", "PageIndex": startIndex, "pageSize": pageSize
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_AssetList").html('');
                        $("#tr_AssetList").tmpl(json.result.retData.PagedData).appendTo("#tb_AssetList");

                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);

                    } else {
                        var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                        $("#tb_ResourceList").html(html);

                        layer.msg(json.result.errMsg);

                    }
                },
                error: OnError
            });
        }

        //获取数据失败显示无内容
        function OnError(XMLHttpRequest, textStatus, errorThrown) {
            $("#tb_AssetList tbody").html('无内容');
        }

        function AddAsset() {
            OpenIFrameWindow('新增资产', '/ResourceReservations/AssetManagementAdd.aspx', '700px', '80%');
        }

        function EditAsset(obj, id, status) {
            OpenIFrameWindow('查看资源', '/ResourceReservations/AssetManagementAdd.aspx?ID=' + id + '&type=' + status, '700px', '80%');
        }

        function DeleteAsset(obj, id) {
            if ($("#HUseStatus").val() == "1") {
                layer.msg("该资产已使用不能删除!");
                return;
            }
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: true,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/AssetManagementHandler.ashx", "Func": "DelAssetManagement",
                    "ID": id
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("删除资产数据成功");
                        getData(1, 10);
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg('删除资产数据失败！');
                }
            })
        }

        function ChangeStatus(obj, id, status) {
            if (id != null && id != "") {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/AssetManagementHandler.ashx", "Func": "ChangeStatus",
                        Id: id, Status: status
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            getData(1, 10);
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (request) {
                        layer.msg("操作失败");
                    }
                });
            }
        }

    </script>
</body>
</html>

