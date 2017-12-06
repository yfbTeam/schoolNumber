<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Learning_center_portal.aspx.cs" Inherits="SMSWeb.PersonalSpace.Learning_center_portal" %>

<!DOCTYPE html>

<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>学生中心</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/js/common.js"></script>
    <!--[if IE]>
    <script src="/js/html5.js"></script>
    <![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <%--课程通知列表的绑定--%>
    <script id="li_notice_course" type="text/x-jquery-tmpl">
        <li class="clearfix" onclick="Notice_CourseClick(this,'${Id}','${RelId}');">
            <%--<div class="discuss_img fl">
                <img src="/images/test_img.png" />
            </div>--%>
            <div class="discuss_description fl">
                <h2>
                    <a href="javascript:;">${Title}</a>
                    {{if IsRead==0}}<span class="test_normal" id="span_read0_${Id}">未读</span>{{else}}<span class="test_type" id="span_read1_${Id}">已读</span>{{/if}}                                     
                    <span class="discuss_date fr">${CreateTime_Format}</span>
                </h2>

            </div>
        </li>
    </script>
    <script id="li_CourseNotice" type="text/x-jquery-tmpl">
        <li class="clearfix" onclick="CourseNoticeDetail(${Id})">
            <div class="discuss_description fl">
                <h2>
                    <a href="javascript:;">${Title}</a>
                    <span class="discuss_date fr">${DateTimeConvert(CreateTime,'yyyy-MM-dd HH:mm')}</span>
                </h2>
            </div>
        </li>
    </script>


    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <li onclick="CourseDetail(${ID},'${EndTime}')" style="cursor: pointer">
            <div class="allcourse_img">
                <img src="${ImageUrl}" alt="" />
            </div>
            <div class="course_type course_bixiu">
                {{if CourceType==1}}<span>线下课程</span>{{else}}<span>线上课程</span>{{/if}}
            </div>
            <div class="couese_title">
                ${LecturerName}
            </div>
            <p class="course_name"><span>${Name}</span>{{if CurrentType==4}}<a href="#" class="course_enroll" onclick='SinUp(${ID})'>立即报名</a> {{/if}}</p>
        </li>

    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
    <input type="hidden" id="HUserName" value="<%=Name %>" />
    <input type="hidden" id="Hid_ClassID" value="<%=ClassID %>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                <img src="/images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li class="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                    <li><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                    <li><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                    <li><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                    <li><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                    <li><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                    <li><a href="/analysisa/student_studyprocess(4).aspx">个人学习进度</a></li>
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
                            <h2><%=Name %>
                            </h2>
                        </a>
                    </li>
                </ul>
                <div class="settings fl pr ">
                    <a href="javascript:;">
                        <i class="icon icon-cog"></i>
                    </a>
                    <div class="setting_none">
                        <a href="/Gopay/Pay_Index.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span>个人中心</span></a>

                        <span onclick="logOut()">退出</span>

                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="students_wrap pt90 pb20">
        <div class="courseinex_wrap width">
            <div class="courseindex clearfix" style="margin-top: 0px;">
                <div class="fl" style="">
                    <div class="courseindex_left bordshadrad">
                        <div class="stytem_select clearfix">
                            <div class="stytem_select_left fl">
                                <a href="javascript:;" class="on">全部课程</a>
                            </div>
                            <div class="stytem_select_right fr clearfix">
                                <label for="" style="float: left; line-height: 40px; font-size: 14px; color: #555;">课程分类：</label>
                                <select name="" id="CoursseType" class="select" onchange="getData(1,8)">
                                    <option value="1">所有课程</option>
                                    <option value="2">已注册课程</option>
                                    <option value="3">可匿名访问课程</option>
                                    <option value="4">可注册课程</option>
                                </select>
                            </div>
                        </div>
                        <!--没有注册课程的时候-->
                        <div class="nocourse none">
                            <div class="nocourse_center">
                                <p>您尚未注册任何课程</p>
                                <h1>点击<a href="javscript:;" class="course_btn btnprice_bgfree">创建课程</a>进行创建吧！</h1>
                            </div>
                        </div>
                        <ul class="allcourses clearfix" id="tb_Cource" style="min-height:364px;">
                        </ul>
                        <!--分页-->
                        <div class="page">
                            <span id="pageBar"></span>
                        </div>
                    </div>
                    <div class="notice_wrap mt20 bordshadrad" style="width: 918px; min-height: 425px;">
                        <div class="stytem_select clearfix">
                            <div class="stytem_select_left fl">
                                <a href="javascript:;" class="on">课程通知</a>
                                <a href="javascript:;" onclick="GetCourseNotice(0)">班级通知</a>
                                <a href="javascript:;" onclick="GetCourseNotice(1)">班级动态</a>
                            </div>
                        </div>
                        <div class="notice_con">
                            <ul class="discuss_lists discuss_listsa" id="ul_notice_course"></ul>
                            <ul class="discuss_lists discuss_listsa none" id="ul_CourseNotice">
                                <%--<li class="clearfix">                                   
                                    <div class="discuss_description fl">
                                        <h2>
                                            <a href="javascript:;">下周二模拟考试</a>
                                            <span class="test_type">已读</span>
                                            <span class="discuss_date fr">2017-04-13</span>
                                        </h2>

                                    </div>

                                </li>--%>
                            </ul>
                            <ul class="discuss_lists none discuss_listsa" id="ul_CourseNotice1">
                                <%--<li class="clearfix">
                                  
                                    <div class="discuss_description fl">
                                        <h2>
                                            <a href="javascript:;">围棋社比赛</a>
                                            <span class="test_type">已读</span>
                                            <span class="discuss_date fr">2017-05-13</span>
                                        </h2>

                                    </div>

                                </li>--%>
                            </ul>

                        </div>
                    </div>
                </div>
                <div class="studends_center_right fr" style="width: 220px;">
                    <div class="personal_mes bordshadrad" style="height: auto; background: #fff;">
                        <div class="personal_img">
                            <img src="<%=PhotoURL %>" alt="" />
                        </div>
                        <div class="personal_name">
                            <%=Name %>
                        </div>
                        <a href="PersonalSpace_Student.aspx" class="enter_my" style="margin-top: 10px" target="_blank">个人中心</a>
                        <%--<div class="personalspace_mes clearfix">
                            <div class="personalspace_mes_com fl">
                                <p>讨论</p>
                                <b>3</b>
                            </div>
                            <div class="personalspace_mes_homework fr">
                                <p>作业</p>
                                <b>13</b>
                            </div>
                        </div>--%>
                    </div>
                    <div class="courseindex_right bordshadrad mt20" style="height: auto;">
                        <p class="learned_title">我的社区</p>
                        <ul class="community_lists clearfix">
                            <li>
                                <a href="LearningZone.aspx" target="_blank">
                                    <div class="community_img">
                                        <img src="/images/community_01.png" alt="" class="" style="transition: all 0.6s 0.3s;">
                                    </div>
                                    <p class="community_name">学习区</p>
                                </a>
                            </li>
                            <li>
                                <a href="LieZone.aspx" target="_blank">
                                    <div class="community_img">
                                        <img src="/images/community_02.png" alt="" class="" style="transition: all 0.6s 0.3s;">
                                    </div>
                                    <p class="community_name">休闲区</p>
                                </a>
                            </li>
                            <li>
                                <a href="EmploymentZone.aspx" target="_blank">
                                    <div class="community_img">
                                        <img src="/images/community_03.png" alt="" class="" style="transition: all 0.6s 0.3s;">
                                    </div>
                                    <p class="community_name">就业区</p>
                                </a>
                            </li>
                            <li>
                                <a href="LivingZone.aspx" target="_blank">
                                    <div class="community_img">
                                        <img src="/images/community_04.png" alt="" class="" style="transition: all 0.6s 0.3s;">
                                    </div>
                                    <p class="community_name">生活区</p>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="courseindex_right bordshadrad mt20" style="height: auto;">
                        <p class="learned_title">社区动态</p>
                        <ul class="topcourse_list">
                            <li>
                                <a href="LieZone.aspx">
                                    <p class="topcourse_list_name"><span>1.</span>校园篮球比赛排名公布</p>
                                    <div class="topcourse_list_img" style="display: block;">
                                        <img src="/images/tui_03.png" alt="" />
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="LieZone.aspx">
                                    <p class="topcourse_list_name"><span>2.</span>餐厅好吃的饭是什么？</p>
                                    <div class="topcourse_list_img">
                                        <img src="/images/tui_03.png" alt="" />
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="EmploymentZone.aspx">
                                    <p class="topcourse_list_name"><span>3.</span>前端工程师如何进入Bat公司就职</p>
                                    <div class="topcourse_list_img">
                                        <img src="/images/tui_03.png" alt="" />
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="EmploymentZone.aspx">
                                    <p class="topcourse_list_name"><span>4.</span>就业面试指导</p>
                                    <div class="topcourse_list_img">
                                        <img src="/images/tui_03.png" alt="" />
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="LivingZone.aspx">
                                    <p class="topcourse_list_name"><span>5.</span>学校里帅锅是谁？</p>
                                    <div class="topcourse_list_img">
                                        <img src="/images/tui_03.png" alt="" />
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/PortalImages/logoBefore.png" alt="" style="margin-top: 10px;" />
            </div>
            <div class="footer_right fr">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>
                    传真：010-62463259   网址：<a
                        href="http://www.bjybjx.cn" target="_blank" style="color: #fff;">http://www.bjybjx.cn</a>
                </p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
            </div>
        </div>
    </footer>
    <script src="/js/common.js" type="text/javascript"></script>
    <script>
        function Mycenter() {
            window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
        }
        $(function () {
            $('.stytem_select_left>a').click(function () {
                $(this).addClass('on').siblings().removeClass('on');
                var n = $(this).index();
                $('.notice_con>ul').eq(n).show().siblings().hide();
            })
            $('.topcourse_list li').hover(function () {
                $('.topcourse_list li').find('div').hide();
                $(this).find('div').show();
            })
            //评论显示
            $('.comment').click(function () {
                $(this).parents('li').find('.comment_wrap').toggle();
            })
        })
        //学生报名
        function SinUp(ID) {

            var Stu = $("#HUserIdCard").val();
            var StuName = $("#HUserName").val();
            $.ajax({
                type: "Post",
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                data: { "PageName": "CourseManage/CourceManage.ashx", Func: "SingUp", CourseID: ID, StuNo: Stu, StuName: StuName },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum == "0") {
                        layer.msg("报名成功");
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
            stopEvent();
        }
    </script>
    <script type="text/javascript">
        $(function () {
            getData(1, 8);
            GetNotice_CourseDataPage(1, 6);
        });
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
        function getData(startIndex, pageSize) {

            $("#tb_Cource").html("");
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            var ClassID = $("#Hid_ClassID").val();
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "GetMyLessonsByType",
                    StuNo: $("#HUserIdCard").val(),
                    ClassID: ClassID,
                    PageIndex: startIndex,
                    pageSize: pageSize,
                    CourseType: $("#CoursseType").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(".page").show();
                        var data = json.result.retData.PagedData;
                        $("#li_mylessons").tmpl(data).appendTo("#tb_Cource");
                        makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $(".page").hide();
                        layer.msg(json.result.errMsg);
                    }
                },
                error: function (errMsg) {
                    $(".page").hide();
                    layer.msg(errMsg);
                }
            });
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
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    $("#ul_notice_course").html(json.result.errMsg.toString());
                }
            });
        }
        function GetCourseNotice(Type) {
            //初始化序号 
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    Func: "StuMessage",
                    ClassID: $("#Hid_ClassID").val(),
                    Type: Type
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        if (Type == 0) {
                            $("#ul_CourseNotice").html('');
                            $("#li_CourseNotice").tmpl(json.result.retData).appendTo("#ul_CourseNotice");
                        }
                        else {
                            $("#ul_CourseNotice1").html('');

                            $("#li_CourseNotice").tmpl(json.result.retData).appendTo("#ul_CourseNotice1");
                        }
                    }
                    else {
                        if (Type == 0) {
                            $("#ul_CourseNotice").html("暂无数据！");
                        }
                        else {
                            $("#ul_CourseNotice1").html("暂无数据！");
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    if (Type == 0) {
                        $("#ul_CourseNotice").html(json.result.errMsg.toString());
                    }
                    else {
                        $("#ul_CourseNotice1").html(json.result.errMsg.toString());
                    }
                }
            });
        }
        function CourseNoticeDetail(ID) {
            OpenIFrameWindow('详情', 'NoticeDetail.aspx?ID=' + ID+ "&Type=1", '400px', '300px');
        }
        function Notice_CourseClick(obj, noticeid, relid) {
            OpenIFrameWindow('通知详情', 'NoticeDetail.aspx?noticeid=' + noticeid + "&relid=" + relid + "&Type=2", '400px', '300px');
            //$.ajax({
            //    url: "/Common.ashx",
            //    type: "post",
            //    async: false,
            //    dataType: "json",
            //    data: {
            //        PageName: "/OnlineLearning/NoticeHandler.ashx",
            //        Func: "GetNotice_CourseById",
            //        ItemId: noticeid
            //    },
            //    success: function (json) {
            //        if (json.result.errNum.toString() == "0") {
            //            var model = json.result.retData;
            //            layer.tips('标题：' + model.Title + '</br>内容：' + model.Contents, obj, {
            //                tips: [2, '#3595CC']
            //            });
            //        }
            //        else {
            //            layer.msg(json.result.errMsg);
            //        }
            //    },
            //    error: function (errMsg) {
            //        layer.msg(errMsg);
            //    }
            //});
            //OperNotice_CourseSeeRel(noticeid, relid);
        }
        function accountManagement() {
            //window.location.href = "/Gopay/Gopay.aspx";
            window.open("/Gopay/Gopay.aspx", "_blank")
        }
    </script>
</body>
</html>
