<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="students_index.aspx.cs" Inherits="SMSWeb.CourseManage.students_index" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学生首页</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script id="tr_User" type="text/x-jquery-tmpl">
        {{if rowNum%2==1}}    
        <div class="courseside bordshadrad fl">
            {{else}}         
            <div class="courseside bordshadrad fr">
                {{/if}}
            <a href="/OnlineLearning/StuLessonDetail.aspx?itemid=${ID}&flag=0">
                <div class="students_img">
                    <img src="${ImageUrl}" alt="" /></div>
                <p><span class="course_name fl">${Name}</span> <span class="course_succ fr">{{if AllWeight==0}}0%{{else}}${Math.round(ComWeight/AllWeight * 10000) / 100.00 + "%"}{{/if}}</span></p>
                <h1>
                    <div class="fl">
                        <em class="icons">
                            <i class="icon icon_people"></i>
                        </em>
                        <span>${StuMaxCount}人</span>
                    </div>
                    <div class="fl">
                        <em class="icons">
                            <i class="icon icon_discuss"></i>
                            <b>${TopicCount}</b>
                        </em>
                        <span>讨论</span>
                    </div>
                    <div class="fl">
                        <em class="icons">
                            <i class="icon icon_test"></i>
                            <b>${AllCount-ComCount}</b>
                        </em>
                        <span>任务</span>
                    </div>
                </h1>
            </a>
            </div>
    </script>
    <%--课程通知列表的绑定--%>
    <script id="li_notice_course" type="text/x-jquery-tmpl">
        <li class="clearfix" onclick="Notice_CourseClick(this,'${Id}','${RelId}');">
            <div class="discuss_img fl">
                <img src="/images/test_img.png" />
            </div>
            <div class="discuss_description fl">
                <h2>
                    <a href="javascript:;">${Title}</a>
                    {{if IsRead==0}}<span class="test_normal" id="span_read0_${Id}">未读</span>{{else}}<span class="test_type" id="span_read1_${Id}">已读</span>{{/if}}                                     
                    <span class="discuss_date fr">${CreateTime_Format}</span>
                </h2>
                <%--<h1 class="clearfix">
                    <div class="discuss-wrap fr">
                        <div class="fl">
                            <i class="icon icon-eye-open"></i>
                            <span>(0)</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon-comment-alt"></i>
                            <span>(0)</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon-hand-right"></i>
                            <span>(0)</span>
                        </div>
                    </div>
                </h1>--%>
            </div>
        </li>
    </script>
    <script type="text/javascript">
        var courseArray,allPage=1,curindex=1;        
        $(function () {
            BindData();
            GetNotice_CourseDataPage(1, 6);
        });
        function BindData() {
            var ClassID = $("#HClassID").val();
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsDataPage",
                    StuNo: $("#HUserIdCard").val(),
                    ClassID: ClassID,
                    ispage:false,
                    PageIndex: 1,
                    pageSize: 10,
                    OperSymbol: ">"
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var data=json.result.retData;
                        courseArray = data;
                        allPage = Math.ceil(data.length * 1.0 / 2);
                        $("#tr_User").tmpl(courseArray[0]).appendTo("#tb_Cource");
                        if (courseArray.length > 1) {
                            $("#tr_User").tmpl(courseArray[1]).appendTo("#tb_Cource");
                        }
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    hoverEnlarge($('.courseside a img'));
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        function Next(type) {
            if (type == -1 && curindex == 1) {
                layer.msg("已经是第一条数据");
                return;
            }
            if (type == 1 && curindex == allPage) {
                layer.msg("已经是最后一条数据");
                return;
            }
            curindex = type == -1 ? curindex - 1 : curindex + 1;
            var curnum = (curindex - 1) * 2;
            $("#tb_Cource").html('');
            $("#tr_User").tmpl(courseArray[curnum]).appendTo("#tb_Cource");
            if (curnum + 2 <= courseArray.length) {
                $("#tr_User").tmpl(courseArray[curnum + 1]).appendTo("#tb_Cource");
            }            
        }
        function GetNotice_CourseDataPage(startIndex, pageSize) {
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "GetNotice_CourseDataPage",
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    StuIDCard: $("#HUserIdCard").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#ul_notice_course").html('');
                        $("#li_notice_course").tmpl(json.result.retData.PagedData).appendTo("#ul_notice_course");
                    }
                    else {
                        $("#ul_notice_course").html("暂无课程通知！");
                    }
                },
                error: function (errMsg) {
                    $("#ul_notice_course").html(errMsg);
                }
            });
        }
        function Notice_CourseClick(obj,noticeid, relid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "GetNotice_CourseById",
                    ItemId: noticeid
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        var model = json.result.retData;
                        layer.tips('标题：' + model.Title + '</br>内容：' + model.Contents, obj, {
                            tips: [2, '#3595CC']//,
                            //time: 4000
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
            OperNotice_CourseSeeRel(noticeid, relid);
        }
        function OperNotice_CourseSeeRel(noticeid,relid) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/NoticeHandler.ashx",
                    Func: "OperNotice_CourseSeeRel",
                    ItemId: relid,
                    NoticeId:noticeid,
                    UserIdCard: $("#HUserIdCard").val(),
                    UserName: $("#HUserName").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (relid == 0)
                        {
                            $("#span_read0_" + noticeid).removeClass("test_normal").addClass("test_type");
                            $("#span_read0_" + noticeid).html("已读");
                        }                        
                    }
                },
                error: function (errMsg) {

                }
            });
        }
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li class="active"><a href="students_index.aspx">学生首页</a></li>
                    <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                    <li currentclass="active"><a href="Cource_OnlineChose.aspx">在线选课</a></li>
                    <li currentclass="active"><a href="/Exam/MyExam.aspx">在线考试</a></li>
                    <li currentclass="active"><a href="class_question.html">问卷调查</a></li>
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
                            <h2><%--<%=Name %>--%></h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
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
    <!--学生-->
    <div class="students_wrap pt90 pb20">
        <div class="studends_center width clearfix">
            <div class="studends_center_left fl">
                <div class="course_sides">
                    <ul class="sides">
                        <li id="tb_Cource">
                            <%--<div class="courseside bordshadrad fl">
                                <a href="javascript:;">
                                    <img src="../images/course_img_03.png" alt="" /></a>
                                <p><span class="course_name fl">循序渐进学摄影1</span> <span class="course_succ fr">50%</span></p>
                                <h1>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_people"></i>
                                        </em>
                                        <span>80人</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_discuss"></i>
                                            <b>3</b>
                                        </em>
                                        <span>讨论</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_test"></i>
                                            <b>13</b>
                                        </em>
                                        <span>任务</span>
                                    </div>
                                </h1>
                            </div>--%>
                            <%--<div class="courseside bordshadrad fr">
                                <a href="javascript:;">
                                    <img src="../images/course_img_06.png" /></a>
                                <p><span class="course_name fl">循序渐进学摄影2</span> <span class="course_succ fr">50%</span></p>
                                <h1>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_people"></i>
                                        </em>
                                        <span>110人</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_discuss"></i>
                                            <b>3</b>
                                        </em>
                                        <span>讨论</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_test"></i>
                                            <b>16</b>
                                        </em>
                                        <span>任务</span>
                                    </div>
                                </h1>
                            </div>--%>
                        </li>
                        <%--<li>
                            <div class="courseside bordshadrad fl">
                                <a href="javascript:;">
                                    <img src="../images/course_img_06.png" alt="" /></a>
                                <p><span class="course_name fl">循序渐进学摄影3</span> <span class="course_succ fr">50%</span></p>
                                <h1>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_people"></i>
                                        </em>
                                        <span>100人</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_discuss"></i>
                                            <b>3</b>
                                        </em>
                                        <span>讨论</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_test"></i>
                                            <b>13</b>
                                        </em>
                                        <span>任务</span>
                                    </div>
                                </h1>
                            </div>
                            <div class="courseside bordshadrad fr">
                                <a href="javascript:;">
                                    <img src="../images/course_img_03.png" /></a>
                                <p><span class="course_name fl">循序渐进学摄影4</span> <span class="course_succ fr">50%</span></p>
                                <h1>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_people"></i>
                                        </em>
                                        <span>110人</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_discuss"></i>
                                            <b>3</b>
                                        </em>
                                        <span>讨论</span>
                                    </div>
                                    <div class="fl">
                                        <em class="icons">
                                            <i class="icon icon_test"></i>
                                            <b>16</b>
                                        </em>
                                        <span>任务</span>
                                    </div>
                                </h1>
                            </div>
                        </li>--%>
                    </ul>
                    <a class="prev" href="javascript:void(0)" onclick="Next(-1)"><i class="icon icon-angle-left"></i></a>
                    <a class="next" href="javascript:void(0)" onclick="Next(1)"><i class="icon icon-angle-right"></i></a>
                </div>
                <div class="notice_wrap mt20 bordshadrad">
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <%--<a href="javascript:;" >班级动态</a>--%>
                            <a href="javascript:;" class="on">课程通知</a>
                            <%--<a href="javascript:;">系统通知</a>--%>
                        </div>
                    </div>
                    <div class="notice_con">
                        <ul class="discuss_lists" id="ul_notice_course"></ul>
                        <ul class="discuss_lists none">
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">在Word中，要将第一自然段移到文件后，需要进行的操作是（       ）   A.复制、粘贴</a>
                                        <span class="test_type">课程通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">一年语文课程</a>
                                        <span class="test_normal">系统通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                        </ul>
                        <ul class="discuss_lists none">
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">在Word中，要将第一自然段移到文件的最后，进行的操作是（       ）   A.复制、粘贴</a>
                                        <span class="test_type">课程通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">一年语文课程</a>
                                        <span class="test_normal">系统通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(0)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">在Word中，要将第一自然段移到文件的最后，进行的操作是（       ）   A.复制、粘贴</a>
                                        <span class="test_type">课程通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(30)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(30)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                            <li class="clearfix">
                                <div class="discuss_img fl">
                                    <img src="../images/test_img.png" />
                                </div>
                                <div class="discuss_description fl">
                                    <h2>
                                        <a href="javascript:;">一年语文课程</a>
                                        <span class="test_normal">系统通知</span>
                                        <span class="discuss_date fr">2015-04-13</span>
                                    </h2>
                                    <h1 class="clearfix">
                                        <div class="discuss-wrap fr">
                                            <div class="fl">
                                                <i class="icon icon-eye-open"></i>
                                                <span>(20)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-comment-alt"></i>
                                                <span>(20)</span>
                                            </div>
                                            <div class="fl">
                                                <i class="icon icon-hand-right"></i>
                                                <span>(0)</span>
                                            </div>
                                        </div>
                                    </h1>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="studends_center_right fr ">
                <div class="personal_mes bordshadrad">
                    <div class="personal_img">
                        <img src="/images/teacher_img.png" alt="" />
                    </div>
                    <div class="personal_name"><%--<%=Name %>--%></div>
                    <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank" class="enter_my">我的空间</a>
                </div>
                <div class="wait_for mt20 bordshadrad">
                    <h1>待办</h1>
                    <ul>
                        <li><a href="javascript:;">你有10个考试未完成</a></li>
                        <li><a href="javascript:;">你还有课程未报名</a></li>
                        <li><a href="javascript:;">第三节拖延症的危害</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="../images/footer_logo.png" alt="" />
            </div>
            <div class="footer_tip fl"></div>
            <div class="footer_right fr">
                <p>北京市黄庄职业高中信息中心 制作维护</p>
                <p>地址：北京市石景山区鲁谷东街29号 邮编：100040   电话：010-68638293   传真：010-68638293</p>
                <p>icp 京ICP备07012769号 | 京公网安备11010702001098号</p>
            </div>
        </div>
    </footer>
    <script src="../js/common.js"></script>
    <script src="../js/jquery.SuperSlide.2.1.1.js"></script>
    <%--<script>
        $(function () {
            $('.stytem_select_left>a').click(function () {
                $(this).addClass('on').siblings().removeClass('on');
                var n = $(this).index();
                $('.notice_con>ul').eq(n).show().siblings().hide();
            })
            /*SuperSlide图片切换*/
            jQuery(".course_sides").slide({ mainCell: ".sides", effect: "leftLoop", autoPlay: false, delayTime: 600, trigger: "click" });
        })
    </script>--%>
</body>
</html>
