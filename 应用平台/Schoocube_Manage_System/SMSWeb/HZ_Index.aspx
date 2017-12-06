<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HZ_Index.aspx.cs" Inherits="SMSWeb.HZ_Index" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1" />
    <meta charset="utf-8" />
    <title>远程教学平台</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="css/reset.css" />
    <link rel="stylesheet" type="text/css" href="css/common.css" />
    <link rel="stylesheet" type="text/css" href="css/index.css" />
    <link rel="stylesheet" type="text/css" href="css/fullcalendar.css" />
    <link href="css/fancybox.css" rel="stylesheet" />
    <script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
    <script src="Scripts/Common.js"></script>
    <script src='http://code.jquery.com/ui/1.10.3/jquery-ui.js'></script>
    <script src='js/jquery.fancybox-1.3.1.pack.js'></script>
    <style type="text/css">
        .fancy {
            width: 450px;
            height: auto;
        }

        .fancy h3 {
            height: 30px;
            line-height: 30px;
            border-bottom: 1px solid #d3d3d3;
            font-size: 14px;
        }
        
        .fancy form {
            padding: 10px;
        }

        .fancy p {
            height: 28px;
            line-height: 28px;
            padding: 4px;
            color: #999;
        }

        .input {
            height: 20px;
            line-height: 20px;
            padding: 2px;
            border: 1px solid #d3d3d3;
            width: 100px;
        }

        .btn1 {
            -webkit-border-radius: 3px;
            -moz-border-radius: 3px;
            padding: 5px 12px;
            cursor: pointer;
        }

        .btn_ok {
            background: #360;
            border: 1px solid #390;
            color: #fff;
        }

        .btn_cancel {
            background: #f0f0f0;
            border: 1px solid #d3d3d3;
            color: #666;
        }

        .btn_del {
            background: #f90;
            border: 1px solid #f80;
            color: #fff;
        }

        .sub_btn {
            height: 32px;
            line-height: 32px;
            padding-top: 6px;
            border-top: 1px solid #f0f0f0;
            text-align: right;
            position: relative;
        }

            .sub_btn .del {
                position: absolute;
                left: 2px;
            }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript">
        //日程协同
        $(function () {
            $('#calendar').fullCalendar({
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month'
                },
                height: '383',
                firstDay: 0,
                weekMode: 'liquid',
                events: 'json.ashx?Func=GetDate&CreateUID=' + $("#HUserIdCard").val(),
                dayClick: function (date, allDay, jsEvent, view) {
                    var selDate = $.fullCalendar.formatDate(date, 'yyyy-MM-dd');
                    $.fancybox({
                        'type': 'ajax',
                        'href': 'event.aspx?action=add&date=' + selDate
                    });
                },
                //单击事件项时触发
                eventClick: function (calEvent, jsEvent, view) {
                    $.fancybox({
                        'type': 'ajax',
                        'href': 'event.aspx?action=edit&id=' + calEvent.id
                    });
                }

            });

        });
    </script>
