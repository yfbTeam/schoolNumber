<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ResourceTimeMate.aspx.cs" Inherits="SMSWeb.ResourceReservations.ResourceTimeMate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>时间匹配</title>
    <!--图标样式-->
		<link rel="stylesheet" href="../css/font-awesome.min.css" />
		<link rel="stylesheet" type="text/css" href="../css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="../css/common.css"/>
		<link rel="stylesheet" type="text/css" href="../css/repository.css"/>
		<link rel="stylesheet" type="text/css" href="../css/onlinetest.css"/>
		<link rel="stylesheet" href="../css/plan.css" />
		<script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
		<!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
		<script type="text/javascript" src="../js/menu_top.js"></script>
		<script src="../Scripts/My97DatePicker/WdatePicker.js"></script>
		<script src="../Scripts/layer/layer.js"></script>
        <script src="/Scripts/jquery.tmpl.js"></script>
   		<script src="../Scripts/Common.js"></script>
       <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
        <input type="hidden" id="HChapterID" value="" />
        <input type="hidden" id="HChapterName" value="" />
        <input type="hidden" id="HUserName" value="<%=Name%>" />
        <input type="hidden" id="HIds" runat="server" />
        <input type="hidden" id="HPId" />
    <div class="time_wrap clearfix" style="padding:20px;">
			<div class="menu fl">
				<div class="detail_items_title">
					资源分类
				</div>
				<ul class="item_sides" id="menu_side">
					
				</ul>
			</div>
			<div class="fl" style="margin-left: 20px;width:390px;min-height:240px;border:1px solid #4e95ca;background: #fff;">
				<h1 class="title_mate">时间段用于进行预约物品时进行时段划分，请合理安排时间
