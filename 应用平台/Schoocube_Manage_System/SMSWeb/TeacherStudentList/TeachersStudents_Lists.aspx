<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TeachersStudents_Lists.aspx.cs" Inherits="SMSWeb.TeacherStudentList.TeachersStudents_Lists" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>师生名单</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css"/>
    <link rel="stylesheet" type="text/css" href="/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="/css/common.css"/>
    <link rel="stylesheet" type="text/css" href="/css/repository.css"/>
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css"/>
    <link href="/css/plan.css" rel="stylesheet" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style>
        .lists_right{width:918px;}
        .class_name{border:1px solid #9BC6E4;line-height:40px;}
        .class_name h1{height:40px;background:#66abda;color:#fff;font-size:16px;padding:0px 10px;}
        .class_lists a{width: 70px;
        height: 30px;
        display: block;
        float: left;
        line-height: 30px;
        text-align: center;
        font-size: 14px;
        color: #555;
        margin: 7px 0px;
        margin-left: 10px;
        cursor: pointer;}
        .class_lists a.on {
            color: #fff;
            background: #66ABDA;
        }
        .list_bars{border-bottom:2px solid #66ABDA;height:30px;margin-top:20px;}
        .list_bars a{width:75px;height:30px;line-height:30px;border-radius:4px 4px 0px 0px;line-height:32px;color:#fff;text-align:center;font-size:14px;background:#66ABDA;display:block;}
        .peoplelists{margin-left:-20px;}
        .peoplelists li {width:95px;height:100px;margin-top:15px;float:left;margin-left:20px;position:relative;}
         .peoplelists li .people_img{width:72px;height:72px;border:3px solid #eeeeee;border-radius:50%;overflow:hidden;}
         .peoplelists li .people_img img{width:100%;}
         .peoplelists li .people_name{height:22px;line-height:22px;text-indent:17px;color:#666;font-size:14px;}
         .peoplelists li .class_teacher{padding:3px 5px;border-radius:10px;position:absolute;top:3px;left:40px;font-size:14px;color:#fff;background:#97ca5d;display:inline-block;}
          .peoplelists li .monitor{padding:3px 5px;border-radius:10px;position:absolute;top:3px;left:40px;font-size:14px;color:#fff;background:#66ABDA;display:inline-block;}
    </style>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <form id="form1" runat="server">
    <div>
        <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" />
            </a>
            <div class="wenzi_tips fl">
                <img src="/images/shishengmingdan.png" />
            </div>
            <nav id="teacher" class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active">
                        <a href="/TeacherStudentList/TeachersStudents_Lists.aspx">师生名单</a>
                    </li>
                </ul>
            </nav>
            <div class="search_account fr clearfix">
                <ul class="account_area fl">
                    <li>
                        <a href="javascript:;" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">3</span>
                        </a>
                    </li>
                    <li>
                        <a href="javascript:;" class="login_area clearfix">
                           <div class="avatar">
                                <img src="<%=PhotoURL %>" />
                            </div>
                            <h2><%=Name %></h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
        <div class="onlinetest_item width pt90 pr " >
            <div  class="bordshadrad" style="background: #fff;padding:10px 20px;min-height:820px;">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">师生名单</a>   
                    </div>
                    <div class="stytem_select_right fr">
                        <select class="select" id="sel_year" onchange="GetClassData();"></select>
                    </div>
                </div>
                <div class="time_wrap clearfix mt20">
                    <div class="menu fl" >
				        <div class="detail_items_title">
					        年级
				        </div>
				        <ul class="item_sides bordshadrad" id="menu_side" style="min-height:600px;"></ul>
			        </div>
                    <div class="lists_right fr">
                        <div class="class_name">
                            <h1>班级</h1>
                            <div class="class_lists clearfix" id="div_GradeClass"></div>
                        </div>
                        <div id="div_TeaAndStu">
                            <div class="teacher_lists">
                                <div class="list_bars">
                                    <a href="javascript:;">教师名单</a>
                                </div>
                                <ul class="peoplelists clearfix" id="ul_teacherlist"></ul>
                            </div>
                            <div class="student_lists">
                                <div class="list_bars">
                                    <a href="javascript:;">学生名单</a>
                                </div>
                                <ul class="peoplelists clearfix" id="ul_studentlist"></ul>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
        <script type="text/javascript" src="/js/common.js"></script>
        <script type="text/javascript" src="/js/repository.js"></script>
    </form>
</body>
    <script type="text/javascript">
        var UrlDate = new GetUrlDate();
        $(function () {
            BindLearnYear();
        });
        function BindLearnYear() {
            $("#sel_year").val('');
            var option = "";
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { Func: "GetHistoryStudySection" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function (i, n) {
                            if (i == 0) {
                                option += "<option value=" + this.StudySection + " selected='selected'>" + this.StudySection + "</option>";
                            } else {
                                option += "<option value=" + this.StudySection + ">" + this.StudySection + "</option>";
                            }                            
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    $("#sel_year").append(option);
                    BindGrade();
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        var chapterDiv = "";
        function BindGrade() {
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
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
                            chapterDiv += "<div class=\"item_chapter\" id='" + divid + "' data-name='" + n.GradeName + "'><span>" + n.GradeName + "</span></div>";
                        });
                        $("#menu_side").html(chapterDiv);
                        GetClassData();
                        $('#menu_side').find('li').children('div').click(function () {
                            $(this).parent('li').addClass('active').siblings().removeClass('active');
                            GetClassData();
                        });
                        knotContentHover($('.item_chapter'));                        
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            if (chapterDiv.length == 0) {
                layer.msg("无年级数据");
            }
        }                
        function GetClassData() {
            var gradeid = $("#menu_side li.active").children("div").attr("id").substring(3);            
            $("#div_GradeClass").html('');
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetHistoryClassInfo", StudySection: $("#sel_year").val(), GradeID: gradeid },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var cla = "";
                        $(json.result.retData).each(function (i, n) {                            
                            if (i == 0) {
                                cla += '<a href="javascript:;" id="a_class_' + n.Id + '" class="on">' + n.ClassName + '</a>';
                            } else {
                                cla += '<a href="javascript:;" id="a_class_' + n.Id + '">' + n.ClassName + '</a>';
                            }
                        });
                        $("#div_GradeClass").append(cla);
                        GetTeaAndStu_Lists();
                        $('#div_GradeClass').find('a').click(function () {
                            $(this).addClass('on').siblings().removeClass('on');
                            GetTeaAndStu_Lists();
                        });
                    } else {
                        var html = '<a href="javascript:;">暂无班级</a>';
                        $("#div_GradeClass").html(html);
                        $("#ul_teacherlist").html('<li>暂无教师</li>');
                        $("#ul_studentlist").html('<li>暂无学生</li>');
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function GetTeaAndStu_Lists() {
            $("#ul_teacherlist").html('');
            $("#ul_studentlist").html('');
            $.ajax({
                url: "/SystemSettings/UserInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetTeaAndStu_List", Id: $("#div_GradeClass a.on").attr("id").replace("a_class_", "") },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var userinfo = json.result.retData[0];
                        $(userinfo.HeadteacherIDCard).each(function (i, n) {
                            $("#ul_teacherlist").append("<li onclick=\"GetCurTeacherInfo('" + n.IDCard + "');\"><a href='javascript:;'><div class='people_img'>"
                                  + "<img src='" + n.PhotoURL + "' onerror=\"javascript:this.src='/images/discuss_img_01.jpg';\"/>"
                                  + "</div><div class='people_name'>" + n.Name + "</div><div class='class_teacher'>班主任</div></a></li>");
                        });
                        $(userinfo.CourseTeacherIDCard).each(function (i, n) {
                            $("#ul_teacherlist").append("<li onclick=\"GetCurTeacherInfo('" + n.IDCard + "');\"><a href='javascript:;'><div class='people_img'>"
                                  + "<img src='" + n.PhotoURL + "' onerror=\"javascript:this.src='/images/discuss_img_01.jpg';\"/>"
                                  + "</div><div class='people_name'>" + n.Name + "</div></a></li>");
                        });
                        $(userinfo.HeadStudentIDCard).each(function (i, n) {
                            $("#ul_studentlist").append("<li><a href='javascript:;'><div class='people_img'>"
                                  + "<img src='" + n.PhotoURL + "' onerror=\"javascript:this.src='/images/discuss_img_01.jpg';\"/>"
                                  + "</div><div class='people_name'>" + n.Name + "</div><div class='monitor'>班长</div></a></li>");
                        });
                        $(userinfo.StudentsIDCard).each(function (i, n) {
                            $("#ul_studentlist").append("<li><a href='javascript:;'><div class='people_img'>"
                                  + "<img src='" + n.PhotoURL + "' onerror=\"javascript:this.src='/images/discuss_img_01.jpg';\"/>"
                                  + "</div><div class='people_name'>" + n.Name + "</div></a></li>");
                        });
                        if ($("#ul_teacherlist").find("li").length == 0) {
                            $("#ul_teacherlist").html('<li>暂无教师</li>');
                        }
                        if ($("#ul_studentlist").find("li").length == 0) {
                            $("#ul_studentlist").html('<li>暂无学生</li>');
                        }
                    } else {
                        //var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                        $("#ul_teacherlist").html('<li>暂无教师</li>');
                        $("#ul_studentlist").html('<li>暂无学生</li>');
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });            
        }
        function GetCurTeacherInfo(idcard) {
            OpenIFrameWindow('教师信息', 'TeacherInfo_Show.aspx?itemid=' + idcard+"&StudySection="+$("#sel_year").val()+"&ClassID="+$("#div_GradeClass a.on").attr("id").replace("a_class_", ""), '600px', '510px');
        }
        function knotContentHover(obj) {
            obj.hover(function () {
                $(this).children('div').show();
            }, function () {
                $(this).children('div').hide();
            });
        }
    </script>
</html>