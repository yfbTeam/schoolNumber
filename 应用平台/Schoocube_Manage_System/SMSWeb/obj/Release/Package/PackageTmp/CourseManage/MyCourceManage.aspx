<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCourceManage.aspx.cs" Inherits="SMSWeb.CourseManage.MyCourceManage1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>我的课程</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link href="../css/onlinetest.css" rel="stylesheet" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="../Scripts/Pager.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script src="../CourseMenu.js"></script>
    <script src="../js/menu_top.js"></script>
    <script id="tr_Cource" type="text/x-jquery-tmpl">
        <li class="clearfix" onclick="CourceDetail(${ID});">
            <div class="before-line1 line"></div>
            <div class="before-line2 line"></div>
            <div class="before-line3 line"></div>
            <div class="after-line1 line"></div>
            <div class="after-line2 line"></div>
            <div class="after-line3 line"></div>
            <div class="mycourse_img fl">
                {{if ImageUrl==""}}
                <img src="../images/course_default.jpg" />
                {{else}}
									<img src="${ImageUrl}" alt="" />
                {{/if}}
            </div>
            <div class="fr mycourse_mes">
                <h1 class="mycourse_name" style="cursor: pointer;" onclick="CourceDetail(${CourseEvalue})">${Name}</h1>
                <div class="assess" id="${Evalue}" style="height: 24px; position: absolute; margin-top: -32px; right: 12px; top: 60px;">
                    <span id="1"></span>
                    <span id="2"></span>
                    <span id="3"></span>
                    <span id="4"></span>
                    <span id="5"></span>

                </div>
                <h2 class="clearfix">
                    <div class="fl lecturer">
                        主讲老师：
										<span>${LecturerName} </span>
                    </div>
                    <div class="fl course_type">
                        课程类别：{{if CourceType==1}}
										<span>必修课</span>
                        {{else}}
										<span>选修课</span>
                        {{/if}}
                    </div>
                    <div class="fl class_venue">
                        上课场地：
										 <span>${StudyPlace}</span>
                    </div>
                    <div class="fl people_number">
                        选课人数上限：
										 <span>${StuMaxCount}</span>
                    </div>
                </h2>
                <div class="course_desc" style="line-height:22px;max-height:88px;display: -webkit-box; -webkit-line-clamp: 4;-webkit-box-orient: vertical;overflow:hidden;text-overflow:ellipsis;">
                    ${CourseIntro}               
                </div>

                <div class="succ_detaillist">
                    {{if CourceType==2}}
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            选课人数
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_people"></i>
                            </em>
                            <span>${CourseSels}人</span>
                        </div>
                    </div>
                    {{/if}}
                    <div class="detaillist_item">
                        <div class="detaillist_title">
                            讨论
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
                            待查看任务
                        </div>
                        <div class="detaillist_desc">
                            <em class="icons">
                                <i class="icon icon_test"></i>
                                <b>0</b>
                            </em>
                            <span>任务</span>
                        </div>
                    </div>
                    <%--<div class="detaillist_item">
                            <div class="detaillist_title">
                                课程完成度
                            </div>
                            <div class="detaillist_desc">
                                <span class="succ_process">0%</span>
                            </div>
                        </div>
                        <div class="detaillist_item">
                            <div class="detaillist_title">
                                作业完成度
                            </div>
                            <div class="detaillist_desc">
                                <span>0</span>/<span>0</span>
                            </div>
                        </div>--%>
                </div>
            </div>
            <%--<div class="process_outer">
                <div class="process_innera">
                </div>
            </div>--%>
        </li>
    </script>
</head>

<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HClassID" runat="server" />
    <input type="hidden" id="ButtonCode" />

    <form id="form1">
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="../images/coursesystem.png" /></div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%--<li><a href="/CourseManage/CourseIndex.aspx">课程首页</a></li>
                        <li><a href="CourceManage.aspx">课程管理</a></li>
                        <li class="active"><a href="#">我的课程</a></li>
                        <li><a href="Course_SelManag.aspx">选课管理</a></li>--%>
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
            <div class="myexam bordshadrad">
                <div class="stytem_select clearfix">
                    <div class="stytem_select_left fl">
                        <a href="javascript:;" class="on">我的课程</a>
                        <%--<a href="javascript:;" onclick="History('<',this)">历史课程</a>--%>
                    </div>
                    <%--<div class="stytem_select_right fr">
                        <a href="javascript:;" class="newcourse" onclick="AddCource()"><i class="icon icon-plus"></i>创建课程</a>
                    </div>--%>
                </div>
                <div class="nocourse_wrap" style="display: none">
                    <div class="nocourse">
                        <div class="nocourse_center">
                            <p>您尚未创建任何课程</p>
                            <h1>点击<a href="javscript:;" class="course_btn btnprice_bgfree" onclick="AddCource()">创建课程</a>进行创建吧！</h1>
                        </div>
                    </div>
                </div>
                <div class="mycourse">
                    <ul class="mycourse_lists" id="tb_MyCource">
                    </ul>
                </div>
            </div>
        </div>
        <script src="../js/common.js"></script>
    </form>
</body>
<script>
    $(function () {
        getData(1, 10);
        CourceMenu();
    })
    function AddCource() {
        OpenIFrameWindow('添加课程', 'CourceAdd.aspx', '630px', '70%');
    }
    //获取数据
    function getData(startIndex, pageSize) {
        //初始化序号 
        pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetPageList", PageIndex: startIndex, pageSize: pageSize, ID: "", OperSymbol: '>', IdCard: $("#HUserIdCard").val() },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            $(".nocourse_wrap").css("display", "none");
            $(".mycourse").css("display", "");

            $("#tb_MyCource").html('');
            $("#tr_Cource").tmpl(json.result.retData.PagedData).appendTo("#tb_MyCource");
            CourseMouseAcrossEvent();
            Star();
        }
        else {
            var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
            $("#tb_MyCource").html(html);
        }
        hoverEnlarge($('.mycourse_lists li .mycourse_img img'));
    }
    function OnError(XMLHttpRequest, textStatus, errorThrown) {
        $("#tb_MyCource").html(json.result.errMsg.toString());
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
                $(_this).find('.before-line2').stop().animate({ "height": (ary[n] + 2) + 'px' }, 300);
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
    function CourceDetail(ID) {
        window.location.href = 'CourseDetail.aspx?itemid=' + ID + "&ParentID=" + UrlDate.ParentID + "&PageName=" + UrlDate.PageName;
    }
    function Star() {
        //stars评价
        $('.mycourse_mes').find(".assess").each(function () {
            var num = $(this).attr("id");
            if (num > 0) {
                $(this).find("span").eq(num - 1).siblings().removeClass('on');
                $(this).find("span").eq(num - 1).prevAll().andSelf().addClass('on');
            }
        })
    }
</script>
</html>
