<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="SMSWeb.Portal.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../PortalCss/layout.css" rel="stylesheet" />
    <link href="../PortalCss/reset.css" rel="stylesheet" />
    <link href="../css/sprite.css" rel="stylesheet" />
    <style>
       .g-ico {
            display: inline-block;
            width: 20px;
            height: 20px;
            float:left;
            margin-top:2px;
        } 
       .scroll-pane
		{
			width: 200px;
			height:170px;
			overflow: auto;
            outline:none;
		}
    </style>
    <link href="../Scripts/jscrollpane/style/jquery.jscrollpane.css" rel="stylesheet" />
    <script src="../Scripts/jquery-1.11.2.min.js"></script>
    <script src="../Scripts/jscrollpane/scripts/jquery.mousewheel.js"></script>
    <script src="../Scripts/jscrollpane/scripts/jquery.jscrollpane.min.js"></script>
    <script src="../Scripts/Common.js"></script>
    <script src="../Scripts/layer/layer.js"></script>
    <script src="../PortalJs/layout.js"></script>
    <script src="../Scripts/jquery.tmpl.js"></script>
    <script src="../Scripts/jquery.cookie.js"></script>
    <script src="../PortalJs/syslogin.js"></script>
    <script src="../PortalJs/visitRecord.js"></script>
    
    <script id="item_notice" type="text/x-jquery-tmpl">
        <a href="/Portal/Notice/NoticeDetails.aspx?Id=${Id}&Type=${Type}" class="clearfix">
            <div class="fl date">
                <em>${DateTimeConvert(CreateTime,'dd')}</em>
                <p>${DateTimeConvert(CreateTime,'yyyy-MM')}</p>
            </div>
            <div class="fr text" title="${Title}">
                ${NameLengthUpdate(Title,30)}
            </div>
        </a>
    </script>
    <script id="item_Top_news" type="text/x-jquery-tmpl">
        <a href="/Portal/Notice/NoticeDetails.aspx?Id=${Id}&Type=${Type}" class="news_tu fl" title="${Title}">
            <i>
                {{if ShowImgUrl==""}}
               <img src="/PortalImages/defaultimg.jpg" />
                {{else}}
                  <img src="${ShowImgUrl}" />
                {{/if}}
            
            </i>
            <p>${NameLengthUpdate(Title,15)}</p>
        </a>
    </script>
    <script id="item_Down_news" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <i class="fl"></i>
            <a href="/Portal/Notice/NoticeDetails.aspx?Id=${Id}&Type=${Type}" class="fl" title="${Title}">${NameLengthUpdate(Title,22)}</a>
            <span class="fr">${DateTimeConvert(CreateTime)}</span>
        </li>
    </script>
    <script id="item_Lesson_student" type="text/x-jquery-tmpl">
        <a href="${hrefLesson(ID)}" class="fl">
            <i>{{if ImageUrl==""}}
                <img src="/PortalImages/defaultimg.jpg" />
                {{else}}
                  <img src="${ImageUrl}" />
                {{/if}}
            </i>
            <p>${NameLengthUpdate(Name,10)}</p>
        </a>
    </script>
    <script id="item_Lesson_teacher" type="text/x-jquery-tmpl">
        <a href="${hrefLesson(ID)}" class="fl">
            <i>
                
                {{if ImageUrl==""}}
                <span><img src="/PortalImages/defaultimg.jpg" /></span>
                {{else}}
                  <span> <img src="${ImageUrl}" /></span>
                {{/if}}
                
            </i>
            <p>${NameLengthUpdate(Name,10)}</p>
        </a>
    </script>
    <script id="item_SchoolStyle" type="text/x-jquery-tmpl">
        <a href="/Portal/about/AfterImgView.aspx?ssid=${Id}&id=${MenuId}">
            <i>{{if ImageUrl==""}}
                <img src="/PortalImages/defaultimg.jpg" />
                {{else}}
                  <img src="${ImageUrl}" />
                {{/if}}</i>
            <p>${NameLengthUpdate(Title,10)}</p>
        </a>
    </script>
    <script id="item_Resource" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <span class="g-ico ico-png-min"></span>
            <a href="javascript:downFile('${FileUrl}');" class="fl text">${NameLengthUpdate(Name,10)}</a>
        </li>
    </script>
    <script id="item_TeacherPower" type="text/x-jquery-tmpl">
        <a href="${hrefShow(IDCard,'师资力量')}" class="fl boxshadow">
            <i>{{if PhotoURL==""}}
                 <span><img src="/PortalImages/defaultteacher.jpg" /> </span>
                {{else}}
                 <span><img src="${PhotoURL}" alt="" /> </span>
                {{/if}}
            </i>
            <p>${Name}</p>
        </a>
    </script>
    <script id="item_SysLink" type="text/x-jquery-tmpl">
        <a href="${Href}" target="_blank">
            <img src="${ImageUrl}" alt="" /></a>
    </script>
     <script type="text/x-jquery-tmpl" id="item_Job">
        <li class="clearfix">
            <a href="/Portal/Job/JobItemList.aspx?JobID=${ID}" class="fl text">${NameLengthUpdate(Name,10)}</a>
            <span class="fr date">${DateTimeConvert(CreateTime,'MM-dd')}</span>
        </li>
    </script>
    <title>北京仪器仪表高级技工学校</title>
