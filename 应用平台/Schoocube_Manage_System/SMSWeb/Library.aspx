<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Library.aspx.cs" Inherits="SMSWeb.Library" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="stylesheet" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" href="/css/repository.css" />
    <link rel="stylesheet" href="/css/plan.css" />
    <link href="/Scripts/zTree/css/zTreeStyle/zTreeStyle.css" rel="stylesheet" />

    <link href="/PortalCss/reset.css" rel="stylesheet" />
    <style type="text/css">
        .ztree li span.button.add {
            margin-left: 2px;
            margin-right: -1px;
            background-position: -144px 0;
            vertical-align: top;
            *vertical-align: middle;
        }
    </style>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.core-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.excheck-3.5.js"></script>
    <script src="/Scripts/zTree/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/x-jquery-tmpl" id="Answer_tr">
        <tr>
            <td>${Question}</td>
            <td>${cutstr(Answer,80)}</td>
            <td>${CreateTime}</td>
            <td>
                <a href="javascript:;" onclick="EditQuestion(${ID})" title="修改">修改</a>
            </td>
        </tr>
    </script>
    <style>
        .ztreea {
            padding-top: 15px;
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
            width: 75%;
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

        .add_res:hover {
            color: #fff;
        }
    </style>
</head>
<body>
    <%--<input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />--%>
    <input type="hidden" id="ID" />

    <!--time-->
    <div class="time_wrap width clearfix">
        <!---->
        <div class=" bordshadrad" style="background: #FFF; padding: 20px;">

            <div class="time_base">
                <div class="ztreea clearfix">
                    <div class="ztreea_left">
                        <h1>分类信息</h1>
                        <ul id="treeEnter" class="ztree"></ul>
                    </div>
                    <div class="fr ztreea_right">
                        <div class="stytem_select">
                            <div class="stytem_select_right fl">
                                <div class="search_exam fl pr">
                                    <i class="icon  icon-search" onclick="BindData(1,10)"></i>

                                    <input type="text" placeholder="请输入关键词" class="text" id="Question" />
                                </div>
                                <div class="fr">
                                    <a href="javascript:;" class="add_res" onclick="AddQuestion('');">
                                        <i class="icon icon-plus"></i>新建知识库
                                    </a>
                                </div>
                            </div>
                        </div>
                        <div style="background: #fff; margin-top: 10px;">
                            <div class="newcourse_dialog_detail">
                                <table class="table_wrap mt10">
                                    <thead class="thead">
                                        <th>问题</th>
                                        <th>答案</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </thead>
                                    <tbody class="tbody" id="Answer_td">
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="page">
                            <div id="pageBar"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/js/common.js"></script>
    <script>
        $(function () {
            $('.tbody tr td.Post').find('.Postname').hover(function () {
                $(this).find('.more_info').show();
            }, function () {
                $(this).find('.more_info').hide();
            })
        })
    </script>
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
        function beforeClick(treeId, treeNode, clickFlag) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeClick ]&nbsp;&nbsp;" + treeNode.name);
            return (treeNode.click != false);
        }
        function showRemoveBtn(treeId, treeNode) {
            return true;
        }
        function showRenameBtn(treeId, treeNode) {
            return true;
        }
        function beforeDrag(treeId, treeNodes) {
            return false;
        }
        function beforeEditName(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeEditName ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeEnter");
            zTree.selectNode(treeNode);
        }
        function beforeRemove(treeId, treeNode) {
            className = (className === "dark" ? "" : "dark");
            showLog("[ " + getTime() + " beforeRemove ]&nbsp;&nbsp;&nbsp;&nbsp; " + treeNode.name);
            var zTree = $.fn.zTree.getZTreeObj("treeEnter");
            zTree.selectNode(treeNode);
            return confirm("确认删除 节点 -- " + treeNode.name + " 吗？");
        }

        function beforeRename(treeId, treeNode, newName, isCancel) {

            var newname = newName.trim();
            if (treeNode.id == "" && !newname.length) {
                var zTree = $.fn.zTree.getZTreeObj("treeEnter");
                zTree.removeNode(treeNode);
            }
            return newname.length > 0;
        }

        //编辑节点
        function onRename(event, treeId, treeNode, isCancel) {
            EditTree(treeNode.name, treeNode.id.toString(), '');
        }
        var newCount = 1;

        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_" + treeNode.tId).unbind().remove();
        };
        function onRemove(e, treeId, treeNode) {
            DelMenu(treeNode.id);
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
            s = now.getSeconds();
            return (h + ":" + m + ":" + s);
        }
        function addHoverDom(treeId, treeNode) {
            var sObj = $("#" + treeNode.tId + "_span");
            if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
            var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
				+ "' title='add node' onfocus='this.blur();'></span>";
            sObj.after(addStr);
            var btn = $("#addBtn_" + treeNode.tId);
            if (btn) btn.bind("click", function () {
                var zTree = $.fn.zTree.getZTreeObj("treeEnter");
                // var newNodes =
                zTree.addNodes(treeNode, { id: (100 + newCount), pId: treeNode.id, name: "new node" + (newCount++) });
                // zTree.editName(newNodes[0]);
                ///添加到数据库中/
                EditTree("new node" + newCount, "", treeNode.id);
                return false;
            });
        };

        //删除导航
        function DelMenu(MenuID) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "Library/Library.ashx", "func": "DelMenu", "MenuID": MenuID,
                },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        GetNave();
                    }
                },
                error: function (errMsg) { }
            });
        }
        function EditTree(Name, id, pid) {
            $.ajax({
                type: "Post",
                url: "/Common.ashx",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "Library/Library.ashx",
                    "func": "AddMenu",
                    "MenuName": Name,
                    "ID": id,
                    "PID": pid
                },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        GetNave();
                    }
                },
                error: function (errMsg) { }
            });
        }

        $(function () {
            GetNave();
            BindData(1, 10);
        })
        //导航绑定
        function GetNave() {
            $.ajax({
                type: "post",
                url: "/Common.ashx",
                data: { "PageName": "/Library/Library.ashx", Func: "BindNav" },
                dataType: "text",
                success: function (returnVal) {

                    var dtJson = $.parseJSON(returnVal);
                    $.fn.zTree.init($("#treeEnter"), setting, dtJson);
                    var treeObj = $.fn.zTree.getZTreeObj("treeEnter");
                    treeObj.expandAll(true);
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }
        function treeClick() {
            this.close();
        }
        //导航点击事件
        function onClick(event, treeId, treeNode, clickFlag) {
            var ID = treeNode.id;
            var Pid = treeNode.pId;
            $("#ID").val(ID);
            BindData(1, 10);
        }
        //右侧数据绑定
        function AddQuestion(ID) {
            OpenIFrameWindow('添加知识库', 'LibraryAdd.aspx?MenuId=' + ID, '700px', '510px');
        }
        function EditQuestion(ID) {
            OpenIFrameWindow('修改知识库', 'LibraryAdd.aspx?MenuId=' + ID, '700px', '510px');
        }
        function BindData(PageIndex, pageSize) {
            $.ajax({
                type: "post",
                url: "/Common.ashx",
                data: { "PageName": "/Library/Library.ashx", Func: "GetLibrary", PageIndex: PageIndex, pageSize: pageSize, "Key": $("#Question").val() },
                dataType: "json",
                success: function (json) {

                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();

                        $("#Answer_td").html('');
                        $("#Answer_tr").tmpl(json.result.retData.PagedData).appendTo("#Answer_td");
                        makePageBar(BindData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#Answer_td").html('');
                        $(".page").hide();
                    }
                },
                error: function (errMsg) {
                    alert('数据加载失败！');
                }
            });
        }
    </script>
</body>
</html>
