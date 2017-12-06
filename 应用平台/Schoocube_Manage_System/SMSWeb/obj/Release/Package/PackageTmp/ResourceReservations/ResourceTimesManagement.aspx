<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceTimesManagement.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceTimesManagement" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>时间段维护</title>
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
    <script src="/Scripts/Common.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../ResourceReservationMenu.js"></script>
    <script type="text/javascript" src="../js/menu_top.js"></script>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HChapterID" value="" />
    <input type="hidden" id="HUserName" value="<%=Name%>" />
    <input type="hidden" id="HID" value="" />
    <input type="hidden" id="HResourceReservation" value="" />
    <input type="hidden" id="HResourceId" value="" />
    <input type="hidden" id="HResourceReservationId" value="" />
    <input type="hidden" id="HTimeIntervalId" value="" />
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
    <div class="time_wrap pt90 width">
        <div class="menu fl">
            <div class="detail_items_title">
                时间段目录
                    <div class="fr add" onclick="addLeftMenu(0,0,this,'menu_side')">添加</div>
            </div>
            <ul class="item_sides bordshadrad" id="menu_side">
                <li class="active"></li>
            </ul>
        </div>
        <!---->
        <div class="onlinetest_right fr bordshadrad" style="min-height:800px;">
            <div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="javascript:;" class="on">时间段管理</a>
                </div>
            </div>
            <div class="time_base">
                <ul class="time">
                    <%--<li class="timeInput">
                        <input name="Wdate" type="text" value="" id="startDate" disabled="disabled" class="Wdate" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" /><input name="Wdate" type="text" value="" id="endDate" class="Wdate" disabled="disabled" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'H:mm:ss'})" /><input type="button" value="+" class="btn_add" onclick="AddTimeControl()" /><input type="button" value="x" class="btn_delete" disabled="disabled" style="background: #ccc; cursor: default;" /></li>--%>
                </ul>
                <div style="text-align: center">
                    <input type="button" name="sure" id="sure" value="确定" class="sure" onclick="AddTimeMethod()" />
                </div>
            </div>
        </div>
    </div>

    <style>
        .time_base .time li .Wdate {
        }
    </style>
    <script src="../js/common.js"></script>
    <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
    <%-- </form>--%>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        var start = "";
        $(function () {
            ResourceMenu();
            Chapator();
            start = "";
            GetActiveTreeIdAndName();
            getData();
            //折叠菜单
            $('#menu_side').find('li:has(ul)').children('div').click(function () {
                if ($(this).siblings("ul").is(":hidden")) {
                    ClearActiveClass();
                    $(this).parent('li').addClass('active');
                    $(this).nextAll("ul").slideDown("fast");
                } else {
                    $(this).nextAll("ul").slideUp("fast");
                }
            })
            //otContentHover($('.item_knot'));
            knotContentHover($('.item_chapter'));
        })

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

        var iniData = "";
        function getData() {
            var timeIntervalId = $("#HChapterID").val();
            iniData = "";
            start = "";
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "GetTimeManagementList", "ispage": "false", "TimeIntervalId": timeIntervalId },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        start = "";
                        iniData = "";
                        $(".time li").html('');
                        $(json.result.retData).each(function (j, m) {
                            var id = "";
                            id = m.Id;
                            iniData += id + "/" + m.BeginTime + "~" + m.EndTime + ",";
                            start += "<li class=\"data\" id='" + id + "'>";
                            start += "<input name=\"Wdate\" type=\"text\" value='" + m.BeginTime + "' id=\"startTimeDate\" class=\"Wdate\" \onfocus=\"var date=maxDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})\"/>";
                            start += "<input name=\"Wdate\" type=\"text\" value='" + m.EndTime + "' id=\"endTimeDate\" class=\"Wdate\" \onfocus=\"var date=minDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',minDate:date})\"/>";
                            start += "<input type=\"button\" value=\"+\" class=\"btn_add\" onclick=\"AddTimeControl()\"/>";
                            start += "<input type=\"button\" value=\"x\" class=\"btn_delete\" onclick=\"DelTimeControl(this,'" + id + "','" + timeIntervalId + "')\"/>";
                            start += "</li>";
                        })
                    } else {
                        $(".time li").html('');
                        start+="<li class=\"data\" id=\"Add\">";
                        start += "<input name=\"Wdate\" type=\"text\" value=\"\" id=\"startTimeDate\" class=\"Wdate\" \onfocus=\"var date=maxDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})\"/>";
                        start += "<input name=\"Wdate\" type=\"text\" value=\"\" id=\"endTimeDate\" class=\"Wdate\" \onfocus=\"var date=minDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',minDate:date})\"/>";
                        start += "<input type=\"button\" value=\"+\" class=\"btn_add\" onclick=\"AddTimeControl()\"/>";
                        start += "<input type=\"button\" value=\"x\" class=\"btn_delete\" onclick=\"DelTimeControl(this,'','')\"/>";
                        start += "</li>";
                    }
                    $(".time").append(start);

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });

        }

        function maxDate() {
            return "#F{$dp.$D(\'endTimeDate\')||$dp.$DV(\'2020-4-3\')}";
        }

        function minDate() {
            return "#F{$dp.$D(\'startTimeDate\')||$dp.$DV(\'2020-4-3\')}";
        }
  

        //确定button
        function AddTimeMethod() {
            var arrIds = [];
            var updateTimeDate = [];
            var addTimeDate = [];
            var strUpdate = "";
            var arrUpdate = [];
            var index = "";
            var startindex = "";
            var endindex = "";
            var strTime = [];
            var selectReservationTimeId = "";//时间改变的Id
            var iniId = "";
            var strStartTime = "";
            var strEndTime = "";
            var strInputValue = "";
            var isEdit = "";
            $(".time li").each(function (e, t) {
               if ($(this).find("input").val() == "") {
                    //layer.alert("时间段已预约了，不可以修改!");
                    strInputValue = "1";
                    return false;
                } else {


                    var id = t.id;
                    var startTimeDate = $(this).find("#startTimeDate").val();
                    var endTimeDate = $(this).find("#endTimeDate").val();
                    var timeIntervalId = $("#HChapterID").val();
                    if (id == "Add") {
                        var obj = new Object();
                        obj.startTimeDate = $(this).find("#startTimeDate").val();
                        obj.endTimeDate = $(this).find("#endTimeDate").val();
                        addTimeDate.push(obj);
                    } else {
                        GetResourceId(timeIntervalId);
                        if ($("#HResourceId").val() == "") {
                            var obj = new Object();
                            obj.Id = id;
                            obj.startTimeDate = $(this).find("#startTimeDate").val();
                            obj.endTimeDate = $(this).find("#endTimeDate").val();
                            updateTimeDate.push(obj);
                        } else {
                            if (iniData.length > 0) {
                                strUpdate = iniData.split(",");
                                for (var strIni = 0; strIni < strUpdate.length - 1; strIni++) {

                                    index = strUpdate[strIni].indexOf("/");
                                    iniId = strUpdate[strIni].substring(0, index);
                                    if (id == iniId) {
                                        startindex = strUpdate[strIni].indexOf("~");
                                        strStartTime = strUpdate[strIni].substring(index + 1, startindex);
                                        strEndTime = strUpdate[strIni].substring(startindex + 1);
                                        if (strStartTime != startTimeDate || strEndTime != endTimeDate) {
                                            //selectReservationTimeId += id + ",";

                                            //if ($("#HResourceId").val() == "") {
                                            //    isEdit = false;
                                            //    //var obj = new Object();
                                            //    //obj.Id = id;
                                            //    //obj.startTimeDate = $(this).find("#startTimeDate").val();
                                            //    //obj.endTimeDate = $(this).find("#endTimeDate").val();
                                            //    //updateTimeDate.push(obj);
                                            //} else {
                                            var resourceId = $("#HResourceId").val();
                                            arrIds = resourceId.split(",");
                                            for (var i = 0 ; i < arrIds.length; i++) {
                                                GetResourceReservation(arrIds[i], id);
                                                var isExit = $("#HResourceReservationId").val();
                                                if (isExit != "") {
                                                    isExit = isExit.split(",");
                                                }
                                                if (isExit.length > 0) {
                                                    layer.alert("时间段已预约了，不可以修改!");
                                                    isEdit = "1";
                                                    return false;
                                                } else {
                                                    isEdit = "2";
                                                    //var obj = new Object();
                                                    //obj.Id = id;
                                                    //obj.startTimeDate = $(this).find("#startTimeDate").val();
                                                    //obj.endTimeDate = $(this).find("#endTimeDate").val();
                                                    //updateTimeDate.push(obj);
                                                }
                                            }

                                            //}
                                        }
                                        if (isEdit=="1") {
                                            var obj = new Object();
                                            obj.Id = id;
                                            obj.startTimeDate = $(this).find("#startTimeDate").val();
                                            obj.endTimeDate = $(this).find("#endTimeDate").val();
                                            updateTimeDate.push(obj);
                                        }

                                    }

                                }
                            }
                            //var strTimeId = selectReservationTimeId.split(",");
                            //if (strTimeId.length > 0) {
                            //    GetResourceId(selectReservationTimeId);
                            //    if ($("#HResourceId").val() == "") {
                            //        isEdit = false;
                            //    } else {
                            //        var resourceId = $("#HResourceId").val();
                            //        var strIds = resourceId.split(",");
                            //        for (var i = 0 ; i < strIds.length; i++) {
                            //            GetResourceReservation(strIds[i], id);
                            //        }
                            //        var isExit = $("#HResourceReservationId").val();
                            //        if (isExit != "") {
                            //            isExit = isExit.split(",");
                            //        }
                            //        if (isExit.length > 0) {
                            //            layer.alert("时间段已预约了，不可以修改!");
                            //            isEdit = true;
                            //            return;
                            //        } else {
                            //            isEdit = false;
                            //        }
                            //    }
                            //} else {
                            //    isEdit = false;
                            //}
                            //if (!isEdit) {
                            //    var obj = new Object();
                            //    obj.Id = id;
                            //    obj.startTimeDate = $(this).find("#startTimeDate").val();
                            //    obj.endTimeDate = $(this).find("#endTimeDate").val();
                            //    updateTimeDate.push(obj);
                            //}

                        }

                        //GetResourceId(id);
                        //var resourceClassId = $("#HResourceId").val();
                        //var strIds = resourceClassId.split(",");
                        //for (var i = 0 ; i < strIds.length; i++) {
                        //    GetResourceReservation(strIds[i], id);
                        //}
                        //flag = $("#HResourceReservationId").val();
                        //if (flag != "") {
                        //    flag = flag.split(",");
                        //}
                        //if (flag.length > 0) {
                        //    layer.alert("该资源已被预约,不可以删除!");
                        //    return;
                        //} else {
                        //    DelTimeData(id);
                        //}
                        //for (var i = 0; i < strUpdate.length; i++) {
                        //    var HTimeId = $("#HTimeIntervalId").val();
                        //    if (HTimeId.length > 0) {
                        //        strTime = HTimeId.split(",");
                        //    }
                        //    if (strTime.length > 0) {
                        //        for (var j = 0; j < strTime.length; j++) {
                        //            if (strTime[j] == id) {
                        //                layer.alert("时间段：" + $(this).find("#startTimeDate").val() + "~" + $(this).find("#endTimeDate").val() + "不可以修改!");
                        //                isEdit = true;
                        //                return;
                        //            }
                        //        }
                        //    }


                        //}

                    }
                }
            })
            if (strInputValue == "1") {
                layer.alert("请填写完整数据!");
                return;
            }
            if (isEdit=="1") {
                layer.alert("时间段已预约了，不可以修改!");
                return;
            }

            
            var jsonAddTimeDate = JSON.stringify(addTimeDate);
            var jsonUpdateTimeDate = JSON.stringify(updateTimeDate);
            var UserName = $("#HUserName").val();
            GetActiveTreeIdAndName();
            var TimeIntervalId = $("#HChapterID").val();
            if (TimeIntervalId == "" || TimeIntervalId == null || typeof (TimeIntervalId) == undefined) {
                layer.msg("请先添加左侧导航信息!");
                return;
            }
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                traditional: true,
                data: {
                    "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "AddTime"
                , "jsonAddTimeDate": jsonAddTimeDate, "jsonUpdateTimeDate": jsonUpdateTimeDate, "TimeIntervalId": TimeIntervalId, "UserName": UserName, "arrValue": 1
                },
                success: function (json) {
                    layer.msg("添加时间段成功");
                    start = "";
                    $(".time li").remove();
                    GetActiveTreeIdAndName();
                    getData();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("无目录数据");
            }
            // }
        }

        function addUpdateData(Id, BeginTime, EndTime) {
            var UserName = $("#HUserName").val();
            GetActiveTreeIdAndName();
            var TimeIntervalId = $("#HChapterID").val();
            if (TimeIntervalId == "" || TimeIntervalId == null || typeof (TimeIntervalId) == undefined) {
                layer.msg("请先添加左侧导航信息!");
                return;
            }
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                traditional: true,
                data: {

                    "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "AddTime"
                , "BeginTime": BeginTime, "EndTime": EndTime, "Id": Id, "TimeIntervalId": TimeIntervalId, "UserName": UserName
                },
                success: function (json) {
                    chapterDiv = "";
                    Chapator();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("无目录数据");
            }
        }
        var chapterDiv = "";
        function Chapator() {
            chapterDiv = "";
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeIntervalHandler.ashx", "Func": "GetLeftMenuData" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            var id = n.Id;
                            var divid = "div" + n.Id;
                            $("#HChapterID").val(n.Id);
                            //<a href=\"javascript:void(0)\" onclick='addLeftMenu(0," +pnode[arr].Id + ", this,\"" + divid + "\")'>添加</a>
                            var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditTimeIntervalMenu(this,'" +
                                   n.Id + "','" + n.TimeIntervalName + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + n.Id + ")\">删除</a></div>";
                            if (i == 0) {
                                chapterDiv += "<li class='active'>";
                            } else {
                                chapterDiv += "<li>";
                            }
                            chapterDiv += "<div class=\"item_chapter\" id='" + divid + "' onclick=\"changeMenu(this," + n.Id + ")\" ><span>" + n.TimeIntervalName +
                                "</span>" + caozuo + "</div>";
                        })
                    }
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
        function AddTimeControl() {
            var start = "";
            start += "<input name=\"Wdate\" type=\"text\" value=\"\" id=\"startTimeDate\" class=\"Wdate\" \onfocus=\"var date=maxDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',maxDate:date})\"/>";
            start += "<input name=\"Wdate\" type=\"text\" value=\"\" id=\"endTimeDate\" class=\"Wdate\" \onfocus=\"var date=minDate();WdatePicker({skin:'whyGreen',dateFmt:'HH:mm:ss',minDate:date})\"/>";
            start += "<input type=\"button\" value=\"+\" class=\"btn_add\" onclick=\"AddTimeControl()\"/>";
            start += "<input type=\"button\" value=\"x\" class=\"btn_delete\" onclick=\"DelTimeControl(this,'','')\"/>";

            $(".time").append("<li class=\"data\" id=\"Add\">" + start + "</li>")
        }
        var ids = "";
        function DelTimeControl(obj, id, timeIntervalId) {
            var flag = "";
            if (id == "") {
                $(obj).parent("li").remove();
            } else {
                GetResourceId(timeIntervalId);
                if ($("#HResourceId").val() == "") {
                    DelTimeData(id);
                } else {
                    var resourceClassId = $("#HResourceId").val();
                    var strIds = resourceClassId.split(",");
                    for (var i = 0 ; i < strIds.length; i++) {
                        GetResourceReservation(strIds[i], id);
                        if ($("#HResourceReservationId").val() == "") {
                       
                        } else {
                            flag += $("#HResourceReservationId").val() + ",";
                        }
                        
                        
                    }
                    if (flag != "") {
                        flag = flag.split(",");
                    }
                    if (flag.length > 0) {
                        layer.alert("该资源已被预约,不可以删除!");
                        return;
                    } else {
                        DelTimeData(id);
                    }
                }
            }

        }

        function DelTimeData(id) {
            var UserName = $("#HUserName").val();
            layer.msg("确定要删除么?", {
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
                                   "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "DelTime",
                                   "ID": id, "UserName": UserName
                               },
                               success: function (json) {
                                   if (json.result.errNum.toString() == "0") {
                                       layer.msg("删除资源数据成功");
                                       //$("#HChapterID").val(id);
                                       start = "";
                                       $(".time li").remove();
                                       getData();
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

        function changeMenu(obj, id) {
            ClearActiveClass();
            $(obj).parents("li").addClass('active');
            start = "";
            //GetActiveTreeIdAndName();
            $(".time li").remove();
            $("#HChapterID").val(id);
            getData();
        }

        function GetActiveTreeIdAndName() {
            $("#HChapterID").val('');
            var Pid = "";
            var treeId = $("ul li.active div").attr("id");
            if (typeof (treeId) == "undefined") {
                layer.msg("请选择一个时间段");
            } else {
                Pid = treeId.substring(3);
            }
            $("#HChapterID").val(Pid);
        }


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
                layer.alert("有未完成操作");
                $('#menu_side input').focus();
            }
        }

        function AddNewMenu(id) {
            var Name = $("#Menu" + id + "").val();
            var UserName = $("#HUserName").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeIntervalHandler.ashx", "Func": "AddTimeInterval", "TimeIntervalName": Name, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航添加成功");
                        chapterDiv = "";
                        Chapator();
                    }

                }
            })

        }

        function EditTimeIntervalMenu(em, id, name) {
            var title = $(em).parent().parent().children("span").html();
            if (name = title) {
                var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
        "\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditTimeIntervalMenuName(this,'" + id + "','" + name + "')\">√</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditNameQ(this,'" + name +
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
        function EditTimeIntervalMenuName(em, id, oldname) {
            var name = $("#txt" + id).val();
            var UserName = $("#HUserName").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeIntervalHandler.ashx", "Func": "AddTimeInterval", "Id": id, "TimeIntervalName": name, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("重命名成功");
                        chapterDiv = "";
                        Chapator();
                    }
                    else { layer.msg('重命名失败！'); }
                },
                error: function (errMsg) {
                    layer.msg('重命名失败！');
                    $(em).parent().parent().children("span").html(oldname);
                }
            });
        }

        //function EditTimeManagementMenu(em, id, begin, end) {
        //    var title = $(em).parent().parent().children("span").html();
        //    var name = begin + "-" + end;
        //    if (name = title) {
        //        var v = "<input type='text' value='" + title + "' style='float:left;line-height:10px;margin-top:5px;width:100px;' id=\"txt" + id +
        //"\"/> <i class=\"iconfont tishi true_t\" style=\"margin: 2px; color: #87c352; float: left;cursor:pointer;\" onclick=\"EditTimeManagementMenuName(this,'" + id + "','" + begin + "','" + end + "')\">√</i> <i class=\"iconfont tishi fault_t\" style=\"margin: 2px; color: #ff6d72; float: left;cursor:pointer;\" onclick=\"EditChidrenNameQ(this,'" + name +
        //"')\">×</i>";
        //    }
        //    $(em).parent().parent().children("span").html(v);
        //    //$(em).parents("li").find(".docu_name").removeAttr("onclick");
        //    // 取消事件冒泡
        //    var e = arguments.callee.caller.arguments[0] || event; // 若省略此句，下面的e改为event，IE运行可以，但是其他浏览器就不兼容
        //    if (e && e.stopPropagation) {
        //        // this code is for Mozilla and Opera
        //        e.stopPropagation();
        //    } else if (window.event) {
        //        // this code is for IE
        //        window.event.cancelBubble = true;
        //    }
        //}
        //function EditTimeManagementMenuName(em, id, begin, end) {
        //    var name = "";
        //    var beginName = "";
        //    var endName = "";
        //    var oldname = begin + "-" + end;
        //    name = $("#txt" + id).val();
        //    if (name != null || name != "") {
        //        var index = name.indexOf("-");
        //        beginName = name.substring(0, index);
        //        endName = name.substring(index + 1);
        //    }
        //    var UserName = $("#HUserName").val();
        //    $.ajax({
        //        url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
        //        type: "post",
        //        async: false,
        //        dataType: "json",
        //        data: { "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "AddTime", "Id": id, "BeginTime": beginName, "EndTime": endName, "UserName": UserName },
        //        success: function (json) {
        //            if (json.result.errNum.toString() == "0") {
        //                layer.msg("重命名成功");
        //                chapterDiv = "";
        //                Chapator();
        //            }
        //            else { layer.msg('重命名失败！'); }
        //        },
        //        error: function (errMsg) {
        //            layer.msg('重命名失败！');
        //            $(em).parent().parent().children("span").html(oldname);
        //        }
        //    });
        //}
        //取消修改文件名称
        function EditNameQ(em, name) {
            $(em).parents(".item_chapter").children("span").html(name);
            //stopEvent();
        }

        //function EditChidrenNameQ(em, name) {
        //    $(em).parents(".item_knot").children("span").html(name);
        //    //stopEvent();
        //}

        var chidrenId;
        function GetIds(id) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "DelTimeMenu", "ID": chidrenId },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航删除成功");
                        chapterDiv = "";
                        pnode = [];
                        node = [];
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
        //删除左侧菜单
        function DelMenu(id) {

            var UserName = $("#HUserName").val();
            var delId = "";
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeIntervalHandler.ashx", "Func": "DelTimeMenu", "ID": id, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航删除成功");
                        chapterDiv = "";
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

        function DelChildrenMenu(id) {
            var UserName = $("#HUserName").val();
            var delId = "";
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "ResourceReservations/TimeManagementHandler.ashx", "Func": "DelTime", "ID": id, "UserName": UserName },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        layer.msg("导航删除成功");
                        chapterDiv = "";
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

        //删除左侧树菜单
        function DelCurrentAddMenu() {
            $("#li0").remove();
        }

        function GetResourceId(timeIntervalId) {
            var ids = "";
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceTimeMappingIdHandler.ashx", "Func": "GetResourceTimeMapping", "TimeIntervalId": timeIntervalId, "ispage": "false"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            ids += this.ResourceId + ",";
                        });
                        if (ids.length > 0) {
                            ids = ids.substring(0, ids.length - 1);
                        }
                        if (ids.length > 0) {
                            $("#HResourceId").attr("value", ids);
                        } else {
                            $("#HResourceId").attr("value", "");
                        }

                    } else {
                        $("#HResourceId").attr("value", "");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }

        function GetResourceReservation(ReSourceClassId, timeIntervalId) {
            var ResourceReservationId = "";
            var TimeIntervalId = "";
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    "PageName": "ResourceReservations/ResourceReservationHandler.ashx", "Func": "GetPageList", "ReSourceClassId": ReSourceClassId, "ReservationTimeInterval": timeIntervalId, "ispage": "false"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function (i, item) {
                            ResourceReservationId += item.Id + ",";
                            TimeIntervalId += item.TimeInterval + ",";
                        });
                        if (ResourceReservationId.length > 0) {
                            ResourceReservationId = ResourceReservationId.substring(0, ResourceReservationId.length - 1);
                        }
                        if (TimeIntervalId.length > 0) {
                            TimeIntervalId = TimeIntervalId.substring(0, TimeIntervalId.length - 1);
                        }
                        if (ResourceReservationId.length > 0) {
                            $("#HResourceReservationId").attr("value", ResourceReservationId);
                        }
                        if (TimeIntervalId.length > 0) {
                            $("#HTimeIntervalId").attr("value", TimeIntervalId);
                        }
                    } else {
                        $("#HResourceReservationId").attr("value", "");
                        $("#HTimeIntervalId").attr("value", "");
                    }

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg("操作失败！");
                }
            });
        }
    </script>
</body>
</html>

