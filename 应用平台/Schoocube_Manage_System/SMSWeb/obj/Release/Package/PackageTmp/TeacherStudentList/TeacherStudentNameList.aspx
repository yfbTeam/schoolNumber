<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeacherStudentNameList.aspx.cs" Inherits="SMSWeb.TeacherStudentList.TeacherStudentNameList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>师生名单</title>
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
    <style>
        .NameClass{    border: 2px solid #A1C8E6;background: #f1f7fb;margin-bottom: 10px;padding:20px 0px;}
        .NameClass div{padding:0px 20px;height:25px;line-height:25px;color:#666;font-size:14px;}
    </style>
</head>
<body>
    <%--<form id="form1" runat="server">--%>
        <input type="hidden" id="HChapterID" value="" />
        <input type="hidden" id="HChapterName" value="" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="HIds" runat="server" />
        <input type="hidden" id="HPId" />
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <div class="fl" style="width: 95px; height: 30px; border-left: 1px solid #fff; margin: 20px 0px 20px 5px; line-height: 30px; color: #fff; text-align: center; font-size: 18px;">
                师生名单
            </div>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li currentclass="active"><a href="TeacherStudentNameList.aspx">师生名单</a></li>
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
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="time_wrap clearfix width pt90" >
			<div class="menu fl">
				<div class="detail_items_title">
					年级
				</div>
				<ul class="item_sides" id="menu_side">
					
				</ul>
			</div>
			<div class="onlinetest_right fr bordshadrad" >
				<div style="padding: 0px 5px;" id ="TeacherStudent">
				</div>
			</div>
		</div>
   <%--</form>--%>
    <script src="../js/common.js"></script>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
		    $(function () {
		        Chapator();
		        $("#menu_side").html(chapterDiv);
		        getData();

		        $('#menu_side').find('li').children('div').click(function () {
		            $(this).parent('li').addClass('active').siblings().removeClass('active');
		        })
		        knotContentHover($('.item_chapter'));
		    })

		    function ClearActiveClass() {
		        $("#menu_side li").removeClass("active");
		    }
		    function knotContentHover(obj) {
		        obj.hover(function () {
		            $(this).children('div').show();
		        }, function () {
		            $(this).children('div').hide();
		        });
		    }
		    var name = "";
		    function getData() {
		        var gradeid = "";
		        gradeid = $("#HChapterID").val();
		        if (gradeid == "") {
		            GetActiveTreeIdAndName();
		            gradeid = $("#HChapterID").val();
		        }
		        $.ajax({
		            url: "../SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: { "Func": "GetClassStudentInfo", "GradeID": gradeid },
		            success: function (json) {
		                name = "";
		                if (json.result.errNum.toString() == "0") {
		                    $("#TeacherStudent").html('');
		                    $(json.result.retData).each(function (i, n) {
		                        var ClassName = n.ClassName;
		                        var Headteacher = n.Headteacher;
		                        var Teacher = n.Teacher;
		                        var Student = n.Student;
		                        var divid = "div" + n.Id;
		                        
		                        name += "<div class=\"NameClass\" id=\"teacherStudentName\"><div>班级：" + n.ClassName + "</div><div>班主任：" + n.Headteacher + "</div><div>教师：" + n.Teacher + "</div><div>学生：" + n.Student + "</div></div>";
		                        
		                    });
		                    $("#TeacherStudent").append(name);
		                } else {
		                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
		                    $("#TeacherStudent").html(html);
		                }

		            },
		            error: function (errMsg) {
		                layer.msg(errMsg);
		            }
		        });
		        if (name.length == 0) {
		            var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
		            $("#TeacherStudent").html(html);
		        }
		    }
		    var chapterDiv = "";
		    var i = 0;
		    function Chapator() {

		        $.ajax({
		            url: "../SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: { "Func": "GetGradeInfo" },
		            success: function (json) {
		                if (json.result.errNum.toString() == "0") {
		                    $(json.result.retData).each(function (i, n) {
		                        var divid = "div" + n.Id;
		                        if (i == 0) {
		                            chapterDiv += "<li class='active'>";
		                        } else {
		                            chapterDiv += "<li>";
		                        }
		                        chapterDiv += "<div class=\"item_chapter\" id='" + divid + "' data-name='" + n.GradeName + "' onclick=\"changeMenu(this," + n.Id + ")\" ><span>" + n.GradeName +
                                "师生名单</span></div>";
		                        i++;
		                    });
		                }

		            },
		            error: function (errMsg) {
		                layer.msg(errMsg);
		            }
		        });
		        if (chapterDiv.length == 0) {
		            layer.msg("无目录数据");
		        }
		    }
		    //获取活动的tree的ID和Name值
		    function GetActiveTreeIdAndName() {
		        $("#HChapterID").val('');
		        var Pid = "";
		        var PName = "";

		        var treeId = $("#menu_side li.active").children("div").attr("id");
		        if (typeof (treeId) == "undefined") {
		        } else {
		            Pid = treeId.substring(3);
		        }
		        $("#HChapterID").val(Pid);
		    }

		    function changeMenu(obj,id) {
		        $("#HChapterID").val(id);
		        $("#TeacherStudent> div[id='teacherStudentName']").each(function () {
		            $(this).remove();
		        })
		        var name = "";
		        getData();
		    }
		</script>
	</body>
</html>
