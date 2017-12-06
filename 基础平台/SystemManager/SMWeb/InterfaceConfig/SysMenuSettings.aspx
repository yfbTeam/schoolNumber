<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SysMenuSettings.aspx.cs" Inherits="SMWeb.InterfaceConfig.SysMenuSettings" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>系统菜单设置</title>
    <link href="/css/style.css" rel="stylesheet" />
    <link href="/css/common.css" rel="stylesheet" />
    <link href="/css/iconfont.css" rel="stylesheet" />
    <link href="/css/animate.css" rel="stylesheet" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/tz_slider.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.all-3.5.min.js"></script>
    <style type="text/css">
        .ztree li a.curSelectedNode {
            height: 30px;
            line-height: 30px;
            background: #83bcd8;
            border: none;
        }

        .ztree li span.button.add { /*增加节点 按钮的样式*/
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: middle;
            *vertical-align: middle;
        }

        .ztree li span.edit.button, .ztree li span.remove.button {
            vertical-align: middle;
        }
    </style>
</head>
<body>
    <input type="hidden" id="hid_Id" runat="server" />
    <input type="hidden" id="hid_UserIDCard" runat="server" />
    <input type="hidden" id="hid_LoginName" runat="server" />
    <!--tz_dialog start-->
    <div class="yy_dialog">
        <div class="t_content">
            <div class="yy_tab">
                <div class="content">
                    <div class="tc">
                        <div class="t_message">
                            <div class="message_con">
                                <form>
                                    <div class="menubox1 left_navcon fl" style="min-height:390px;width:45%;">
                                        <!--头部-->
                                        <h1><span class="tit_name">系统信息</span></h1>
                                        <!--菜单区域-->
                                        <div class="menu">
                                            <ul>
                                                <li>
                                                    <a class="menuclick1" href="#" style="text-align:left;"><i>-</i>全部</a>
                                                    <div class="zTreeDemoBackground left">
                                                        <ul id="tree_Sys" class="ztree submenu1" style="padding: 0px;"></ul>
                                                    </div>
                                                </li>
                                            </ul>
                                        </div>
                                        <!--end 菜单区域-->
                                    </div>
                                    <div class="right_dcon fr" style="width:51%;margin-top:10px;">
                                        <div class="zTreeDemoBackground left">
                                            <ul id="tree_Menu" class="ztree"></ul>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <div class="submit_btn" style="clear:both;">
                            <span class="Save_and_submit">
                                <input type="submit" value="确定" class="Save_and_submit" onclick="SaveSysMenu();" /></span>
                            <span class="cancel">
                                <input type="submit" value="取消" class="cancel" onclick="javascript: parent.CloseIFrameWindow();" /></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--end tz_dialog-->

    <!--tz_yy start-->
    <div class="tz_yy"></div>
    <!--end tz_yy-->
</body>
<script type="text/javascript">
    //zTree配置，添加/编辑/删除按钮需要引用jquery.ztree.exedit-3.5.min.js 或 jquery.ztree.all-3.5.min.js
    var syssetting = {
        view: {
            showLine: false,
            showIcon: false,
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId"
            }
        },
        callback: {
            onClick: zTreeOnClick  //节点单击方法           
        }
    };
    var menusetting = {
        view: {
            dblClickExpand: false,
            showLine: false,
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId"
            }
        },
        check: {
            autoCheckTrigger: true,
            enable: true,
            chkStyle: "checkbox",
            chkboxType: { "Y": "ps", "N": "ps" }

        },
    };

    $(document).ready(function () {
        BindSysTreeAndInit();
    });
    //绑定系统树并且根据sysid判断是否加载权限
    function BindSysTreeAndInit() {
        $.ajax({

            url: "../Common.ashx?Trandom=" + Math.random(),
            type: "get",
            data: {
                "PageName":"InterfaceConfig/SystemHandler.ashx",
                func: "GetSystemTreeData",
                SystemKey: SystemKey,
                InfKey: InfKey,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            dataType: "JSON",
            async: false,
            cache: false,
            success: function (json) {             
                var result = json.result;
                if (result.errNum == 0 && result.retData.length > 0) {
                    var zTreeNode = $.parseJSON(result.retData);
                    var zTreeObj = $.fn.zTree.init($("#tree_Sys"), syssetting, zTreeNode); //返回树对象
                    zTreeObj.expandNode(zTreeObj.getNodeByParam("id", 0, null), true, false, false); //展开第一个顶级节点
                    var sysid = $("#<%=hid_Id.ClientID%>").val();
                    if (sysid.length) {
                        var node = zTreeObj.getNodeByParam("id", sysid, null);
                        zTreeObj.selectNode(node);
                        $("#" + node.tId).addClass("selected").siblings().removeClass("selected");
                        BindMenuTree(node.key);//绑定权限树
                    }
                } else {
                    layer.msg("您没有此权限!");
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("Ajax请求数据失败！");
            }
        });
    }
    //绑定系统树
    function BindRoleTree() {
        treeBind("tree_Sys","../Common.ashx", {
            "PageName":"InterfaceConfig/SystemHandler.ashx",
            func: "GetSystemTreeData",
            SystemKey: SystemKey,
            InfKey: InfKey,
            loginname: $("#<%=hid_LoginName.ClientID%>").val(),
            useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
        }, syssetting);
    }
    function BindMenuTree(selsyskey) {
        treeBind("tree_Menu", "../Common.ashx", {
            "PageName":"SystemSettings/MenuHandler.ashx",
            func: "GetSysMenuBySysId",
            SystemKey: SystemKey,
            InfKey: InfKey,
            selsyskey: selsyskey,
            loginname: $("#<%=hid_LoginName.ClientID%>").val(),
            useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
        }, menusetting);
    }
    //系统节点单击方法
    function zTreeOnClick(event, treeId, treeNode) {
        $("#" + treeNode.tId).addClass("selected").siblings().removeClass("selected");
        BindMenuTree(treeNode.key);
    };
    //保存系统菜单设置
    function SaveSysMenu() {
        var nodeids = getChildNodes("tree_Menu");
        if (!nodeids.length) {
            layer.msg("请选择权限!");
        }
        var treeRole = $.fn.zTree.getZTreeObj("tree_Sys");
        var selnodes = treeRole.getSelectedNodes();
        if (!selnodes.length) {
            layer.msg("请在左侧选中要设置权限的系统!");
            return;
        }
        $.ajax({
            url: "../Common.ashx?",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                "PageName": "SystemSettings/MenuHandler.ashx",
                func: "SetSystemMenu",
                SystemKey: SystemKey,
                InfKey: InfKey,
                selsyskey: selnodes[0].key,
                nodeids: nodeids,
                loginname: $("#<%=hid_LoginName.ClientID%>").val(),
                useridcard: $("#<%=hid_UserIDCard.ClientID%>").val()
            },
            success: function (json) {
                var result = json.result;
                if (result.errNum == 0) {
                    layer.msg(json.result.Msg);
                    BindMenuTree(selnodes[0].key);
                } else {
                    layer.msg(json.result.Msg);
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                layer.msg("操作失败！");
            }
        });
    }
</script>
</html>
