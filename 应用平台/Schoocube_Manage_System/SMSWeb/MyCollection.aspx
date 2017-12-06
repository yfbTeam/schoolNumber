<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyCollection.aspx.cs" Inherits="SMSWeb.MyCollection" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
		<title>我的收藏</title>
		<!--图标样式-->
		<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css"/>
		<link rel="stylesheet" type="text/css" href="css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="css/common.css"/>
		<link rel="stylesheet" type="text/css" href="css/repository.css"/>
		<link rel="stylesheet" type="text/css" href="css/onlinetest.css"/>
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
		<script type="text/javascript" src="js/menu_top.js"></script>
    <style>
        .keep {
            margin-top: 20px;
            font-size: 14px;
            color: #40bb6b;
            cursor: pointer;
        }

        .keep {
            font-size: 16px;
        }

        .collect {
            color: #D84A27;
            margin-top: 20px;
            font-size: 14px;
            cursor: pointer;
        }

        .collect {
            font-size: 16px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="/images/wodeshoucang.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul>
                         <li currentclass="active"><a href="MyCollection.aspx">我的收藏</a></li>
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
                <div class="mycourse">
                    <div class="newcourse_select clearfix">
					    <div class="clearfix fl course_select">
						    <label for="">收藏类型：</label>
						    <select name="" class="select">
							    <option value="">课程</option>
						    </select>
					    </div>
					    
				    </div>
					<ul class="mycourse_lists">
						<li class="clearfix">
							<div class="before-line1 line"></div>
							<div class="before-line2 line"></div>
							<div class="before-line3 line"></div>
							<div class="after-line1 line"></div> 
							<div class="after-line2 line"></div>
							<div class="after-line3 line"></div>
							<a  href="mycourse_students.html">
							<div class="mycourse_img fl">
								<img src="images/course_01.png" alt="" />
							</div></a>
							<div class="fl mycourse_mes">
								<h1 class="mycourse_name">将英语变成母语</h1>
								<h2 class="clearfix">
									<div class="fl lecturer">
										主讲老师：
										<span>李恩博 </span>
									</div>
									<div class="fl course_type">
										课程类别：
										<span>必修课</span>
									</div>
									<div class="fl class_venue">
										 上课场地：
										 <span>小教室</span>
									</div>
									<div class="fl people_number">
										 选课人数上线：
										 <span>50</span>
									</div>
								</h2>
								<div class="course_desc" style="line-height:22px;max-height:88px;display: -webkit-box; -webkit-line-clamp: 4;-webkit-box-orient: vertical;overflow:hidden;text-overflow:ellipsis;">
									《将英语变成母语》系列讲座，从最简单的英语发音入手，逐级深入，涉及词汇、阅读、写作、听力、口语，最后达到交互传译、同声传译的高度。英语学习是我终生的爱好，希望自己的学习经验能够对有志于将英语变成母语的朋友有帮助。
								</div>
                                <div class="keep" >                 
                                        <i class="icon-heart-empty"></i>     
                                                    加入收藏         
                                </div>
                                 <div class="collect" >                 
                                        <i class="icon-heart"></i>     
                                                    移除收藏         
                                </div>
                            </div>
							<div class="process_outer">
								<div class="process_innera">
									
								</div>
							</div>
						</li>
					</ul>
                </div>
            </div>
        </div>
        <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
        <script>
            CourseMouseAcrossEvent();
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
        </script>
    </div>
    </form>
</body>
</html>
