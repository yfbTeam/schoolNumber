<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TreeView.aspx.cs" Inherits="SMSWeb.Portal.Admin.TreeView" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../PortalCss/reset.css" rel="stylesheet" />
    <link href="../../Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle;
        }
    </style>
    <script src="../../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../../Scripts/layer/layer.js"></script>
    <script src="../../Scripts/Common.js"></script>

    <script src="../../Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="../../Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="../../Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript">
        var zNodes = [];
        var setting = {
            view: {
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
                selectedMulti: false
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn
            },
            data: {
                keep: {
                    parent: true,
                    leaf: true
                },
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeDrag: beforeDrag,
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
                beforeRename: beforeRename,
                onRemove: onRemove,
                onRename: onRename,
                beforeClick: beforeClick,
                onClick: onClick
            }

        };
        var log, className = "dark";
        function beforeDrag(treeId, treeNodes) {
            return false;
        }
        function beforeEditName(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.selectNode(treeNode);
            return confirm("进入节点 -- " + treeNode.name + " 的编辑状态吗？");
        }
        function beforeRemove(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.selectNode(treeNode);
            return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        }
        function onRemove(e, treeId, treeNode) {
            ////删除//
            delData(treeNode.id, 1);
            /////
            showLog("[ " + getTime() + " onRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
        }
        function beforeRename(treeId, treeNode, newName, isCancel) {
            className = (className === "dark" ? "" : "dark");
            showLog((isCancel ? "<span style='color:red'>" : "") + "[ " + getTime() + " beforeRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>" : ""));
            if (newName.length == 0) {
                alert("节点名称不能为空.");
                var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
                setTimeout(function () { zTree.editName(treeNode) }, 10);
                return false;
            }
            //新增代码//
            renTreeData(treeNode.id, newName);
            ////
            return true;
        }
        function onRename(e, treeId, treeNode, isCancel) {
            showLog((isCancel ? "<span style='color:red'>" : "") + "[ " + getTime() + " onRename ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name + (isCancel ? "</span>" : ""));
        }
        function showRemoveBtn(treeId, treeNode) {
            //return !treeNode.isFirstNode;
            return true;
        }
        function showRenameBtn(treeId, treeNode) {
            //return !treeNode.isLastNode;
            return true;
        }
        function showLog(str) {
            if (!log) log = $("#log");
            log.append("<li class='" + className + "'>" + str + "</li>");
            if (log.children("li").length > 8) {
                log.get(0).removeChild(log.children("li")[0]);
            }
        }
        function getTime() {
            var now = new Date(),
			h = now.getHours(),
			m = now.getMinutes(),
			s = now.getSeconds(),
			ms = now.getMilliseconds();
            return (h + ":" + m + ":" + s + " " + ms);
        }

        var newCount = 1;

        function add(e) {
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce"),
			isParent = e.data.isParent,
			nodes = zTree.getSelectedNodes(),
			treeNode = nodes[0];
            if (treeNode) {
                treeNode = zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, isParent: isParent, name: "new node" + (newCount++) });
            } else {
                treeNode = zTree.addNodes(null, { id: (100 + newCount), pId: 0, isParent: isParent, name: "new node" + (newCount++) });
            }
            if (treeNode) {
                zTree.editName(treeNode[0]);
                //新增节点/
                EditTree("new node" + newCount, "", 0);
                ////
            } else {
                alert("叶子节点被锁定，无法增加子节点");
            }
        };

        function addHoverDom(treeId, treeNode) {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_" + treeNode.tId);
            if (btn) btn.bind("click", function () {
                var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
                zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, name: "new node" + (newCount++) });
                ///添加到数据库中/
                EditTree("new node" + newCount, "", treeNode.id);
                ///
                return false;
            });
        };
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_" + treeNode.tId).unbind().remove();
        };
        function selectAll() {
            var zTree = $.fn.zTree.getZTreeObj("treeRerouce");
            zTree.setting.edit.editNameSelectAll = $("#selectAll").attr("checked");
        }

        function beforeClick(treeId, treeNode, clickFlag) {

        }
        function onClick(event, treeId, treeNode, clickFlag) {
            getTreeData(treeNode.id);
        }

        $(document).ready(function () {
            BindNavigationMenu();
            $("#addParent").bind("click", { isParent: true }, add);
        });

        function BindNavigationMenu() {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "GetNavigationMenu",
                    "IsDelete": 0
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var dtJson = $.parseJSON(json.result.retData);
                        var items = dtJson.data;
                        if (items != null) {
                            for (var i = 0; i < items.length; i++) {
                                var node = new Object();
                                node.id = items[i].Id;
                                node.pId = items[i].PId;
                                node.name = items[i].Name;
                                if (items[i].PId == 0) node.open = true;
                                zNodes.push(node);
                            }
                            BindTree();
                        }
                    }
                },
                error: function (textStatus) {
                    layer.msg("获取导航出现问题了,请通知管理员!");
                }
            });
        }

        function BindTree() {
            $.fn.zTree.init($("#treeRerouce"), setting, zNodes);
            $("#selectAll").bind("click", selectAll);
        }

        function EditTree(Name, id, pid) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "EditPortalTreeData",
                    "Name": Name,
                    "EnName": "",
                    "Display": 0,
                    "BeforeAfter": 1,
                    "Id": id,
                    "PId": pid,
                    "SortId": 0,
                    "Creator": $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }


        function getTreeData(id) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "GetPortalTreeData",
                    "Id": id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var item = json.result.retData;
                        if (item != null) {
                            $("#Name").val(item.Name);
                            $('input[name=Display][value=' + item.Display + ']').prop('checked', true);
                            $('input[name=BeforeAfter][value=' + item.BeforeAfter + ']').prop('checked', true);

                            $("#BeforeUrl").val(item.BeforeUrl);
                            $("#AfterUrl").val(item.AfterUrl);
                            $("#TreeId").val(item.Id);
                            $("#HPId").val(item.PId);
                            $("#SortId").val(item.SortId);
                        }
                    }
                },
                error: OnError
            });
        }

        function renTreeData(id, name) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "UpdatePortalTreeData",
                    "Name": name,
                    "Id": id
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function saveData() {
            if (!validate()) {
                return false;
            }
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "EditPortalTreeData",
                    "Name": $("#Name").val(),
                    "EnName": $("#EnName").val(),
                    "Display": $("input[name='Display']:checked").val(),
                    "BeforeAfter": $("input[name='BeforeAfter']:checked").val(),
                    "BeforeUrl": $("#BeforeUrl").val(),
                    "AfterUrl": $("#AfterUrl").val(),
                    "Id": $("#TreeId").val(),
                    "PId": $("#HPId").val(),
                    "SortId": $("#SortId").val(),
                    "Creator": $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        layer.msg('操作成功!');
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function delData(id, IsDelete) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/AdminManager.ashx",
                    "func": "UpdatePortalTreeData",
                    "Id": id,
                    "IsDelete": IsDelete
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        zNodes = [];
                        BindNavigationMenu();
                        $("input[type=reset]").trigger("click");
                    }
                },
                error: OnError
            });
        }

        function validate() {
            if ($("#HPId").val() == "" || $("#HPId").val().length == 0) {
                layer.msg("请选择节点信息！");
                return false;
            }
            if ($("#Name").val() == "" || $("#Name").val().length == 0) {
                layer.msg("请填写节点信息！");
                return false;
            }
            return true;
        }
    </script>
    <style>
        .ztreea {
            padding: 20px;
        }

        .ztree {
            border: 1px solid #ccc;
            border-top: none;
        }

        .ztreea_left {
            width: 20%;
            float: left;
        }

            .ztreea_left h1 {
                background: #37A8E0;
                color: #fff;
                font-size: 16px;
                line-height: 34px;
                padding-left: 10px;
                font-weight: normal;
            }

        .ztreea_right {
            border: 1px solid #ccc;
            width: 76%;
            padding: 20px;
        }

        #addParent {
            width: 80px;
            height: 35px;
            background: #37A8E0;
            display: block;
            border-radius: 2px;
            text-align: center;
            color: #fff;
            font-size: 14px;
            line-height: 35px;
        }

        .course_form_div {
            margin: 10px 0px;
            height: 30px;
        }

            .course_form_div label {
                width: 75px;
                text-align: right;
                line-height: 30px;
                display: inline-block;
            }

            .course_form_div input[type=text] {
                width: 240px;
                height: 26px;
                border: none;
                border: 1px solid #ccc;
                border-radius: 2px;
                text-indent: 10px;
            }

            .course_form_div input[type=radio] {
                width: 15px;
                height: 15px;
                margin: 0px 10px;
            }

            .course_form_div .stars {
                color: red;
                margin-left: 10px;
            }

        .course_form_select {
            margin-left: 100px;
        }

            .course_form_select a {
                display: inline-block;
                width: 80px;
                height: 30px;
                background: #0488C9;
                border-radius: 2px;
                font-size: 14px;
                color: #fff;
                margin-top: 30px;
                cursor: pointer;
                text-align: center;
                line-height: 30px;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
         <div class="onlinetest_item">
            <div class="course_manage bordshadrad">
        <input id="HPId" type="hidden" />
        <input id="TreeId" type="hidden" />
        <asp:HiddenField ID="HUserName" runat="server" />
        <div class="crumbs" style="padding: 0; background: #fff;">
            <a href="">系统配置管理</a>
            <span>&gt;</span>
            <a href="">菜单管理</a>
        </div>
        <div class="ztreea">
            <div class="ztreea_left">
                <h1>菜单管理</h1>
                <ul id="treeRerouce" class="ztree"></ul>
            </div>
            <div class="fr ztreea_right">
                <a id="addParent" href="javascript:;" title="增加父节点" onclick="return false;">增加父节点</a>
                <div style="background: #fff; margin-top: 20px;">
                    <div class="newcourse_dialog_detail">
                        <div class="clearfix ">
                            <div class="course_form_div clearfix">
                                <label for="">节点名称：</label>
                                <input type="text" placeholder="节点名称" class="text" id="Name" value="" />
                                <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">英文名称：</label>
                                <input type="text" placeholder="英文名称" class="text" id="EnName" value="" />
                                <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">是否显示：</label>
                                <input type="radio" name="Display" value="0" checked />是<input type="radio" name="Display" value="1" />否
                        <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">展示位置：</label>
                                <input type="radio" name="BeforeAfter" value="0" checked />前台<input type="radio" name="BeforeAfter" value="1" />后台<input type="radio" name="BeforeAfter" value="2" />全部
                        <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">排序：</label>
                                <input type="text" placeholder="排序" class="text" id="SortId" value="" />
                                <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">前端路径：</label>
                                <input type="text" placeholder="前端路径" class="text" id="BeforeUrl" value="" />
                                <i class="stars">*</i>
                            </div>
                            <div class="course_form_div clearfix">
                                <label for="">后端路径：</label>
                                <input type="text" placeholder="后端路径" class="text" id="AfterUrl" value="" />
                                <i class="stars">*</i>
                            </div>
                            <div style="clear: both"></div>
                            <div class="course_form_select clearfix">
                                <a href="javscript:;" class="course_btn confirm_btn" onclick="saveData()" id="btnOk">确定</a>
                                <input type="reset" name="reset" style="display: none;" />
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

                </div>
             </div>
    </form>
</body>
</html>
