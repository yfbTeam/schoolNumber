<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PlayerStudy.aspx.cs" Inherits="SMSWeb.OnlineLearning.PlayerStudy" %>

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
    <script src="/Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script src="TopicAndComment.js"></script>
    <script id="li_mylessons" type="text/x-jquery-tmpl">
        <dt class="fl">
            <h1 class="onlinestudy_title">${Name}</h1>
            <p class="onlinestudy_teacher">主讲老师：<span>${LecturerName}</span></p>
            <p class="onlinestudy_desc">${cutstr(CourseIntro,50)}</p>
        </dt>
        <dd class="fr boxsize">
            <img src="${ImageUrl}" alt="" onerror="javascript:this.src='/images/course_default.jpg'"/>
        </dd>
    </script>

    <%--讨论列表的绑定--%>
    <script id="li_topic" type="text/x-jquery-tmpl">
        <li class="clearfix" id="li_topic_${Id}">
            <div class="disu_head clearfix">
                <a href="javascript:;" class="fl disu_img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                </a>
                <div>${CreateName}</div>
                <div class="cnt" style="margin-left:0;font-size:12px;color:#999;">${Name} </div>
                <div class="time" style="margin-left:0;font-size:12px;color:#999;">${CreateTime_Format}</div>
                <div class="clearfix">
                    <div class="clearfix fl caozuo_none">
                        {{if IsCreate==1}}
                        <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id});">
                            <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                        </div>
                        {{/if}}                            
                    </div>
                    <div class="note_oper fr clearfix">
                        <div class="fl comment0">
                            <i class="icon icon-comment-alt"></i>
                            <span>(<span id="span_replaycount${Id}">0</span>)</span>
                        </div>
                        <%--<div class="fl heart">
                            <i class="icon  icon-heart"></i>
                            <span>(1)</span>
                        </div>--%>
                        <div class="fl thumbs" onclick="ClickGood('${Id}','span_goodcount${Id}');">
                            <i id="span_goodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                            <span>(<span id="span_goodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                        </div>
                    </div>
                </div>
                <div class="comment_wrap clearfix none">
                    <ul class="commenta" id='comment_tp${Id}'></ul>
                    <div class="add_commentwrap">
                        <div class="add_comment">
                            <textarea id="commarea_${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                        </div>
                    </div>
                    <div class="editopt clearfix">
                        <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_${Id}');">评论</a>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_comment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
                <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/></div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}');"><i class="icon  icon-trash"></i></span>
                        {{/if}}  
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>
            </div>
        </li>
    </script>

    <%--笔记列表的绑定--%>
    <script id="li_note" type="text/x-jquery-tmpl">
        <li class="noteitem" id="li_note_${Id}">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">
                          {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}</span>
                    </div>
                    <div class="notecnt">${Name}</div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">${CreateTime_Format}</div>
                        
                    </div>
                    <div class="clearfix">
                        <div class="clearfix fl caozuo_none">
                            {{if IsCreate==1}}
                            <div class="fl" style="color: #0b70bc" onclick="DeleteTopic(${Id},'false',1,'ul_note');">
                                <i class="icon icon-trash" style="color: #0b70bc; display: inline-block;"></i>删除                                                                
                            </div>
                            {{/if}}                             
                        </div>
                        <div class="note_oper fr clearfix">
                            <div class="fl share" onclick="ChangeShareStatus('${Id}','img_share_${Id}','${IsCreate}');">
                                <i class="icon">
                                    <img id="img_share_${Id}" isshare="${IsShare}" src="${IsShare==0?'/images/share.png':'/images/share2.png'}" alt="" style="width: 100%" /></i>
                            </div>
                            <div class="fl comment1">
                                <i class="icon icon-comment-alt"></i>
                                <span>(<span id="span_notereplaycount${Id}">0</span>)</span>
                            </div>
                            <%--<div class="fl heart">
                                <i class="icon  icon-heart"></i>
                                <span>(1)</span>
                            </div>--%>
                            <div class="fl thumbs" onclick="ClickGood('${Id}','span_notegoodcount${Id}');">
                                <i id="span_notegoodcount${Id}_i" class="icon icon-thumbs-up" {{if GoodCount!=0}}style="color: #21A557;"{{/if}}></i>
                                <span>(<span id="span_notegoodcount${Id}" isgoodclick="${IsGoodClick}">${GoodCount}</span>)</span>
                            </div>
                        </div>
                    </div>
                    <!--回复信息隐藏-->
                    <div class="comment_wrap none">
                        <ul class="commenta" id='comment_note${Id}'></ul>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea id="commarea_note${Id}" name="" rows="" cols="" placeholder="请添加你的评论..."></textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr" onclick="javascript:AddTopic_Comment('${Id}','commarea_note${Id}','ul_note','li_note',1,'comment_note','li_notecomment','span_notereplaycount');">评论</a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>
    <script id="li_notecomment" type="text/x-jquery-tmpl">
        <li class="clearfix">
            <div class="imga fl">
             <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/></div>
            <div class="comment_contentwrap">
                <div class="comment_content">
                    <div class="comment_opt">
                        <span class="comment_name">${CreateName}</span>
                        <span class="comment_time">${CreateTime_Format}</span>
                        {{if IsCreate==1}}
                        <!--删除-->
                        <span class="del fr" onclick="DeleteTopic_Comment('${Id}','${TopicId}','ul_note',1,'comment_note','li_notecomment','span_notereplaycount');"><i class="icon  icon-trash"></i></span>
                        {{/if}}  
                    </div>
                    <div class="comment_desc">{{html Contents}}</div>
                </div>
            </div>
        </li>
    </script>

    <%--任务列表的绑定--%>
    <script id="li_task" type="text/x-jquery-tmpl">
        <li class="noteitem" onclick="JumpToTask(${RelationID},'${RelName}','${TaskType}','${ChapterID}','${ComCount}','${RelOtherField}','noself');">
            <div class="notedit">
                <a href="javascript:;" class="img">
                    <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                </a>
                <div class="mnc">
                    <div class="notehead clearfix">
                        <span class="note_user fl">${CreateName}</span>
                        <span class="note_lesson fr">
                           {{if ChapterName!=''}}${ChapterName} > {{/if}}{{if KnotName!=''}}${KnotName} > {{/if}}${ContentHName}
                        </span>
                    </div>
                    <div class="notecnt">${Name}<span class="test_type ml10" style="padding:0px 4px;">${TaskType}</span></div>
                    <div class="notecnt">
                        任务：${RelName}
                    ( 权重：${Weight} )   
                    {{if IsHasTask==1}}
                    {{if ComCount==0}}<span class="test_trouble">未完成</span>{{else}}<span class="test_type">已完成</span>{{/if}}
                    {{/if}}
                    </div>
                    <div class="noteinfo clearfix">
                        <div class="note_date fl">起止时间：${StartTime}~${EndTime}</div>
                        <div class="note_oper fr clearfix">
                            <%--<div class="fl">
                            <i class="icon icon-thumbs-up"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl comment3">
                            <i class="icon icon-comment-alt"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon  icon-heart"></i>
                            <span>(1)</span>
                        </div>
                        <div class="fl">
                            <i class="icon icon-share"></i>
                            <span>(1)</span>
                        </div>--%>
                        </div>
                    </div>
                    <!--任务评论隐藏-->
                    <div class="comment_wrap none">
                        <%--<ul class="commenta">
                        <li class="clearfix">
                            <img src="${PhotoURL}" alt="" onerror="javascript:this.src='/images/discuss_img_01.jpg'"/>
                            <div class="comment_contentwrap">
                                <div class="comment_content">
                                    <div class="comment_opt">
                                        <span class="comment_name">你好</span>
                                        <span class="comment_time">4月4号
                                        </span>
                                    </div>
                                    <div class="comment_desc">
                                        kjhj
                                    </div>
                                </div>
                            </div>
                        </li>                       
                    </ul>--%>
                        <div class="add_commentwrap">
                            <div class="add_comment">
                                <textarea name="" rows="" cols="">请添加你的评论...</textarea>
                            </div>
                        </div>
                        <div class="editopt clearfix">
                            <a href="javascript:;" class="fr">评论
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </script>

    <style type="text/css">
        .note_oper .heart .icon, .discuss-wrap .heart .icon {
            color: #D84A27;
        }
    </style>