</head>
<body>
    <form id="form1" runat="server">
        <input type="hidden" id="HUserIdCard" runat="server" />
        <input type="hidden" id="HUserName" runat="server" />
        <input type="hidden" id="Hid_ClassID" runat="server" />
        <input type="hidden" id="HRoleType" runat="server" />
        <div style="display: none"><a href="#" target="_blank" id="PostBBS"><span>BBS</span> </a></div>
        <div class="top">
            <div class="top_con width clearfix">
                <h1 class="fl"><span class="tel"></span>全国咨询热线： 010- 62460887   &nbsp;  62461764    &nbsp; 62463259</h1>
                <div class="top_right fr clearfix">
                    <div class="weixin fl">
                        <span></span>
                        官方微信

                    </div>
                    <a href="/Portal/Certificate/Query.aspx?id=11" class="fl" style="color: #fff; margin-left: 20px;">证书搜索</a>
                    <a href="#" class="fl" style="color: #fff; margin-left: 20px;" id="divSude" target="_blank">进入教育平台</a>
                    <a href="#" target="_blank" id="GoBBS" class="fl" style="color: #fff; margin-left: 20px;">进入论坛</a>
                    <%-- <input onserverclick="Unnamed_ServerClick" type="button" runat="server" name="name" value="进入论坛" class="fl" style="font-size: 12px; color: #fff; background: none; border: none; line-height: 30px; font-family: 'Microsoft YaHei'; margin-left: 20px; cursor: pointer" />--%>
                    <div class="fr login_resig" id="loginItem">
                    </div>
                </div>
            </div>
        </div>
        <iframe name="htmlHeader" src="/Portal/header.html" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="460px"></iframe>
        <%--  <div id="htmlHeader"style="height:460px"></div>--%>
        <div class="main width clearfix">
            <div class=" main_left fl">
                <div class="left_con  clearfix mt20" style="min-height: 240px;">
                    <!--通知公告-->
                    <div class="announce fl">
                        <div class="modult_title">
                            <h1 class="fl">
                                <span class="ico ico_announce"></span>
                                通知公告
                            </h1>
                            <a href="/Portal/Notice/NoticeItemList.aspx?Type=0" class="more fr">更多+
                            </a>
                        </div>
                        <div class="announce_list" id="notice_list">
                        </div>
                    </div>
                    <div class="new_lists fr">
                        <div class="new_title clearfix">
                            <h1 class="fl">
                                <span class="on">学校新闻</span>
                                <span>媒体报道</span>
                                <span>招聘信息</span>
                            </h1>
                            <a href="/Portal/Notice/NoticeItemList.aspx?Type=1" class="more fr" id="ChangeHref">更多+
                            </a>
                        </div>
                        <div class="new_lists_con">
                            <div class="a" style="display: block;">
                                <div class="new_tuwrap clearfix" id="newsTop">
                                </div>
                                <ul class="new_list" id="newsDown" style="margin-top: 6px;">
                                </ul>
                            </div>
                            <div class="a">
                                <div class="new_tuwrap clearfix" id="mediaTop">
                                </div>
                                <ul class="new_list" id="mediaDown">
                                </ul>
                            </div>
                            <div class="a">
                                <div class="new_tuwrap clearfix" id="recruitTop">
                                </div>
                                <ul class="new_list" id="recruitDown">
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
                <!---->
                <div class="left_con  clearfix">
                    <div class="modult_title">
                        <h1 class="fl">
                            <span class="ico ico_course"></span>
                            课程展示
                        </h1>
                        <a href="" class="more fr" id="courseMore">更多+
                        </a>
                    </div>
                    <div class="lists clearfix " id="mylessons">
                    </div>
                </div>
                <div class="left_con  clearfix">
                    <div class="modult_title">
                        <h1 class="fl">
                            <span class="ico ico_teacher"></span>
                            师资力量
                        </h1>
                        <a href="/Portal/TeacherPower/Teacher.aspx?id=49" class="more fr">更多+
                        </a>
                    </div>
                    <div class="lists clearfix" id="teacherList">
                    </div>
                </div>
                <!---->
                <div class="left_con  clearfix">
                    <div class="modult_title">
                        <h1 class="fl">
                            <span class="ico ico_campus"></span>
                            校园风貌
                        </h1>
                        <a href="/Portal/about/AfterImgView.aspx?id=12" class="more fr">更多+
                        </a>
                    </div>
                    <div class="campus clearfix ">
                        <a href="#" class="fl campus_big boxshadow" id="hrefsStyle">
                            <i>
                                <img src="" alt="" id="imgsStyle" /></i>
                            <p id="psStyle"></p>
                        </a>
                        <div class="campus_s_lists clearfix fr">
                            <div id="schoolStyle">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="main_right fr">
                <div class="right_con">
                    <h1 class="right_title">联系我们
                    </h1>
                    <div class="right_content right_content1">
                        <div class="tel clearfix">
                            <span class="fl"></span>
                            <div class="fl">
                                <em>010-62463259</em>
                                <em>010-62460887</em>
                                <em>010-62461764</em>
                            </div>
                        </div>
                        <p class="address">校      址：北京市海淀区中关村环保科技示范园（海淀区北清路158号）</p>
                        <a onclick="OpenIFrameWindow('在线报名', '/Portal/WebEntered/index.aspx?display=none', '700px', '500px');" href="#" class="online_baoming">在线报名
                        </a>
                    </div>
                </div>
                <div class="right_con" style="margin-top:12px;">
                    <h1 class="right_title">职业导向
                        <a href="/Portal/Job/JobItemList.aspx">更多</a>
                    </h1>
                    <div class="right_content2 right_content">
                        <ul class="listas" id="joblist">
                            
                        </ul>
                    </div>
                </div>
                <div class="right_con" style="margin-top:12px;">
                    <h1 class="right_title">网站简介
                         <a href="/Portal/about/BeforeView.aspx?id=66">更多</a>
                    </h1>
                    <div class="right_content right_content3">
                        <div class="scroll-pane">
                            <p id="webDesc"></p>
                            
                        </div>
                        
                    </div>
                </div>
                <div class="right_con" style="margin-top:12px;">
                    <h1 class="right_title">资料下载
                         <a href="/Portal/Resource/ResourceList.aspx?id=11">更多</a>
                    </h1>
                    <div class="right_content4 right_content">
                        <ul class="listas listsdd" id="resourcelist">
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!--友情链接-->
        <div class="friendly_link width">
            <div class="modult_title">
                <h1 class="fl">
                    <span class="ico ico_link"></span>
                    友情链接
                </h1>
            </div>
            <div class="link clearfix" id="blogroll">
            </div>
        </div>
        <!--footer-->
        <iframe name="htmlFoot" src="/Portal/bottom.aspx" scrolling="no" allowtransparency="true" frameborder="no" width="100%" height="175px"  style="margin-top:20px;"></iframe>
        <script type="text/javascript">
            var UserInfo = null;
            $(function () {
                //$('#htmlHeader').load('header.html');
                $('.new_title h1 span').click(function () {
                    $(this).addClass('on').siblings().removeClass('on');
                    var n = $(this).index();
                    $('.new_lists_con>.a').eq(n).show().siblings().hide();
                    var params = 0;
                    if ($(this).html() == "学校新闻") {
                        params = 1;
                    } else if ($(this).html() == "媒体报道") {
                        params = 2;
                    } else if ($(this).html() == "招聘信息") {
                        params = 3;
                    }
                    $("#ChangeHref").attr("href", "Notice/NoticeItemList.aspx?Type=" + params);
                })

                /*通知*/
                getUserInfoCookie();
                initHref();
                initNotice();
                initNews();
                initAdvert();
                initCourse();
                initSchoolStyle();
                initResource();
                initTeacherPower();
                initSysLink();
                initJob();
            })

            //登录平台
            function initHref() {
                if ($("#HRoleType").val() != "" && $("#HRoleType").val().length > 0) {
                    if ($("#HRoleType").val() == "教师") {
                        $("#divSude").attr("href", "/HZ_Index.aspx");
                    } else if ($("#HRoleType").val() == "学生") {
                        $("#divSude").attr("href", "/PersonalSpace/Learning_center_portal.aspx");
                    }
                } else {
                    $("#divSude").attr("href", "/Login_hz.aspx");
                }
            }

            //通知公告
            function initNotice() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/NoticesHandler.ashx",
                        "func": "GetNoticeAll",
                        "top": "3",
                        "type": enumType("通知公告")
                    },
                    success: function (json) {
                        if (json.result.status == "ok") {
                            var dtJson = json.result.retData;
                            if (dtJson != null && dtJson.length > 0) {
                                $("#item_notice").tmpl(dtJson).appendTo("#notice_list");
                            }
                        }
                    },
                    error: OnError
                });
            }

            ///媒体，新闻，招聘
            function initNews() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/NoticesHandler.ashx",
                        "func": "GetNewsAll",
                        "top": "5",
                        "tys": enumType("学校新闻") + "," + enumType("媒体报道") + "," + enumType("招聘信息") + ""
                    },
                    success: function (json) {
                        if (json.result.status == "ok") {
                            var dtJson = json.result.retData;
                            if (dtJson != null) {
                                var array = dtJson;
                                var newsArry = $.grep(array, function (item) {
                                    return item.Type == enumType("学校新闻");
                                });
                                var mediaArry = $.grep(array, function (item) {
                                    return item.Type == enumType("媒体报道");
                                });
                                var recruitArry = $.grep(array, function (item) {
                                    return item.Type == enumType("招聘信息");
                                });
                                bindDataToHtml(newsArry, "newsTop", "newsDown");
                                bindDataToHtml(mediaArry, "mediaTop", "mediaDown");
                                bindDataToHtml(recruitArry, "recruitTop", "recruitDown");
                            }
                        }
                    },
                    error: OnError
                });
            }

            ///网站简介
            function initAdvert() {
                $.ajax({
                    type: "Post",
                    url: "/Common.ashx",
                    async: false,
                    dataType: "json",
                    data: {
                        "PageName": "PortalManage/AdvertisingHandler.ashx",
                        "func": "GetAdvertising",
                        "MenuIds": enumSystemType("网站简介"),
                        "IsDelete": 0
                    },
                    success: function (json) {
                        if (json.result.errMsg == "success") {
                            var items = json.result.retData;
                            if (items != null && items.length > 0) {
                                $("#webDesc").append(escape2Html(items[0].CreativeHTML));
                            }
                            var bars = '.jspHorizontalBar, .jspVerticalBar';

                            $('.scroll-pane').bind('jsp-initialised', function (event, isScrollable) {

                                //hide the scroll bar on first load
                                $(this).find(bars).hide();

                            }).jScrollPane().hover(

                                //hide show scrollbar
                                function () {
                                    $(this).find(bars).stop().fadeTo('fast', 0.9);
                                },
                                function () {
                                    $(this).find(bars).stop().fadeTo('fast', 0);
                                }

                            );
                        }
                    },
                    error: OnError
                });
            }

            //课程展示
            function initCourse() {
                if ($.cookie('LoginCookie_Cube') == null || $.cookie('LoginCookie_Cube') == "null" || $.cookie('LoginCookie_Cube') == "") {
                    $.ajax({
                        url: "/Common.ashx",
                        type: "post",
                        async: false,
                        dataType: "json",
                        data: {
                            PageName: "OnlineLearning/MyLessonsHandler.ashx",
                            Func: "GetMyLessonsByType",
                            CourseType: 3,
                            PageIndex: 1,
                            pageSize: 4,
                        },
                        success: function (json) {
                            if (json.result.errMsg == "success") {
                                $("#mylessons").html('');

                                $("#item_Lesson_teacher").tmpl(json.result.retData.PagedData).appendTo("#mylessons");
                            }
                            else {
                                $("#mylessons").html("暂无课程！");
                            }
                            $("#courseMore").attr("href", "/Portal/Course/list.aspx?id=" + enumSystemType("学校简介"));
                        },
                        error: function (XMLHttpRequest, textStatus, errorThrown) {

                        }
                    });
                } else {
                    if ($("#HRoleType").val() == "教师") {
                        $.ajax({
                            url: "/Common.ashx",
                            type: "post",
                            async: false,
                            dataType: "json",
                            data: {
                                PageName: "CourseManage/CourceManage.ashx",
                                Func: "GetPageList",
                                PageIndex: 1,
                                pageSize: 4,
                                IdCard: $("#HUserIdCard").val()
                            },
                            success: function (json) {
                                var href = "";
                                if (json.result.errNum.toString() == "0") {
                                    $("#mylessons").html('');
                                    $("#item_Lesson_teacher").tmpl(json.result.retData.PagedData).appendTo("#mylessons");
                                    $("#courseMore").attr("href", "/Portal/Course/list.aspx?id=" + enumSystemType("学校简介"));
                                }
                                else {
                                    $("#mylessons").html("暂无课程！");
                                }
                            },
                            error: OnError
                        });
                    } else {
                        $.ajax({
                            url: "/Common.ashx",
                            type: "post",
                            async: false,
                            dataType: "json",
                            data: {
                                PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                                Func: "GetMyLessonsDataPage",
                                PageIndex: 1,
                                pageSize: 4,
                                ispage: true,
                                ClassID: $("#Hid_ClassID").val(),
                                StuNo: $("#HUserIdCard").val()
                            },
                            success: function (json) {
                                var href = "";
                                if (json.result.errNum.toString() == "0") {
                                    $("#mylessons").html('');
                                    $("#item_Lesson_student").tmpl(json.result.retData.PagedData).appendTo("#mylessons");
                                    $("#courseMore").attr("href", "/Portal/Course/list.aspx?id=" + enumSystemType("学校简介"));
                                }
                                else {
                                    $("#mylessons").html("暂无课程！");
                                }
                            },
                            error: OnError
                        });

                    }

                }
            }

            //校园风貌
            function initSchoolStyle() {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/PortalManage/SchoolStyle.ashx",
                        Func: "GetPageList",
                        MenuId: enumSystemType("校园风貌"),
                        PageIndex: 1,
                        pageSize: 7
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#schoolStyle").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#imgsStyle").attr("src", items[0].ImageUrl);
                                $("#hrefsStyle").attr("href", "/Portal/about/AfterImgView.aspx?ssid=" + items[0].Id + "&id=" + items[0].MenuId);
                                $("#psStyle").html(items[0].Title);
                                items.splice(0, 1);
                                $("#item_SchoolStyle").tmpl(items).appendTo("#schoolStyle");
                            }
                        }
                        else {
                            $("#hrefsStyle").hide();
                            $("#schoolStyle").html("暂无校园风景！");
                        }
                    },
                    error: OnError
                });
            }

            //资源下载
            function initResource() {
                var Type = "0";
                if ($("#HRoleType").val() == "教师") Type = "2";
                else  Type = "1"; 
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/CourseManage/CouseResource.ashx",
                        Func: "GetResourceByRole",
                        IsPage: true,
                        PageIndex: 1,
                        pageSize: 9,
                        StuNo: $("#HUserIdCard").val(),
                        ClassID: $("#Hid_ClassID").val(),
                        RoleType: Type
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#resourcelist").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#item_Resource").tmpl(items).appendTo("#resourcelist");
                            }
                        }
                        else {
                            $("#resourcelist").html("暂无资源！");
                        }
                    },
                    error: OnError
                });
            }

            //师资力量
            function initTeacherPower() {
                $.ajax({
                    url: "/SystemSettings/CommonInfo.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageIndex: 1,
                        PageSize: 4,
                        Pageing: true,
                        Func: "GetTeacherPower"
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#teacherList").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#item_TeacherPower").tmpl(items).appendTo("#teacherList");
                            }
                        }
                        else {
                            $("#teacherList").html("暂无教师信息！");
                        }
                    },
                    error: OnError
                });
            }

            //友情链接
            function initSysLink() {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/PortalManage/AdminManager.ashx",
                        Func: "GetLinkList",
                        IsPage: true,
                        PageIndex: 1,
                        pageSize: 7
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#blogroll").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#item_SysLink").tmpl(items).appendTo("#blogroll");
                            }
                        }
                        else {
                            $("#blogroll").html("暂无友情链接");
                        }
                    },
                    error: OnError
                });
            }

            //职业导向
            function initJob() {
                $.ajax({
                    url: "/Common.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/PortalManage/JobHandler.ashx",
                        Func: "GetPageList",
                        IsPage: true,
                        PageIndex: 1,
                        pageSize: 7
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            $("#joblist").html('');
                            var items = json.result.retData.PagedData;
                            if (items != null && items.length > 0) {
                                $("#item_Job").tmpl(items).appendTo("#joblist");
                            }
                        }
                        else {
                            $("#joblist").html("暂无推荐职位！");
                        }
                    },
                    error: OnError
                });
            }

            function bindDataToHtml(arry, topId, downId) {
                if (arry != null && arry.length > 0) {
                    var newsTop = [];
                    var newsDown = [];
                    for (var i = 0; i < arry.length; i++) {
                        if (i < 2)
                            newsTop.push(arry[i]);
                        else
                            newsDown.push(arry[i]);
                    }
                    if (newsTop.length > 0) $("#item_Top_news").tmpl(newsTop).appendTo("#" + topId);
                    if (newsDown.length > 0) $("#item_Down_news").tmpl(newsDown).appendTo("#" + downId);
                }
            }

            function escape2Html(str) {
                var arrEntities = { 'lt': '<', 'gt': '>', 'nbsp': ' ', 'amp': '&', 'quot': '"' };
                return str.replace(/&(lt|gt|nbsp|amp|quot);/ig, function (all, t) { return arrEntities[t]; });
            }

            function hrefShow(IDCard, str) {
                var id = enumSystemType(str);
                return "/Portal/TeacherPower/TeacherDetails.aspx?IDCard=" + IDCard + "&id=" + id;
            }

            $("#courseMore").on('click', function () {
                window.location = "/Portal/Course/details.aspx?id=" + enumSystemType("学校简介");
            })

            function hrefLesson(cid) {

                if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                    if ($("#HRoleType").val() == "学生") {
                        return "/OnlineLearning/StuLessonDetail.aspx?itemid=" + cid + "&flag=0";
                    } else if ($("#HRoleType").val() == "教师") {
                        return "/CourseManage/CourseDetail.aspx?itemid=" + cid + "&ParentID=20&PageName=/CourseManage/CourseIndex.aspx";
                    }
                } else {
                    return "javascript:OpenIFrameWindow('用户登录', '/Portal/login.aspx?url=course&paramsid=" + cid + "', '700px', '500px')";
                }
            }

            function downFile(path) {
                $.ajax({
                    url: "/OnlineLearning/DownLoadHandler.ashx",
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        filepath: path
                    },
                    success: function (json) {
                        if (json == -1) {
                            layer.msg("资源不存在！");
                        }
                    },
                    error: function (XMLHttpRequest, textStatus, errorThrown) {
                        layer.msg("资源不存在！");
                    }
                });
            }

            function getUserInfoCookie() {
                if ($.cookie('LoginCookie_Cube') != null && $.cookie('LoginCookie_Cube') != "null" && $.cookie('LoginCookie_Cube') != "") {
                    var UserInfo = $.parseJSON($.cookie('LoginCookie_Cube'));
                    if (UserInfo != null) {
                        $("#HUserIdCard").val(UserInfo.IDCard);
                        $("#HUserName").val(UserInfo.LoginName);
                        $("#Hid_ClassID").val(UserInfo.ClassID);
                        $("#HRoleType").val(UserInfo.SF);
                    }
                }
            }
        </script>
    </form>
</body>
</html>