</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden"  id="HUserName" runat="server" />
    <!--header-->
    <header class="repository_header_wrap">
        <div class="width repository_header clearfix">
            <a class="logo fl" href="HZ_Index.aspx">
               <img src="PortalImages/logoBefore.png" style="margin-top:5px;"/>

            </a>
            <div class="search_account fr clearfix">
               <%--<div class="search fl">
                    <i class="icon  icon-search"></i>
                    <input type="text" name="" id="" placeholder="请输入关键字" />
                </div>--%>
                <ul class="account_area fl">
                    <li>
                        <a href="#" class="dropdown-toggle">
                            <i class="icon icon-envelope"></i>
                            <span class="badge">0</span>
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
                         <%--<a href="/Gopay/GoPay.aspx" target="_blank"><span>账户管理</span></a>--%>
                          <a href="/PersonalSpace/PersonalSpace_Teacher.aspx" target="_blank"><span>个人中心</span></a>
                        <span onclick="logOut()">退出</span>
                    </div>
                </div>
            </div>
        </div>
    </header>
    <!--main-->
    <!--<div class="clear"></div>-->
    <div class="main width clearfix pt20">
        <div class="main_left fl">
            <div class="teacher_wrap clearfix bordshadrad ">
                <!--教师信息-->
                <dl class="teacher p10 clearfix fl">
                    <dt class="fl">
                        <i class="dislb teacher_img">
                            <img src="<%=PhotoURL%>" />
                        </i>
                    </dt>
                    <dd class="fl p10">
                        <div class="teacher_mes colorBlack">
                            <span class="teacher_name"><%=Name%> 
                            </span>
                            <%=SF%>
                        </div>
                        <div class="teacher_school1 colorGray">
                            <%=SchoolName %>
                        </div>
                        <div class="teacher_school2 colorGray">
                            <%--英语学院--%>
                        </div>
                    </dd>
                </dl>
                <ul class="course_mes fr p10">
                    <li class="course">课程
	    					<span class="course_mes_num fr">2
                            </span>
                    </li>
                    <li class="studends">学生
	    					<span class="course_mes_num fr">60
                            </span>
                    </li>
                    <li class="test">考试
	    					<span class="course_mes_num fr">10
                            </span>
                    </li>
                </ul>
            </div>
            
            <!--通知信息-->
            <div class="notice mt20">
                <ul class="clearfix">
                    <li class="notice_one bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderblue" href="javascript:;">
                                <i class="icon icon-envelope colorblue"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">通知</p>
                        </div>
                        <div class="connect">
                            <span class="connect_left bgblue"></span>
                            <span class="connect_right bgblue"></span>
                        </div>
                    </li>
                    <li class="to_corrected bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderorange" href="javascript:;">
                                <i class="icon icon-envelope colororange"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">待批改作业</p>
                        </div>
                        <div class="connect none">
                            <span class="connect_left bgorange"></span>
                            <span class="connect_right bgorange"></span>
                        </div>
                    </li>
                    <li class="pendingreview bordshadrad">
                        <div class="notice_mes">
                            <a class="notice_mes1 borderpink" href="javascript:;">
                                <i class="icon icon-envelope colorpink"></i>
                                <p class="notice_mes_num">0</p>
                            </a>
                            <p class="notice_name">待审阅</p>
                        </div>
                        <div class="connect none">
                            <span class="connect_left bgpink"></span>
                            <span class="connect_right bgpink"></span>
                        </div>
                    </li>
                </ul>
            </div>
            <!--xinxi-->
            <div class="messages mt10 bordshadrad">
                <ul class="p10" id="note1">
                   <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.12</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.12</span></li>--%>
                </ul>
                <ul class="p10 none" id="note2">
                   <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.19</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.19</span></li>--%>
                </ul>
                <ul class="p10 none" id="note3">
                   <%-- <li><a href="">英语教室申请已通过，请创建课程内容</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">课程创建审核已通过，请尽快发布课程</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">30名学生报名《英语演讲》，请尽快审核</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">已有学生对《英语口语训练》进行评价</a><span class="fr">2016.03.23</span></li>
                    <li><a href="">班级论坛提出新讨论方向</a><span class="fr">2016.03.23</span></li>--%>
                </ul>
            </div>
        </div>
        <div class="scheduprog fr">
            <div class="calendar_titie">
                日程安排
            </div>
            <div class="calendar_wrap bordshadrad">
                <div class="wrap p10">
                    <div id='calendar'></div>
                </div>
            </div>
        </div>
    </div>
    <div class="main width clearfix pt20">
        <div class="myapp_wrap bordshadrad">
            <div class="apps_title ">
                <h1 class="bordshadrad">我的应用</h1>
            </div>
            <ul class="app_list p10 clearfix" id="Menu">
                <%--<li>
                    <a href="ResourceManage/MyResourceManage.aspx" class="bgblue" target="_blank">
                        <i></i>
                        <p class="app_name">个人网盘</p>
                    </a>
                </li>
                <li>
                    <a href="ResourceManage/PublicResoure.aspx" class="bgorange" target="_blank">
                        <i></i>
                        <p class="app_name">资源中心</p>
                    </a>
                </li>
                <li>
                    <a href="Exam/ExamQManager.aspx" class="bgorange" target="_blank">
                        <i></i>
                        <p class="app_name">考试系统</p>
                    </a>
                </li>
                <li>
                    <a href="CourseManage/CourseIndex.aspx" class="bgred" target="_blank">
                        <i></i>
                        <p class="app_name">选课管理</p>
                    </a>
                </li>
                <li>
                    <a href="CourseManage/students_index.aspx" class="bggreen" target="_blank">
                        <i></i>
                        <p class="app_name">学生中心</p>
                    </a>
                </li>--%>
            </ul>
           <%-- <div class="add_wrap">
                <div class="add">
                    <i></i>
                </div>
            </div>--%>
        </div>
        <%--<div class="otherapp_wrap fr bordshadrad">
            <div class="apps_title clearfix">
                <h1 class="fl bordshadrad">其他应用</h1>
                <a href="javascript:;" class="more fr">更多</a>
            </div>
            <ul class="app_list clearfix">
                <li>
                    <a href="/PersonalSpace/TrainingManage.aspx" target="_blank" class="bgblue">
                        <i>
                            <img src="images/档案管理.png" /></i>
                        <p class="app_name">档案管理</p>
                    </a>
                </li>
                <li>
                    <a href="/PersonalSpace/CertificateManage.aspx" target="_blank" class="bgorange">
                        <i>
                            <img src="images/证书管理.png" /></i>
                        <p class="app_name">证书管理</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="bgred">
                        <i>
                            <img src="images/选课系统.png" /></i>
                        <p class="app_name">选课系统</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="bgred">
                        <i>
                            <img src="images/在线学习.png" /></i>
                        <p class="app_name">在线学习</p>
                    </a>
                </li>
                <li>
                    <a href="#" class="bgred">
                        <i>
                            <img src="images/资源中心.png" /></i>
                        <p class="app_name">资源中心</p>
                    </a>
                </li>
            </ul>
        </div>--%>
    </div>
    <footer class="mt10">
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="PortalImages/logoBefore.png" style="margin-top:10px;"/>
            </div>
            <div class="footer_right fr">
                <p>地址：北京市海淀区中关村环保科技示范园内（海淀区北清路）</p>
                <p>传真：010-62463259   网址：<a href="" style="color: #fff;">http://www.bjybjx.cn</a></p>
                <p>电子邮件（E-MAIL）:yqybjxzb@sohu.com </p>
            </div>
        </div>
    </footer>
    <script src="js/common.js"></script>
    <script type="text/javascript" src="js/fullcalendar.min.js"></script>
    <script type="text/javascript">
       
        $(function () {
            $('.search_account .search input').focus(function () {
                $(this).parent().css('background', '#fff');
                $(this).css({'background': '#fff','color':'#666'});
            }).blur(function () {
                $(this).parent().css('background', '#1d87d6');
                $(this).css({ 'background': '#1d87d6', 'color': '#fff' });
            });
            //通知，审阅，批改作业切换
            $('.notice ul li').each(function (i, elem) {
                $(elem).find('.notice_mes').click(function () {
                    $('.notice ul li').children('.connect').hide();
                    $('.notice ul li').children('.connect').eq(i).show().css('transition', 'all 1s 0.5s');
                    $('.messages ul').eq(i).show().siblings().hide();
                })
            })
            GetLeftNavigationMenu();
            initMsg();
        })
        function GetLeftNavigationMenu() {
            $.ajax({
                type: "Post",
                url: "SystemSettings/CommonInfo.ashx",
                data: { Func: "GetLeftNavigationMenu", useridcard: $("#HUserIdCard").val(), Pid: "0" },
                dataType: "json",
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            if (this.IsOwner > 0) {
                                var url = this.Url.replace(".aspx", "/") + this.Id + ".aspx";
                                var li = " <li><a href=\"" +url//+ this.Url + "?ParentID=" + this.Id //+ "&PageName=" + this.Url
                                    + "\" class=\"bgblue\"  target=\"_blank\"><i><img src=\"" + this.MenuCode + "\" /></i><p class=\"app_name\">" +
                                    this.Name + "</p></a></li>";
                                $("#Menu").append(li);
                            }
                        });
                        // layer.msg(json);
                    }
                },
                error: function (errMsg) {
                    layer.msg('操作失败！');
                }
            });
        }

        function Login() {
            var inputCode = document.getElementById("inpCode").value.toUpperCase();
            var codeToUp = code.toUpperCase();

            if (inputCode.length <= 0) {
                layer.msg("请输入验证码！");
                return false;
            }
            else if (inputCode != codeToUp) {
                layer.msg("验证码输入错误！");
                createCode();
                $("#inpCode").val('').focus();
                return false;
            }
            else {
                var loginName = $("#txt_loginName").val();
                var passWord = $("#txt_passWord").val();
                $.ajax({
                    url: "Common.ashx",
                    async: false,
                    dataType: "json",
                    data: { "PageName": "UserHandler.ashx", "LoginName": loginName, "Password": passWord, func: "PlatLogin", },
                    success: OnSuccessLogin,
                    error: OnErrorLogin
                });
            }
        }


        function initMsg() {
            //初始化序号 
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "PortalManage/MessageHandler.ashx",
                    Func: "GetPageList",
                    Receiver: $("#HUserIdCard").val(),
                    Status:0,
                    Ispage:false
                },
                success: function (json) {
                    if (json.result.errMsg == "success") {
                        var items = json.result.retData;
                        if (items!=null && items.length>0) {
                            $(".badge").html(items.length);
                            var dpgzy = 0;
                            var dsy = 0;
                            $.each(items, function (i,item) {
                                if (item.Type == "0") {
                                    $("#note2").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");
                                    
                                    dpgzy++;
                                } else if (item.Type == "3") {
                                    $("#note3").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");

                                    dsy++;
                                }
                                else {
                                    $("#note1").append("<li><a href=\"SysMessage/UsersMessage.aspx?id=" + item.Id + "\">" + item.Title + "</a><span class=\"fr\">" + DateTimeConvert(item.CreateTime, 'yyyy-MM-dd') + "</span></li>");

                                }
                            });
                            $('.notice .to_corrected .notice_mes_num').html(dpgzy);
                            $('.notice .pendingreview .notice_mes_num').html(dsy);
                            $(".notice .notice_one .notice_mes_num").html($("#note1").children().length);
                        } else {
                            $(".badge").html("0");
                        }
                    }
                    else {
                        $(".badge").html("0");
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {

                }
            });
        }
    </script>
</body>
</html>