</head>
<body>
    <input type="hidden" id="HInit_ChapterID" value="" />
    <input type="hidden" id="ChapterID" value="" />
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <input type="hidden" id="HStuIDCard" runat="server" />
    <input type="hidden" id="Hid_ClassID" value="<%=ClassID %>" />
    <!--header-->
    <header class="repository_header_wrap">
        <div class="width repository_header clearfix">
           <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
            <nav class="navbar menu_mid fl">
                <ul id="CourceMenu">
                    <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
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
    <div class="clear"></div>
    <div class="onlinestudy_wrap clearfix">
        <div class="onlinestudy_left fl">
            <div class="video_line"></div>
            <span class="onlinestudy_detail">
                <i class="icon icon-double-angle-right"></i>
            </span>
            <div class="onlinestudy_cromb">
                <div class="stytem_select_right">
                    <a href="javascript:;" onclick="LookAllJump(0);">
                        <i class="icon icon-reply"></i>
                        <span>返回课程详情页</span>
                    </a>
                </div>
                <p class="period">当前播放视频：<span id="span_curvideoname"></span></p>
            </div>
            <div class="videobox">
                <video id="playVideo" width="100%" height="100%" controls="controls" poster="/images/video.png">
                    <source src="" type="video/mp4"></source>
                    <source src="" type="video/ogg"></source>
                    <source src="" type="video/webm"></source>
                </video>
            </div>
            <a class="prev" onclick="SwitchVideo('prev');"><i class="icon  icon-angle-up"></i></a>
            <a class="next" onclick="SwitchVideo('next');"><i class="icon  icon-angle-down"></i></a>
            <div class="videoTab">
                <a href="javascript:;" class="left" onclick="VideoMove('left');"><i class="icon icon-angle-left"></i></a>
                <div class="videoTabbox">
                    <ul class="clearfix" id="ul_videotab"></ul>
                </div>
                <a href="javascript:;" class="right" onclick="VideoMove('right');"><i class="icon icon-angle-right"></i></a>
            </div>
        </div>
        <div class="onlinestudy_right fr">
            <dl class="study_detail clearfix" id="ul_mylessons"></dl>
            <div class="menu_wrap pr">
                <div class="menu_sidewrap">
                    <div class="menu_side">
                        <ul class="item_sides" id="menu_side"></ul>
                    </div>
                    <div class="data_lists none">
                        <ul class="lists" id="Resource"></ul>
                    </div>
                    <div class="data_discuss none">
                        <div class="forumsel_wrap">
                            <%--<div class="forumsel">
                                <span><b>综合讨论区</b> <i class="icon icon-angle-down"></i></span>
                                <div class="forumsel_none none">
                                    <span>综合讨论区</span>
                                    <span>老师答疑区</span>
                                </div>
                            </div>--%>
                            <div class="cmte_dit">
                                <textarea id="area_discuss" name="area_discuss" placeholder="填写讨论"></textarea>
                            </div>
                            <div class="editopt clearfix">
                                <a href="javascript:;" class="fr" onclick="javascript:AddTopic('area_discuss',0);">发起讨论</a>
                            </div>
                        </div>
                        <ul class="lists" id="ul_topic"></ul>
                        <a href="javascript:;" class="seeall" onclick="LookAllJump(1);">查看全部</a>
                    </div>
                    <div class="data_note none">
                        <h1>我的笔记</h1>
                        <div class="forumsel_wrap">
                            <div class="cmte_dit">
                                <textarea id="area_note" name="area_note" placeholder="填写你的笔记"></textarea>
                            </div>
                            <div class="editopt clearfix">
                                <a href="javascript:;" class="fr" onclick="javascript:AddTopic('area_note',1);">保存</a>
                            </div>
                        </div>
                        <h1>精选笔记</h1>
                        <div class="discuss_listswrap">
                            <ul id="ul_note"></ul>
                        </div>
                        <a href="javascript:;" class="seeall" onclick="LookAllJump(2);">查看全部</a>
                    </div>
                    <div class="data_work  none">
                        <div class="forumsel_wrap">
                            <%--<div class="cmte_dit">
                                <textarea name="">填写你的答案</textarea>
                            </div>
                            <div class="editopt clearfix">
                                <a href="javascript:;" class="fr">保存
                                </a>
                            </div>--%>
                            <div class="discuss_listswrap">
                                <ul id="ul_task"></ul>
                            </div>
                            <a href="javascript:;" class="seeall" onclick="LookAllJump(3);">查看全部</a>
                        </div>
                    </div>
                </div>
                <div class="menu_nav">
                    <ul>
                        <li class="active"><a href="javascript:;">目录</a></li>
                        <li><a href="javascript:;">资料</a></li>
                        <li><a href="javascript:;">讨论</a></li>
                        <li><a href="javascript:;">笔记</a></li>
                        <li><a href="javascript:;">任务</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="../js/common.js"></script>
    <script>
        function reSize() {
            $('.onlinestudy_wrap').height($(window).height() - $('header').height());
            $('.videobox').height(($('.onlinestudy_wrap').height() - $('.onlinestudy_cromb').height()) * 0.8);
            $('.menu_wrap').height($('.onlinestudy_wrap').height() - $('.study_detail').height());
        }
        $(function () {
            reSize();
            $(window).resize(reSize);
            //折叠菜单
            $('#menu_side').find('li:has(ul)').children('div').click(function () {
                $(this).parent('li').addClass('active').siblings().removeClass('active');
                var $next = $(this).next('ul');
                $next.slideDown();
                if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                    $(this).parent("li").siblings("li").find("ul").slideUp();
                }
            })
            //折叠菜单选中样式
            $('#menu_side li ul li ul li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
            })
            $('.onlinestudy_detail').click(function () {
                if ($('.onlinestudy_right').css('width') == '0px') {
                    $(this).find('.icon').addClass('icon-double-angle-right').removeClass('icon-double-angle-left');
                    $('.onlinestudy_left').animate({ 'width': '75%' }, 800);
                    $('.onlinestudy_right').animate({ 'width': '25%', 'right': 0 }, 800);
                } else {
                    $('.onlinestudy_left').animate({ 'width': '100%' }, 800);
                    $('.onlinestudy_right').animate({ 'width': 0, 'right': '-25%' }, 800);
                    $(this).find('.icon').addClass('icon-double-angle-left').removeClass('icon-double-angle-right');
                }
            })
            //右侧导航
            $('.menu_nav>ul>li').click(function () {
                $(this).addClass('active').siblings().removeClass('active');
                var n = $(this).index();
                $('.menu_sidewrap>div').eq(n).show().siblings().hide();
            })
            //讨论
            $('.forumsel>span').click(function () {
                $(this).next().toggle();
            })
            $('.forumsel_none>span').click(function () {
                var $text = $(this).text();
                $('.forumsel>span>b').text($text);
                $(this).parent().hide();
            })
        });
        window.onbeforeunload = function (e) {
            $.ajax({
                url: "/Common.ashx",
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                    Func: "OperSomeTableClick",
                    Clickid: curClickid,
                    RelationId: curVideoid,
                    WatchTime: currentTime,
                    ClickTime: curClicktime,
                    LastTime: curLasttime,
                    ClickNum: curClicknum,
                    IsLookEnd: curIsend,
                    DownTime: curDownTime,
                    TotalTime:curTotalTime,
                    UserIdCard: $("#HUserIdCard").val(),
                    ClassID: $("#Hid_ClassID").val()
                },
                success: function (json) { }
            });
        }
    </script>
