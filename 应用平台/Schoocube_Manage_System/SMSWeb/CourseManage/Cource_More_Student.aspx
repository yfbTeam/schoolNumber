<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Cource_More_Student.aspx.cs" Inherits="SMSWeb.CourseManage.Cource_More_Student" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>课程首页</title>
    <meta charset="utf-8" />
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.cookie.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/CourseMenu.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/Power.js"></script>

    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script type="text/x-jquery-tmpl" id="tr_Cource">
        <li>
            <div class="allcourse_img" onclick="CourseDetail(${ID},'${EndTime}')" style="cursor: pointer">
                <img src="${ImageUrl}" alt="" />
            </div>
            {{if CourceType==2}}<div class="course_type course_xuanxiu">线上课程</div>
            {{else}}<div class="course_type course_bixiu">线下课程</div>
            {{/if}}
            <div class="couese_title">
                ${Name}
            </div>
            <p class="course_name">
                <span>${GradeName}</span>
                {{if stuNo==""}}<a class="course_enroll" href='#' onclick='SinUp(${ID},${RigistType})'>立即报名</a>
                {{else}} <a href="#" class="course_enroll">已报名</a>
                {{/if}}
            </p>
        </li>
    </script>

    <script type="text/javascript">
        function CourseDetail(ID, EndTime) {
            var now = new Date();

            var date1 = new Date(now);
            var date2 = new Date(EndTime);
            if (date2 > date1) {
                window.location.href = "/OnlineLearning/StuLessonDetail.aspx?itemid=" + ID + "&flag=0";
            }
            else {
                layer.msg("该课程已经结束");
            }
        }
        //var UrlDate = new GetUrlDate();

        $(function () {
            //$("#CourceIndex").attr("href", "/CourseManage/CourseIndex.aspx?ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName)

            CourceMenu();
            BindData();
            HotCourse();
        })
        function BindData() {
            var Stu = $("#HUserIdCard").val();
            var ClassID = $("#HClassID").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetCourseByType", Stu: Stu, CourceType: 2, ClassID: ClassID, "Num": 100 },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#tb_AllCource").html('');
                        $("#tr_Cource").tmpl(json.result.retData).appendTo("#tb_AllCource");
                    }
                    else {
                        layer.msg(json.result.errMsg);
                        var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                        $("#tb_AllCource").html(html);
                    }
                    hoverEnlarge($('.allcourses li .allcourse_img img'));
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function HotCourse() {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "HotCourse" },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var i = 1;
                        var Display = "";
                        $(json.result.retData).each(function () {
                            if (i == 1) {
                                Display = "block";
                            }
                            else {
                                Display = "none";
                            }
                            var li = " <li><a href=\"javascript:;\"><p class=\"topcourse_list_name\"><span>" + i
                                + ".</span>" + this.Name + "</p><div class=\"topcourse_list_img\" style=\"display: " + Display + ";\"><img src=\"" +
                                this.ImageUrl + "\" alt=\"\" /></div></a></li>";
                            i++;
                            $("#tb_Hot").append(li);
                        })
                        $('.topcourse_list li').hover(function () {
                            $('.topcourse_list li').find('div').hide();
                            $(this).find('div').show();
                        })

                    }
                    else {
                        layer.msg(json.result.errMsg);
                        var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                        $("#tb_Hot").html(html);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        //学生报名
        function SinUp(ID, RigistType) {
            if (RigistType == 0) {
                registSing(ID, '');
            }
            else {
                OpenIFrameWindow('课程注册', 'CourseCommand.aspx?ID=' + ID, '300px', '180px');
            }
        }
        function registSing(ID, Command) {
            var Stu = $("#HUserIdCard").val();
            $.ajax({
                type: "Post",
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                data: { "PageName": "CourseManage/CourceManage.ashx", Func: "SingUp", CourseID: ID, StuNo: Stu, Command: Command },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum == "0") {
                        layer.msg("报名成功");
                        sendMsg(ID);
                        BindData();
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

        function sendMsg(courseId) {
            if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") { return; }
            var info = $.parseJSON($.cookie('LoginCookie_Cube'));
            $.ajax({
                type: "Post",
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                async: false,
                dataType: "json",
                data: {
                    "PageName": "PortalManage/MessageHandler.ashx",
                    "Func": "SendMessageForCourse",
                    "courseID": courseId,
                    "Type": 8,
                    "Receiver": info.IDCard,
                    "ReceiverName": info.Name,
                    "Timing": 0
                },
                dataType: "json",
                success: function (json) {

                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <input type="hidden" id="HUserName" value="<%=Name %>" />
        <input type="hidden" id="HClassID" value="<%=ClassID %>" />

        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="/images/coursesystem.png" />
                </div>--%>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li class="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                        <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                        <li currentclass="active"><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
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
        <div class="onlinetest_item width pt90">
        </div>
        <div class="courseinex_wrap mb10 width">
            <div class="courseindex clearfix" style="margin-top: 0px;">
                <div class="courseindex_left fl bordshadrad">
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a id="CourceIndex">在线选课</a>
                            <span>></span>
                            <a href="#">全部课程</a>
                        </div>
                        <!--面包屑-->

                        <%--<div class="stytem_select_right fr">
                            <div class="search_exam fl pr">
                                <select class="select" id="CourseType" onchange="BindData(1,12)">
                                    <option value="">课程类型</option>
                                    <option value="1">线下课程</option>
                                    <option value="2">线上课程</option>

                                </select>
                            </div>
                        </div>--%>
                    </div>
                    <ul class="allcourses clearfix" id="tb_AllCource">
                    </ul>
                    <!--分页-->
                    <div class="page">
                        <span id="pageBar"></span>
                    </div>
                </div>
                <div class="courseindex_right fr bordshadrad">
                    <p class="learned_title">热门选课排行榜</p>
                    <ul class="topcourse_list" id="tb_Hot">
                    </ul>
                </div>
            </div>
        </div>
        <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
        <script src="/js/system.js"></script>
        <script>
            $('.topcourse_list li').hover(function () {
                $('.topcourse_list li').find('div').hide();
                $(this).find('div').show();
            })
        </script>
    </form>
</body>
</html>
