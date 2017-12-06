<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyLessons.aspx.cs" Inherits="SMSWeb.OnlineLearning.MyLessons" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>在线学习</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script type="text/javascript" src="js/menu_top.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../js/menu_top.js"></script>
    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <li class="clearfix" onclick="CourseDetailClick('${ID}','${OperSymbol}');">
            <div class="before-line1 line"></div>
            <div class="before-line2 line"></div>
            <div class="before-line3 line"></div>
            <div class="after-line1 line"></div>
            <div class="after-line2 line"></div>
            <div class="after-line3 line"></div>
            <div class="mycourse_img fl">
                <img src="${ImageUrl}" alt="" onerror="javascript:this.src='/images/course_default.jpg'" />
            </div>
            <div class="fl mycourse_mes">
                <h1 class="mycourse_name">${Name}</h1>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        主讲老师：<span>${LecturerName} </span>
                    </div>
                    <div class="fl course_type">
                        课程类别：{{if CourceType==1}}<span>必修课</span>{{else}}<span>选修课</span>{{/if}}
                    </div>
                    <div class="fl class_venue">
                        上课场地：<span>${StudyPlace}</span>
                    </div>
                    <div class="fl people_number">
                        选课人数上限：<span>${StuMaxCount}</span>
                    </div>
                    <div class="fl course_time">
                        开课时间：<span>${DateTimeConvert(StartTime)}~${DateTimeConvert(EndTime)}</span>
                    </div>
                </h2>
                <div class="course_desc" style="line-height:22px;max-height:88px;display: -webkit-box; -webkit-line-clamp: 4;-webkit-box-orient: vertical;overflow:hidden;text-overflow:ellipsis;">${CourseIntro}</div>
                <div class="succ_detaillist">
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            选课人员
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_people"></i>
                            </em>
                            <span>${CourseSels}人</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            新讨论
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_discuss"></i>
                                <b>${TopicCount}</b>
                            </em>
                            <span>讨论</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            待完成任务
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_test"></i>
                                <b>${AllCount-ComCount}</b>
                            </em>
                            <span>任务</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            课程完成度
                        </div>
                        <div class="detaillist_desc">
                            <span class="succ_process">{{if AllWeight==0}}0%{{else}}${Math.round(ComWeight/AllWeight * 10000) / 100.00 + "%"}{{/if}}</span>
                        </div>
                    </div>
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            任务完成度
                        </div>
                        <div class="detaillist_desc">
                            <span>${ComCount}</span>/<span>${AllCount}</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="process_outer">                
                <div class="process_innera" {{if AllWeight==0}}style="width:0%;"{{else}}style="width:${Math.round(ComWeight/AllWeight * 10000) / 100.00 + "%"};"{{/if}}></div>
            </div>
        </li>

    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="Hid_ClassID" value="<%=ClassID %>" />
    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="/PersonalSpace/Learning_center_portal.aspx">
                <img src="../images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul>
                     <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li class="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
                        <li currentclass="active"><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                        <li  currentclass="active"><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
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
                        <a href="/Gopay/Gopay.aspx" target="_blank"><span>账户管理</span></a>
                        <a href="/PersonalSpace/PersonalSpace_Student.aspx" target="_blank"><span >个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <div class="onlinetest_item width pt90">
        <div class="myexam bordshadrad">
            <div class="stytem_select clearfix">
                <div class="stytem_select_left fl">
                    <a href="javascript:;" class="on">我的课程</a>
                    <a href="javascript:;">历史课程</a>
                </div>
            </div>
            <div class="mycourse">
                <ul class="mycourse_lists" id="ul_mylessons"></ul>
            </div>
        </div>
    </div>
 <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/images/footer_logo.png" alt="" style="margin-top:10px;"/>
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
    <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
    <script>
        $('.stytem_select_left>a').click(function () {
            $(this).addClass('on').siblings().removeClass('on');
            var n = $(this).index();
            var operSymbol = n == 0 ? ">" : "<=";
            getData(1, 10, operSymbol);
            //$('.mycourse>ul').eq(n).show().siblings().hide();
        });
    </script>
</body>
<script type="text/javascript">
    $(document).ready(function () {
        getData(1, 10, ">");
    });
    //获取数据
    function getData(startIndex, pageSize, operSymbol) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                Func: "GetMyLessonsDataPage",
                PageIndex: startIndex,
                pageSize: pageSize,
                ispage: false,
                ClassID: $("#Hid_ClassID").val(),
                StuNo: $("#HUserIdCard").val(),
                OperSymbol: operSymbol
            },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            $("#ul_mylessons").html('');
            $("#li_mylessons").tmpl(json.result.retData).appendTo("#ul_mylessons");
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
            //makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            CourseMouseAcrossEvent();
        }
        else {
            $("#ul_mylessons").html('<li style="text-align:center">暂无课程！</li>');
        }
    }
    function OnError(errMsg) {
        $("#ul_mylessons").html(errMsg);
    }
    function CourseMouseAcrossEvent() {
        //课程鼠标划过效果
        $(".mycourse_lists li .line").hide();
        var t1, t2;
        var ary = [];
        $(".mycourse_lists li").each(function () {
            var height = $(this).innerHeight();
            ary.push(height);
        }).hover(function () {
            var _this = this;
            var n = $(this).index();
            $(this).find('.before-line1').show();
            $(this).find('.after-line1').show();
            $(this).find('.before-line3').css('top', ary[n] + 'px');
            $(this).find('.after-line1').css('top', ary[n] + 'px');
            $(this).find('.before-line1').stop().animate({ "width": 577 + 'px', left: -2 + 'px' }, 300);
            $(this).find('.after-line1').stop().animate({ "width": 577 + 'px', left: 579 + 'px' }, 300);
            
            clearTimeout(t1);
            clearTimeout(t2);
            t1 = setTimeout(function () {
                $(_this).find('.before-line2').show();
                $(_this).find('.after-line2').show();
                $(_this).find('.before-line2').stop().animate({ "height": (ary[n]+2) + 'px' }, 300);
                $(_this).find('.after-line2').stop().animate({ "height": ary[n] + 'px', 'top': 0 + 'px' }, 300);

            }, 300);
            t2 = setTimeout(function () {
                $(_this).find('.before-line3').show();
                $(_this).find('.after-line3').show();
                $(_this).find('.before-line3').stop().animate({ "width": 581 + 'px', 'top': ary[n] + 'px' }, 400);
                $(_this).find('.after-line3').stop().animate({ "width": 581 + 'px' }, 400);

            }, 600);
        }, function () {
            clearTimeout(t1);
            clearTimeout(t2);
            var n = $(this).index();
           $(this).find('.before-line1').stop().animate({ "width": 0, 'left': 577 + 'px' });
            $(this).find('.before-line2').stop().animate({ "height": 0 });
            $(this).find('.before-line3').stop().animate({ "width": 0 });
            $(this).find('.after-line1').stop().animate({ "width": 0, 'left': 577 + 'px' });
            $(this).find('.after-line2').stop().animate({ "height": 0, 'top': ary[n] + 'px' });
            $(this).find('.after-line3').stop().animate({ "width": 0 });
        })
        return ary;     
    }
    function CourseDetailClick(itemid,OperSymbol) {
        if (OperSymbol == ">") {
            location.href = "StuLessonDetail.aspx?itemid=" + itemid + "&flag=1";
        } else {
            layer.msg("该课程已经结束！");
        }
    }
</script>
</html>