</body>
<script type="text/javascript">
    var UrlDate = new GetUrlDate(); //实例化
    var videoArrayList = [];
    var curVideoid, curClickid, currentTime, curClicknum, curClicktime = 0, curLasttime = 0, curIsend = 0, curPlayingVideo = 0, curDownTime = 300;
    var curPage = 0,curTotalTime=0;
    var playVideo = document.getElementById('playVideo');//获取video元素
    //播放时间点更新时
    playVideo.addEventListener("timeupdate", function () {
        currentTime = playVideo.currentTime;//获取当前播放时间        
    });
    //播放结束事件
    playVideo.addEventListener('ended', function () {
        curIsend = 1;
        currentTime = 0;        
        PlayVideoClick("next");
    }, false);
    $(document).ready(function () {
        $("#CourceMenu li").eq(UrlDate.flag).addClass('active').siblings().removeClass('active');
        $("#HInit_ChapterID").val(UrlDate.initchapterid);
        $("#ChapterID").val(UrlDate.comchapterid);
        BindWeikeResource(UrlDate.videoid, "next");
        getData(1, 10);
        BindPutongResource();
        BindCourseTask(1, 5, " ", false);
    });
    //获取数据
    function getData(startIndex, pageSize) {
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
                CourseID: UrlDate.itemid,
                StuNo: $("#HUserIdCard").val(),
                ClassID: $("#Hid_ClassID").val()
            },
            success: OnSuccess,
            error: OnError
        });
    }
    function OnSuccess(json) {
        if (json.result.errNum.toString() == "0") {
            $("#ul_mylessons").html('');
            $("#li_mylessons").tmpl(json.result.retData.PagedData).appendTo("#ul_mylessons");
            $("#a_lessonname").html($(".mycourse_name").html());
            Chapator();
        }
        else {
            $("#ul_mylessons").html(json.result.errMsg.toString());
        }
    }
    function OnError(errMsg) {
        $("#ul_mylessons").html(errMsg);
    }
    var chapterDiv = "";
    var i = 0
    var j = 0;
    function Chapator() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CourceManage.ashx", Func: "Chapator", CourseID: UrlDate.itemid },
            success: function (json) {
                BindChapator("0", "0", json);
                $("#menu_side").html(chapterDiv);
                //折叠菜单
                $('#menu_side').find('li:has(ul)').children('div').click(function () {
                    ClearActiveClass();
                    $(this).parent('li').addClass('active');//.siblings().removeClass('active');
                    var $next = $(this).next('ul');
                    $next.slideDown();
                    if ($(this).parent('li').siblings('li').children('ul').is(':visible')) {
                        $(this).parent("li").siblings("li").find("ul").slideUp();
                    }
                    var CrentClass = $(this).attr("class");
                    var id1 = "";
                    var id2 = "";
                    var id3 = "";
                    var ChapterID = "";
                    var clickname = $(this).children().html();
                    if (CrentClass == "item_chapter") {
                        //$("#a_curchapter").html(clickname);
                        id1 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1;
                    }
                    else if (CrentClass == "item_knot") {
                        //$("#a_curknot").html(clickname);
                        id1 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                        id2 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1 + "|" + id2;
                    }
                    else {
                        //$("#a_curclass").html(clickname);
                        id1 = $(this).parent().parent().parent().parent().prev("div").attr("id").toString().substring(3);
                        id2 = $(this).parent().parent().prev("div").attr("id").toString().substring(3);
                        id3 = $(this).attr("id").toString().substring(3);
                        ChapterID = id1 + "|" + id2 + "|" + id3;
                    }
                    $("#ChapterID").val(ChapterID);
                    BindWeikeResource(0, "next");
                })
                knotContentHover($('.item_knot'));
                knotContentHover($('.item_content'));
                knotContentHover($('.item_chapter'));
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
        if (chapterDiv.length == 0) {
            layer.msg("无目录数据");
        }
    }
    function BindChapator(pid, perPid, json) {
        var Itemclass = "item_content"
        if (perPid == "0" && pid != "0") {
            Itemclass = "item_knot";
        }
        if (json.result.errNum.toString() == "0") {
            if (pid != "0" && perPid == "0" && i == 1) {
                chapterDiv += "<ul style='display:block'>";
            }
            if (pid != "0" && perPid == "0" && i > 1) {
                chapterDiv += "<ul style='display:none'>";
            }
            if (pid != "0" && perPid > 0 && j == 1) {
                chapterDiv += "<ul style='display:block'>";
            }
            if (pid != "0" && perPid > 0 && j > 1) {
                chapterDiv += "<ul style='display:none'>";
            }
            $(json.result.retData).each(function () {
                var divid = "div" + this.ID;
                var curclass = "";
                if (this.ID == $("#HInit_ChapterID").val()) {
                    curclass = " class='active'";
                }
                if (pid == "0" && this.Pid == pid) {
                    chapterDiv += "<li " + curclass + ">";
                    chapterDiv += "<div class=\"item_chapter\" id='" + divid + "'><span>" + this.Name + "</span><i class=\"icon  icon-angle-down\"></i></div>";
                    i++;
                    BindChapator(this.ID, this.Pid, json);
                    chapterDiv += "</li>";
                }
                if (pid != "0" && this.Pid == pid) {
                    chapterDiv += "<li " + curclass + "><div class=\"" + Itemclass + "\" id='" + divid + "'><span>" + this.Name + "</span></div>"
                    j++;
                    BindChapator(this.ID, this.Pid, json);
                    chapterDiv += "</li>"
                }
            })
            if (pid != "0") {
                chapterDiv += "</ul>";
            }
        }
        else {
            //layer.msg(json.result.errMsg);
        }
    }
    //微课资源
    function BindWeikeResource(playid, type) {
        $("#ul_videotab").html('');
        videoArrayList = [];
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 1, ChapterID: $("#ChapterID").val(), StuIdCard: $("#HStuIDCard").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        videoArrayList.push(this.FileUrl);
                        var video_li = " <li title=\"" + this.Name + "\" id=\"playV_" + this.ID + "\" playindex=\"" + (videoArrayList.length - 1) + "\" playname=\"" + this.Name + "\" fileurl=\"" + this.FileUrl + "\" clickid=" + this.ClickId + " clicknum=" + this.ClickNum + " watchtime=" + this.WatchTime + " islookend=" + this.IsLookEnd + " onclick=\"SetPlayValue(this.id);\">" + videoArrayList.length + "</li>";
                        $("#ul_videotab").append(video_li);
                    });
                    if (playid == 0) {
                        playid = $("#ul_videotab").find("li")[0].id.replace('playV_', '');
                    }
                    SetPlayValue("playV_" + playid);
                }
                else { layer.msg("暂无视频!"); $('video').removeAttr('src'); }
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
    }
    function PlayVideoClick(type) {
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/MyLessonsHandler.ashx",
                Func: "OperSomeTableClick",
                Clickid: curClickid,
                RelationId: curVideoid,
                WatchTime: currentTime,
                ClickTime: curClicktime,
                LastTime: curLasttime,
                ClickNum: curClicknum,
                IsLookEnd: curIsend,
                DownTime: curDownTime,
                TotalTime: curTotalTime,
                UserIdCard: $("#HUserIdCard").val(),
                ClassID: $("#Hid_ClassID").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    if (type == "next") {
                        curPlayingVideo++;
                        if (curPlayingVideo >= videoArrayList.length)
                            curPlayingVideo = 0; // 播放完了，重新播放
                    } else {
                        curPlayingVideo--;
                        if (curPlayingVideo <= 0) curPlayingVideo = 0;
                    }
                    var playid = $('#ul_videotab li[playindex="' + curPlayingVideo + '"]').attr('id').replace('playV_', '');
                    BindWeikeResource(playid, type);
                }
            },
            error: function (errMsg) { }
        });
    }
    function SetPlayValue(objid) {
        var $playobj = $("#" + objid);
        curPlayingVideo = $playobj.attr("playindex");
        var id = $playobj.attr("id").replace('playV_', ''), name = $playobj.attr("playname"),url = $playobj.attr("fileurl"), 
            clickid = $playobj.attr("clickid"), clicknum = $playobj.attr("clicknum"),
            watchtime = $playobj.attr("watchtime"), islookend = $playobj.attr("islookend");
        curVideoid = id;
        curClickid = clickid;
        curClicknum = clicknum;
        curIsend = islookend;
        if (clickid.toString() == "0") {
            curClicktime = DateTimeConvert(new Date(), "yyyy-MM-dd HH:mm:ss", false);
        } else {
            curLasttime = DateTimeConvert(new Date(), "yyyy-MM-dd HH:mm:ss", false);
        }
        curDownTime = 300;
        TimerDown();
        seleCheck();
        moveCheck();
        $("#span_curvideoname").html(name);
        $('video').prop('src', url);
        playVideo.play();
        $("#playVideo").on('loadedmetadata', function () {
            curTotalTime = playVideo.duration;//获取总时长
            if (watchtime.toString() != "0") {
                playVideo.currentTime = watchtime;
            }
        });        
    }
    function SwitchVideo(type) {
        PlayVideoClick(type);
    }
    function seleCheck() {
        var $tabBox = $('.videoTabbox');
        $tabBox.find('li').eq(curPlayingVideo).addClass('on').siblings().removeClass('on');
    }
    function moveCheck() {
        var $tabBox = $('.videoTabbox');
        var $width = $tabBox.find('li').outerWidth(true);
        var l = -curPlayingVideo * $width + 'px';
        $tabBox.find('ul').animate({ left: l }, 600);
    }
    function VideoMove(type) {
        var $tabBox = $('.videoTabbox');
        var $width = $tabBox.find('li').outerWidth(true);
        var $length = $tabBox.find('li').length;
        var zWidth = $('.videoTabbox ul').width($width * $length);
        if (type == "left") {
            curPage--;
            if (curPage <= 0) curPage = 0;
        } else {
            curPage++
            var maxl = Math.ceil($length / 4) - 1;
            if (curPage >= maxl) {
                curPage = maxl;
            }
        }
        var l = -curPage * $tabBox.width() + 'px';
        $tabBox.find('ul').animate({ left: l }, 600);
    }
    //普通资源
    function BindPutongResource() {
        $("#Resource").children().remove();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { PageName: "/CourseManage/CouseResource.ashx", "Func": "GetResourceList", CourceID: UrlDate.itemid, IsVideo: 0, ChapterID: $("#ChapterID").val() },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $(json.result.retData).each(function () {
                        var li = " <li class=\"clearfix\"><img style=\"width: 20px; height: 16px; float: left; margin-right: 2px;\" src=\"" + this.FileIcon + "\" onerror=\"javascript:this.src='/icons/ico-veizhib.png'\"><p class=\"repository_name fl\">" +
                this.Name + this.postfix + "</p><div class=\"repository_download none\" onclick=\"DownLoad('" + this.FileUrl + "');\"> <i class=\"icon icon-download-alt\"></i></div><span class=\"repository_date fr\">" +
                this.CreateTime + "</span></li>";
                        $("#Resource").append(li);
                    });
                    $('#Resource li').hover(function () {
                        $(this).find('.repository_download').show();
                    }, function () {
                        $(this).find('.repository_download').hide();
                    });
                }
                else { $("#Resource").html("<li>暂无资料！</li>"); }
            },
            error: function (errMsg) {
                layer.msg('加载失败！');
            }
        });
    }
    //取消左侧导航选中事件
    function ClearActiveClass() {
        $("#menu_side li").removeClass("active");
        $("#menu_side li ul li").removeClass("active");
        $("#menu_side  li ul li ul l").removeClass("active");
    }
    function knotContentHover(obj) {
        obj.hover(function () {
            $(this).children('div').show();
        }, function () {
            $(this).children('div').hide();
        })
    }
    function TimerDown() {
        var interval = setInterval(function () {
            if (curDownTime <= 0) {
                clearInterval(interval);
                return;
            }
            curDownTime--;
        }, 1000);
    }
