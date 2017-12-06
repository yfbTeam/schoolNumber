<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceReservationInfo.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceReservationInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>基础数据维护</title>
    <!--图标样式-->
    <link rel="stylesheet" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <link rel="stylesheet" href="../css/plan.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../ResourceReservationMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script id="tr_ResourceList" type="text/x-jquery-tmpl">
        <tr>
            <td class="checkradio pr">
                <input type="checkbox" name="Check_box" value="${Id}" />
                <input type="hidden" id="HID" value="${Id}" />
            </td>
            <td>${Name}</td>
            <td>${ResourceTypeName}</td>
            <td>${DateTimeConvert(CreateTime)}
            </td>
            <td>
                    {{if Status == 0}}正常{{/if}}
                    {{if Status == 1}}故障{{/if}}
                    {{if Status == 2}}维修中{{/if}}
            </td>


            <td>
                <a href="javascript:;" onclick="EditResource(${Id},'${ResourceTypeName}')"><i class="icona icon-edit" title="编辑"></i></a>
                <a href="javascript:;" onclick="DeleteResource(${Id})"><i class="icona icon-trash" title="删除"></i></a>
                {{if UseStatus == 0}}
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'1')" class="enable"><i class="icona icon-ban-circle" title="禁用"></i></a>
                    {{else}}
                    <a href="javascript:void(0);;" onclick="javascript:ChangeStatus(this,${Id},'0')" class="disable"><i class="icona icon-ok-circle" title="启用"></i></a>
                    {{/if}}
            </td>
        </tr>
    </script>
