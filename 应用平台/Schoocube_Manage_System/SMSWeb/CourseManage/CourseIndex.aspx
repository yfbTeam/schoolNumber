<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseIndex.aspx.cs" Inherits="SMSWeb.CourseManage.CourseIndex" %>

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
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/Power.js?parm=123"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script src="/CourseMenu.js?parm=123"></script>
    <style type="text/css">
        .team_more a {
            cursor: pointer;
        }
    </style>
    
    <script type="text/javascript">
      
        var UrlDate = new GetUrlDate();

        $(function () {
            CourceMenu();
            BindData();
        })
        function CourceMore() {
            var location = window.location.href;
            var num1 = location.lastIndexOf("/");
            var num2 = location.lastIndexOf(".");
            var Pid = location.substring(num1 + 1, num2)

            window.location.href = "/CourseManage/Cource_More.aspx?ParentID=" + Pid;// + "&PageName=" + UrlDate.PageName;
        }
        function CourseDetail(ID) {
            //var location = window.location.href;
            //var num1 = location.lastIndexOf("/");
            //var num2 = location.lastIndexOf(".");
            //var Pid = location.substring(num1 + 1, num2)
            window.location.href = '/CourseManage/CourseDetail.aspx?itemid=' + ID;//+ "&ParentID=" + Pid;// + "&PageName=" + UrlDate.PageName;
        }
        function BindData() {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "PageName": "CourseManage/CourceManage.ashx", "Func": "GetCourseByType" ,"Num":3},
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $(json.result.retData).each(function () {
                            var TypeName = "线下课程";
                            if (this.CourceType == "1") {
                                TypeName = "线上课程";
                            }
                            var ImageUrl = this.ImageUrl;
                            //if (ImageUrl == "") {
                            //    ImageUrl = "/images/course_default.jpg";
                            //}
                            var div = "<div class=\"team_list fl\" onclick=\"CourseDetail(" + this.ID + ")\" style=\"cursor: pointer;\"><div class=\"allcourse_img\"><img src='" + ImageUrl
                                + "' alt='' onerror=\"javascript:this.src='/images/course_default.jpg'\" /></div><div class=\"course_type course_bixiu\">" + TypeName + "</div><div class=\"couese_title\">" + this.Name +
                            "</div><p class=\"course_name\"><span>" + this.LecturerName + "</span></p></div>";
                            if (this.CourseType == "教育学部") {
                                $("#Edu").append(div);
                            }
                            if (this.CourseType == "艺术学部") {
                                $("#Art").append(div);
                            }
                            if (this.CourseType == "服务学部") {
                                $("#server").append(div);
                            }
                            if (this.CourseType == "技术学部") {
                                $("#skill").append(div);
                            }
                        });
                    }
                    else {
                        layer.msg(json.result.errMsg);
                    }
                    hoverEnlarge($('.team_list .allcourse_img img'));
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="ButtonCode" />
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>
                <div class="wenzi_tips fl">
                    <img src="/images/coursesystem.png" />
                </div>
                <nav class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%--<li class="active"><a href="#">课程首页</a></li>
                        <li><a href="CourceManage.aspx">课程管理</a></li>
                        <li><a href="MyCourceManage.aspx">我的课程</a></li>
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
        <div class="onlinetest_item width pt90 clearfix pb20">
            <div class="team_wrap educate_bg fl clearfix" id="Edu">
                <div class="educate_team fl educate_teambg">
                    <h1>教育学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">学前教育</a>
                        <a onclick="CourceMore()">综合高中</a>
                        <a onclick="CourceMore()">高考升学</a>
                        <a onclick="CourceMore()">国际高中</a>
                    </div>
                </div>
            </div>
            <div class="team_wrap fl" id="Art">

                <div class="educate_team fl art_teambg">
                    <h1>艺术学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">影视影像</a>
                        <a onclick="CourceMore()">美容美发</a>
                        <a onclick="CourceMore()">动漫游戏</a>
                        <a onclick="CourceMore()">时装设计</a>
                    </div>
                </div>

            </div>
            <div class="team_wrap fl" id="server">
                <div class="educate_team fl server_teambg">
                    <h1>服务学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">金融财会</a>
                        <a onclick="CourceMore()">酒店餐饮</a>
                        <a onclick="CourceMore()">旅游体验</a>
                        <a onclick="CourceMore()">园林园艺</a>
                    </div>
                </div>
            </div>
            <div class="team_wrap skill_bg fl" id="skill">
                <div class="educate_team fl skill_teambg">
                    <h1>技术学部</h1>
                    <div class="team_more">
                        <a onclick="CourceMore()">网络物联</a>
                        <a onclick="CourceMore()">口腔修复</a>
                        <a onclick="CourceMore()">钟表维修</a>
                        <a onclick="CourceMore()">电子商务</a>
                    </div>
                </div>
            </div>
        </div>
        <script src="/js/common.js"></script>
    </form>
</body>
</html>