</script>

<%-- 加载讨论的js--%>
<script type="text/javascript">
    $('.filtercri>a').click(function () {
        $(this).addClass('on').siblings().removeClass('on');
    });
    var user_pagetype = "stu";
    $(document).ready(function () {
        //加载讨论
        GetTopicData(1, 5, 0, " ", false);
        //加载笔记
        GetTopicData(1, 5, 1, " ", false, "ul_note", "li_note", "comment_note", "li_notecomment", "span_notereplaycount");
    });

    function AddTopic(areaid, type) {
        var name = $('#' + areaid).val().trim();
        if (!name.length) {
            layer.msg(type == 0 ? '请填写讨论！' : '请填写笔记！', { offset: ['220px', '80%'] });
            return;
        }
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/TopicHandler.ashx",
                Func: "AddTopic",
                CouseID: UrlDate.itemid,
                ChapterID: $("#ChapterID").val(),
                Name: name,
                Contents: " ",
                Type: type,
                UserIdCard: $("#HUserIdCard").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    if (type == 0) {
                        GetTopicData(1, 5, 0, " ", false);
                        $('#' + areaid).val('');
                    } else {
                        GetTopicData(1, 5, 1, " ", false, "ul_note", "li_note", "comment_note", "li_notecomment", "span_notereplaycount");
                        $('#' + areaid).val('');
                    }
                }
            },
            error: function (errMsg) {

            }
        });
    }

    function LookAllJump(index) { //查看全部时跳转
        location.href = "StuLessonDetail.aspx?itemid=" + UrlDate.itemid + "&nav_index=" + index + "&flag=" + UrlDate.flag;
    }
</script>
</html>