</head>
<body>
    <%-- <form id="form1" runat="server">--%>
    <input type="hidden" id="HChapterID" value="" />
    <input type="hidden" id="HChapterName" value="" />
    <input type="hidden" id="HLevelID" runat="server" value="1" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HIds" runat="server" />
    <input type="hidden" id="HUserName" value="<%=Name%>" />
    <input type="hidden" id="HPId" />
    <input type="hidden" id="HReservation" runat="server" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <div class="wenzi_tips fl">
                   <img src="../images/shixuenshiguanli.png" />
                </div>
            <nav class="navbar menu_mid fl">
                <ul id="ResourceMenu">
                    <%--<li currentclass="active"><a href="ResourceReservationInfo.aspx">基础数据维护</a></li>
                        <li currentclass="active"><a href="ResourceTimesManagement.aspx">时间段维护</a></li>
                        <li currentclass="active"><a href="BookingCar.aspx">资源预定</a></li>
                        <li currentclass="active"><a href="AssetManagement.aspx">资产管理</a></li>--%>
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
                            <h2><%=Name%>
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
    <!--time-->
    <div class="time_wrap pt90 width clearfix">
        <div class="menu fl">
            <div class="detail_items_title">
                资源分类
					<div class="fr add" onclick="addLeftMenu(0,0,this,'menu_side')">添加</div>
                <div class="fr mate" style="margin-right: 10px;" onclick="ResourceTimeMate()">时间段匹配</div>
            </div>
            <ul class="item_sides" id="menu_side">
            </ul>
        </div>
        <!---->
        <div class="onlinetest_right fr bordshadrad">
            <div class="stytem_select">
                <div class="stytem_select_right fl">
                    <div class="search_exam fl pr">
                        <input type="text" name="search_w" id="search_w" value="" onblur="getData(1, 10);" placeholder="请输入关键字" />
                        <i class="icon  icon-search"></i>
                    </div>
                    <div class="fr">
                        <a href="javascript:void(0);" class="delete_quan" onclick="DelResourceChecked()">
                            <i class="icon icon-trash" style="color: #fff"></i>删除
                        </a>
                        <a href="javascript:;" class="add_res" onclick="AddResource()">
                            <i class="icon icon-plus" style="color: #fff"></i>新增资源
                        </a>
                    </div>
                </div>
            </div>
            <div class="time_base">
                <table class="table_wrap mt10">
                    <thead class="thead">
                        <th class="pr checkall">
                            <input type="checkbox" name="checkbox" id="checkbox" /></th>
                        <th>名称</th>
                        <th>类型</th>
                        <th>发布时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </thead>
                    <tbody class="tbody" id="tb_ResourceList">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
    <!--分页-->
    <div class="page">
        <span id="pageBar"></span>
    </div>
    <%--</form>--%>
    <script src="../js/common.js"></script>
    <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>

    <script type="text/javascript">
        var UrlDate = new GetUrlDate();

        $(function () {
            ResourceMenu();
            Chapator();
            $("#menu_side").html(chapterDiv);
            getData(1, 10);
            $('#menu_side').find('li:has(ul)').children('div').click(function () {
                if ($(this).siblings("ul").is(":hidden")) {
                    ClearActiveClass();
                    $(this).parent('li').addClass('active');
                    $(this).nextAll("ul").slideDown("fast");
                } else {
                    $(this).nextAll("ul").slideUp("fast");
                }
            })
            knotContentHover($('.item_knot'));
            knotContentHover($('.item_content'));
            knotContentHover($('.item_chapter'));
        })
        //选择所有checkbox
        $('.checkall>input').click(function () {
            if ($(this).is(':checked')) {
                $('.checkradio>input').prop('checked', true);
            } else {
                $('.checkradio>input').prop('checked', false);
            }
        })
        //多选删除
        function DelResourceChecked() {
            var ids = "";
            $("input[type=checkbox][name=Check_box]").each(function () {//查找每一个name为cb_sub的checkbox 
                if (this.checked) {
                    ids += this.value + ",";
                }
            });
            if (ids == "") {
                layer.msg("请选择要删除的资源!");
            }
            else {
                DeleteResource(ids);
            }
        }

        function knotContentHover(obj) {
            obj.hover(function () {
                $(this).children('div').show();
            }, function () {
                $(this).children('div').hide();
            });
        }

        function ClearActiveClass() {
            $("#menu_side li").removeClass("active");
            $("#menu_side li ul li").removeClass("active");
            $("#menu_side  li ul li ul l").removeClass("active");
        }
        //获取数据
        var ids = "";
        function getData(startIndex, pageSize) {
            var sername = $("#search_w").val();
            if ($("#HChapterID").val() == "") {
                GetActiveTreeIdAndName();
            }

            var id = $("#HChapterID").val();
            //GetIds(id);
            //id = $("#HIds").val();
            //if (id != "" || typeof (id) != "undefined") {
            //    id = ids.substring(0, id.length - 1);
            //}
            var str = "";
            GetIds(id);
            ids = $("#HIds").val();
            if (ids != "" || typeof (ids) != "undefined") {
                ids = ids.substring(0, ids.length - 1);
                str = ids.split(",");
            }
            if (str.length < 2) {
                $("#HLevelID").val("0");
            } else {
                $("#HLevelID").val("1");
            }
            // $("#HChapterID").val(ids);

            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var level = $("#HLevelID").val();
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize,
                    "PID": ids, "Level": level, "LikeName": sername
                },
                success: OnSuccess,
                error: OnError
            });
        }

        //获取数据成功显示列表
        function OnSuccess(json) {
            if (json.result.errNum.toString() == "0") {
                $("#tb_ResourceList").html('');
                $("#tr_ResourceList").tmpl(json.result.retData.PagedData).appendTo("#tb_ResourceList");
                //ButtonList($("#HPId").val());
                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 10, json.result.retData.RowCount);

            } else {
                var html = '<tr><td colspan="1000"><div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div></td></tr>';
                $("#tb_ResourceList").html(html);

                //layer.msg(json.result.errMsg);

            }
        }

        //获取数据失败显示无内容
        function OnError(XMLHttpRequest, textStatus, errorThrown) {
            $("#tb_ResourceList tbody").html('无内容');
        }
        var chapterDiv = "";
        var i = 0;
        var j = 0;
        function Chapator() {

            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationClaHandler.ashx", "Func": "GetLeftMenu", "ID": "" },
                success: function (json) {
                    //jsonChapator = json;
                    BindChapator("0", "0", json);
                    $("#menu_side").html(chapterDiv);
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("无目录数据");
            }
        }

        function BindChapator(pid, perPid, json) {
            var Itemclass = "item_content"
            if (perPid == "0" && pid != "0") {
                Itemclass = "item_knot";
            }
            if (json.result.errNum.toString() == "0") {
                if (pid != "0" && perPid == "0" && i == 1) {
                    chapterDiv += "<ul style='display:block'>";
                }
                if (pid != "0" && perPid == "0" && i > 1) {
                    chapterDiv += "<ul style='display:none'>";
                }
                if (pid != "0" && perPid > 0 && j == 1) {
                    chapterDiv += "<ul style='display:block'>";
                }
                if (pid != "0" && perPid > 0 && j > 1) {
                    chapterDiv += "<ul style='display:none'>";
                }
                $(json.result.retData).each(function () {
                    var divid = "div" + this.Id;
                    //var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick='addLeftMenu(" +
                    //    this.Id + "," + pid + ", this,\"" + divid + "\")'>添加</a><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," +
                    //    this.Id + ",'" + this.Name + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.Id + ")\">删除</a></div>";
                    var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick='addLeftMenu(" +
                        this.Id + "," + pid + ", this,\"" + divid + "\")'>添加</a></div>";

                    if (pid == "0" && this.PId == pid) {
                        caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," + this.Id +
                         ",'" + this.Name + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.Id + ")\">删除</a></div>";
                        if (i == 0) {
                            $("#HChapterID").val(this.Id);
                            $("#HPId").val(this.PId);
                            $("HChapterName").val(this.Name);
                            chapterDiv += "<li class='active'>";
                        }
                        else { chapterDiv += "<li>"; }
                        chapterDiv += "<div class=\"item_chapter\" id='" + divid + "' data-name='" + this.Name + "' onclick=\"changeMenu(this," + this.Id + ")\" ><span>" + this.Name +
                            "</span><i class=\"icon  icon-angle-down\"></i></div>" //+ caozuo + "<i class=\"icon  icon-angle-down\"></i></div>";
                        i++;
                        BindChapator(this.Id, this.PId, json);
                        chapterDiv += "</li>";
                    }
                    if (pid != "0" && this.PId == pid) {
                        caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," + this.Id +
                         ",'" + this.Name + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.Id + ")\">删除</a></div>";
                        chapterDiv += "<li><div class=\"" + Itemclass + "\" id='" + divid + "' data-name='" + this.Name + "' onclick=\"changeMenu(this," + this.Id + ")\"><span>" + this.Name + "</span></div>" //+ caozuo + "</div>"
                        j++;
                        BindChapator(this.Id, this.PId, json);
                        chapterDiv += "</li>"

                    }
                })
                if (pid != "0") {
                    chapterDiv += "</ul>";
                }
            }
            else {
                layer.msg(json.result.errMsg);
            }
        }

        //时间匹配页面
        function ResourceTimeMate() {
            GetActiveTreeIdAndName();
            var Pid = $("#HChapterID").val();
            var PName = $("#HChapterName").val();
            if (Pid == null || Pid == undefined || Pid == "") {
                layer.msg("请选择资源分类!");
            } else {
                OpenIFrameWindow('时间匹配', 'ResourceTimeMate.aspx?PID=' + Pid + '&PName=' + PName+'&ParentID=' + UrlDate.ParentID + '&PageName=' + UrlDate.PageName, '700px', '80%');
            }
        }


        //新增资源
        function AddResource() {
            GetActiveTreeIdAndName();
            var Pid = $("#HChapterID").val();
            var PName = $("#HChapterName").val();
            if (Pid == null || Pid == undefined || Pid == "") {
                layer.msg("请选择资源分类!");
            } else {
                OpenIFrameWindow('新增资源', 'ResourceAdd.aspx?PID=' + Pid + '&PName=' + escape(PName)+"&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName, '700px', '80%');
            }
        }

        //编辑资源
        function EditResource(id, name) {
            //GetActiveTreeIdAndName();
            //var Pid = $("#HChapterID").val();
            //var PName = $("#HChapterName").val();
            OpenIFrameWindow('编辑资源', 'ResourceAdd.aspx?ID=' + id + '&PName=' + escape(name) + "&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName, '700px', '80%');
        }

        //获取活动的tree的ID和Name值
        function GetActiveTreeIdAndName() {
            $("#HChapterID").val('');
            $("#HChapterName").val('');
            var Pid = "";
            var PName = "";
            var treeId = "";
            //treeId = $("#menu_side li.active").children("div").attr("id");
            //if (treeId != undefined || treeId != null || treeId != "") {
            //    Pid = treeId.substring(3);
            //    PName = $("ul li.active div").attr("data-name");
            //}
            $("li[class='active']").each(function () {
                treeId = $(this).find('div').attr("id");
                if (treeId != null || treeId != undefined) {
                    Pid = treeId.substring(3);
                    PName = $("ul li.active div").attr("data-name");
                }
            });
            $("#HChapterID").val(Pid);
            $("#HChapterName").val(PName);
        }

        //判断是不是父类以及刷新数据
        function GetIds(id) {
            ids = "";
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationClaHandler.ashx", "Func": "GetLeftMenu",
                    "CPID": id
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            if (this.Id != "") {
                                ids += this.Id + ",";
                            }
                        });
                        $("#HIds").attr("value", ids);
                    }

                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });

        }

        //删除对应的资源
        function DeleteResource(id) {
            GetActiveTreeIdAndName();
            var ReSourceClassId=$("#HChapterID").val();
            GetResourceReservationById(id, ReSourceClassId);
            var UserName = $("#HUserName").val();

            if ($("#HReservation").val() == "true") {
                layer.alert("该资源已被预约,不可以删除!");
                return;
            } else {
                layer.msg("确定要删除该资源么?", {
                    time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
               layer.close(index);
               $.ajax({
                   url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                   type: "post",
                   async: true,
                   dataType: "json",
                   data: {
                       "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "DelResource",
                       "ID": id, "UserName": UserName
                   },
                   success: function (json) {
                       if (json.result.errNum.toString() == "0") {
                           layer.msg("删除资源数据成功");
                           $("#HChapterID").val(id);
                           getData(1, 10);
                       }
                       else {
                           layer.msg(json.result.errMsg);
                       }
                   },
                   error: function (errMsg) {
                       layer.msg('删除资源数据失败！');
                   }
               });
           }
                });
            }
            //$.ajax({
            //            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            //            type: "post",
            //            async: true,
            //            dataType: "json",
            //            data: {
            //                "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "DelResource",
            //                "ID": id, "UserName": UserName
            //            },
            //            success: function (json) {
            //                if (json.result.errNum.toString() == "0") {
            //                    layer.msg("删除资源数据成功");
            //                    $("#HChapterID").val(id);
            //                    getData(1, 10);
            //                }
            //                else {
            //                    layer.msg(json.result.errMsg);
            //                }
            //            },
            //            error: function (errMsg) {
            //                layer.msg('删除资源数据失败！');
            //            }
            //        });


        }

        function GetResourceReservationById(ReSourceInfoId, ReSourceClassId) {

            var ResourceReservationId = "";
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ReSourceClassId": ReSourceClassId, "ReSourceInfoId": ReSourceInfoId, "ispage": "false"
                },
                success: function (json) {
                    //if (json.result.errNum.toString() == "0") {
                    //    $(json.result.retData).each(function () {
                    //        ResourceReservationId += this.Id + ",";
                    //    });
                    //$("#HResourceReservationId").attr("value", ResourceReservationId);
                    //}
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function (i, item) {
                            ResourceReservationId += this.Id + ",";
                        });
                        $("#HResourceReservationId").attr("value", ResourceReservationId);
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

        //点击树结构查询对应的数据
        // var ids = "";
        function changeMenu(obj, id) {
            //var str = "";
            //GetIds(id);
            //ids = $("#HIds").val();
            //if (ids != "" || typeof (ids) != "undefined") {
            //    ids = ids.substring(0, ids.length - 1);
            //    str = ids.split(",");
            //}
            //if (str.length < 2) {
            //    $("#HLevelID").val("0");
            //} else {
            //    $("#HLevelID").val("1");
            //}
            //$("#HChapterID").val(ids);
            $("#HChapterID").val(id);
            getData(1, 10);
        }

        //添加左侧父级树菜单
        function addLeftMenu(id, pid, em, divid) {
            var className = "item_content";
            if (pid == 0) {
                if (id == 0) {
                    className = "item_chapter";
                }
                else {
                    className = "item_knot";
                }
            }
            var length = $('#menu_side input').length

            if (length == 0) {
                var v = "<input type='text' value='' style='float:left;line-height:10px; width:100px; margin-top:8px;' id=\"Menu" + id
                   + "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; \" onclick=\"AddNewMenu('" + id
                   + "')\">√</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; \" onclick=\"DelCurrentAddMenu(this)\">×</i>";
                var html = "<li id='li0'><div  class=\"" + className + "\"> <span>" + v + "</span></div></li>";
                if (id > 0) {
                    $("#" + divid).next("ul").prepend(html);
                }
                else {
                    $("#" + divid).prepend(html);
                }
            }
            else {
                alert("有未完成操作");
                $('#menu_side input').focus();
            }
        }

        //删除左侧树菜单
        function DelCurrentAddMenu() {
            $("#li0").remove();
        }

        //添加左侧父级节点
        function AddNewMenu(id) {
            var Name = $("#Menu" + id + "").val();
            var UserName = $("#HUserName").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationClaHandler.ashx", "Func": "AddNewResourceMenu", "Name": Name, "PId": id, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航添加成功");
                        chapterDiv = "";
                        i = 0;
                        j = 0;
                        Chapator();
                        $("#menu_side").html(chapterDiv);
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg('导航添加失败！');
                }
            });
        }
        //删除左侧菜单
        function DelMenu(id) {
            var delId = "";
            GetIds(id);
            var id = $("#HIds").val();
            if (id != "" || id != "undefined") {
                delId = id.substring(0, id.length - 1);
            }
            if (delId.length > 0) {
            }
            var UserName = $("#HUserName").val();
            layer.msg("确定要删除导航么?", {
                time: 0 //不自动关闭
           , btn: ['确定', '取消']
           , yes: function (index) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationClaHandler.ashx", "Func": "DelResourceMenu", "ID": delId, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航删除成功");
                        chapterDiv = "";
                        i = 0;
                        j = 0;
                        Chapator();
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg('导航删除失败！');
                }
            });
           }
         });
        }

        //改变状态
        function ChangeStatus(obj, id, status) {
            var UserName = $("#HUserName").val();
            if (id != null && id != "") {
                $.ajax({
                    url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "ResourceReservations/ResourceReservationInfoHandler.ashx", "Func": "ChangeStatus",
                        Id: id, Status: status, "UserName": UserName
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            GetActiveTreeIdAndName();
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

        function EditMenu(em, id, Name) {
            var title = $(em).parent().parent().children("span").html();
            if (name = title) {
                var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
        "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditMenuName(this,'" + id + "','" + name + "')\">√</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
        "')\">×</i>";
            }
            $(em).parent().parent().children("span").html(v);
            //$(em).parents("li").find(".docu_name").removeAttr("onclick");
            // 取消事件冒泡
            var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
            if (e && e.stopPropagation) {
                // this code is for Mozilla and Opera
                e.stopPropagation();
            } else if (window.event) {
                // this code is for IE
                window.event.cancelBubble = true;
            }
        }
        function EditMenuName(em, id, oldname) {
            var name = $("#txt" + id).val();
            var UserName = $("#HUserName").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/ResourceReservationClaHandler.ashx", "Func": "AddNewResourceMenu", Id: id, "Name": name, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("重命名成功");
                        chapterDiv = "";
                        i = 0;
                        j = 0;
                        Chapator();
                    }
                    else { layer.msg('重命名失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('重命名失败！');
                    $(em).parent().parent().children("span").html(oldname);
                }
            });
            stopEvent();
        }

        //取消修改文件名称
        function EditNameQ(em, name) {
            $(em).parents(".item_chapter").children("span").html(name);
            //stopEvent();
        }

    </script>
</body>
</html>