段的匹配，简约操作流程。</h1>
				<div class="clearfix" style="line-height: 35px;font-size:14px;padding:0px 10px;"> 
					<div class="fl" style="color:#1472b9">
						匹配时间段：
					</div>
					<div class="fr" style="color:#999999">
						前往  <a href="" style="color:#1472b9;text-decoration: underline;" onclick="TimesClick()" id="timeInfo">时间段维护 </a> 进行时间段编辑
					</div>
				</div>
				<div style="padding: 0px 5px;" id ="radioArea">
					<ul class="clearfix radio_time" id="radiotime">
					</ul>
				</div>
				<div style="text-align: center;margin: 20px auto;">
					<input type="button" class="btn" name="button" id="button" value="确定" onclick="ConfirmButton()"/>
				</div>
			</div>
		</div>
   <%--</form>--%>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
		    $(function () {
		        Chapator();
		        $("#menu_side").html(chapterDiv);
		        getData();

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
		    
		    function TimesClick() {
		        parent.window.location.href = "ResourceTimesManagement.aspx?ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName;
		        parent.CloseIFrameWindow();
		    }

		    function ClearActiveClass() {
		        $("#menu_side li").removeClass("active");
		        $("#menu_side li ul li").removeClass("active");
		        $("#menu_side  li ul li ul l").removeClass("active");
		    }
		    function knotContentHover(obj) {
		        obj.hover(function () {
		            $(this).children('div').show();
		        }, function () {
		            $(this).children('div').hide();
		        });
		    }
		    function getData() {
		        $.ajax({
		            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: {
		                "PageName": "ResourceReservations/TimeIntervalHandler.ashx", "Func": "GetRadioData","ispage":"false"
		            },
		            success: OnSuccess,
		            error: OnError
		        });
		    }

		    //获取数据成功显示列表
		    function OnSuccess(json) {
		        if (json.result.errNum.toString() == "0") {
		            var id = "";
		            $(json.result.retData).each(function () {
		                $("ul.clearfix").append("<li class=\"fl\"><input type=\"radio\" name=\"radioButton\" id=" + this.Id + " value=" + this.TimeIntervalName + "><label for=\"\">" + this.TimeIntervalName + "</label></i>");
		            })
		            if ($("#HChapterID").val() == "" || $("#HChapterID").val() == undefined) {
		                GetActiveTreeIdAndName();
		            }
		            id = $("#HChapterID").val();
		            if (id != "") {
		                GetResourceIdRadio(id);
		            }
		            
		        } else {
		            $(".radioArea").html("无数据");

		            layer.msg(json.result.errMsg);

		        }
		    }

		    //获取数据失败显示无内容
		    function OnError(XMLHttpRequest, textStatus, errorThrown) {
		        $(".radioArea").html("无内容");
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
		                var caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick='addLeftMenu(" +
                         this.Id + "," + pid + ", this,\"" + divid + "\")'>添加</a><a href=\"javascript:void(0)\" onclick=\"EditMenu(this," +
                         this.Id + ",'" + this.Name + "')\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.Id + ")\">删除</a></div>";

		                if (pid == "0" && this.PId == pid) {
		                    if (i == 0) {
		                        $("#HChapterID").val(this.Id);
		                        chapterDiv += "<li class='active'>";
		                    }
		                    else { chapterDiv += "<li>"; }
		                    chapterDiv += "<div class=\"item_chapter\" id='" + divid + "' data-name='" + this.Name + "' onclick=\"changeMenu(this," + this.Id + ")\" ><span>" + this.Name +
                                "</span>" + "<i class=\"icona  icon-angle-down\"></i></div>";//caozuo + "<i class=\"icon  icon-angle-down\"></i></div>";
		                    i++;
		                    BindChapator(this.Id, this.PId, json);
		                    chapterDiv += "</li>";
		                }
		                if (pid != "0" && this.PId == pid) {
		                    caozuo = "<div class=\"btn-area\"><a href=\"javascript:void(0)\" onclick=\"EditMenu(" + this.Id +
                                 ")\">编辑</a>" + "<a href=\"javascript:void(0)\" onclick=\"DelMenu(" + this.Id + ")\">删除</a></div>";
		                    chapterDiv += "<li><div class=\"" + Itemclass + "\" id='" + divid + "' data-name='" + this.Name + "' onclick=\"changeMenu(this," + this.Id + ")\"><span>" + this.Name + "</span>" + "</div>";//caozuo + "</div>"
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

		    function ConfirmButton() {
		        var timeIntervalId = "";
		        var name = "";
		        GetActiveTreeIdAndName();
		        var resourceId = $("#HChapterID").val();
		        $("input[type='radio'][name='radioButton']").each(function(){
		            if (this.checked) {
		                timeIntervalId = this.id;
		            }
		        })
		        if (resourceId == "") {
		            layer.msg("请选择时间段!");
		        } else {
		            var UserName = $("#HUserName").val();
		            $.ajax({
		                url: "/Common.ashx",
		                type: "post",
		                async: false,
		                dataType: "json",
		                data: {
		                    "PageName": "ResourceReservations/ResourceTimeMappingIdHandler.ashx",
		                    Func: "AddResourceTimeMapping", "TimeIntervalId": timeIntervalId, "ResourceId": resourceId,
		                    "UserName": UserName
		                },
		                success: function (json) {
		                    var result = json.result;
		                    if (result.errNum == 0) {
		                        parent.layer.msg('操作成功!');
		                        parent.CloseIFrameWindow();
		                    } else {
		                        layer.msg(result.errMsg);
		                    }
		                },
		                error: function (XMLHttpRequest, textStatus, errorThrown) {
		                    layer.msg("操作失败！");
		                }
		            });
		        }
		    }
		    function GetActiveTreeIdAndName() {
		        $("#HChapterID").val('');
		        var Pid = "";
		        var PName = "";
		        $("li[class='active']").each(function () {
		            var treeId = $(this).find('div').attr("id");
		            if (treeId != null || treeId != undefined || treeId != "") {
		                Pid = treeId.substr(3);
		            }
		        });
		        $("#HChapterID").val(Pid);
		    }

		    function GetResourceIdRadio(id) {
		        //var id = "";
		        //GetActiveTreeIdAndName();
		        //id= $("#HChapterID").val();
		        $.ajax({
		            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: {
		                "PageName": "ResourceReservations/ResourceTimeMappingIdHandler.ashx", "Func": "GetResourceTimeMapping"
		                ,"ResourceId":id
		            },
		            success: function (json) {
		                if (json.result.errNum.toString() == "0") {
		                    $(json.result.retData).each(function () {
		                        if (this.TimeIntervalId != "" || this.TimeIntervalId != null) {
		                            $("input[type='radio'][name='radioButton'][id='" + this.TimeIntervalId + "']").each(function () {
		                                $(this).attr("checked", "checked");
		                                //$("#" + this.TimeIntervalId).attr("checked", true);
		                            })
		                        }
		                        else {
                                  
		                        }

		                    });

		                } 
		            },
		            error: function (errMsg) {
		                layer.msg(errMsg);
		            }
		        });

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

		    //获取活动的tree的ID和Name值
		    function GetActiveTreeIdAndName() {
		        $("#HChapterID").val('');
		        $("#HChapterName").val('');
		        var Pid = "";
		        var PName = "";

		        var treeId = $("#menu_side li.active").children("div").attr("id");
		        if (typeof (treeId) == "undefined") {
		            layer.msg("请选择一个时间段");
		        } else {
		            Pid = treeId.substring(3);
		            PName = $("ul li.active div").attr("data-name");
		        }
		        $("#HChapterID").val(Pid);
		        $("#HChapterName").val(PName);
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
		        stopEvent();
		    }

		    function changeMenu(obj,id) {
		        $("#HChapterID").val(id);
		        $("#radiotime>li").remove();
		        getData();
		    }
		</script>
	</body>
</html>
