<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EnterManage.aspx.cs" Inherits="SMSWeb.Recommended.EnterManage" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>推荐就业</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style>
        .add_commentwrap .add_comment {
            background: none repeat scroll 0 0 #FAFAFA;
            border: 1px solid #DFDFDF;
            box-shadow: inset 1px 1px 2px #DFDFDF;
            padding: 5px;
            height: 65px;
            position: relative;
        }

            .add_commentwrap .add_comment textarea {
                background: #fff;
            }

        .operating {
            height: 28px;
            position: relative;
            overflow: hidden;
            margin-right: 5px;
        }

            .operating a {
                margin-right: 0px;
            }

            .operating a {
                background: #83bfec;
            }

            .operating span {
                cursor: pointer;
                width: 20px;
                height: 20px;
                color: #fff;
                border-radius: 50%;
                background: red;
                position: absolute;
                top: -8px;
                right: -8px;
                font-size: 12px;
                line-height: 23px;
                text-indent: 3px;
                z-index: 99;
            }

        .operating_briefing {
            position: relative;
            border: 1px solid #ccc;
            padding: 10px;
        }

            .operating_briefing h1 {
                width: 70px;
                line-height: 30px;
                color: #666;
                font-size: 15px;
                margin-right: -80px;
                float: left;
            }

            .operating_briefing .content {
                margin-left: 75px;
                line-height: 20px;
                color: #666;
                font-size: 14px;
                float: left;
                padding: 5px 0px;
            }
    </style>

</head>

<body>
    <input type="hidden" id="CurrentID" />
    <input type="hidden" id="EnID" />
    <input type="hidden" id="JobID" />
    <input type="hidden" id="Introduction" />
    <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

    <!--header-->
    <header class="repository_header_wrap manage_header">
        <div class="width repository_header clearfix">
            <a href="index.html" class="logo fl">
                <img src="/images/logo.png" /></a>
            <div class="wenzi_tips fl">
                    <img src="../images/tuijianjiuye.png" /></div>
            <nav class="navbar menu_mid fl">
                <ul>
                    <li class="active"><a href="#">推荐就业</a></li>

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
                <div class="settings fl pr">
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

    <div class="pt90 width pb10">
        <div class="newcourse_select clearfix" style="background: #fff;">
            <div class="search_exam fl ml10 pr" style="margin-top: 10px;">
                <input type="text" name="txt_topicTitle" id="txt_topicTitle" value="" placeholder="请输入企业名称">
                <i class="icon  icon-search" style="top: 7px;" onclick="BindEnter(1, 10)"></i>
            </div>
            <div class="distributed fr">
                <a href="javascript:void(0);" onclick="AddEnterprise()" style="background: #1472b9"><i class="icon icon-plus"></i>添加企业</a>
            </div>
        </div>
    </div>
    <div id="NoEnterprise" style="display:none">
        <div class="onlinetest_item width">
            <div class="myexam bordshadrad">

                <div class="mycourse">
                    <ul class="mycourse_lists">
                        <li class="clearfix">
                            <div class="mycourse_mes">
                                <h1 class="mycourse_name">暂无企业信息</h1>
                                

                            </div>
                        </li>
                    </ul>
                </div>
                
                <div class="shadow">
                </div>
            </div>
        </div>
        
    </div>
    <div id="Enterprise">
        <%--<div class="onlinetest_item width" >
            <div class="myexam bordshadrad">

                <div class="mycourse">
                    <ul class="mycourse_lists">
                        <li class="clearfix">
                            <div class="mycourse_mes">
                                <h1 class="mycourse_name">暂无企业信息</h1>
                                <h2 class="clearfix">
                                    <div class="fl lecturer">
                                        负责人：
										<span>Marketing </span>
                                    </div>
                                    <div class="fl course_type">
                                        联系电话：
										<span>1868888888</span>
                                    </div>
                                    <div class="fl people_number">
                                        招聘人数：
										 <span>50</span>
                                    </div>
                                    <div class="fl class_venue">
                                        地址：
										 <span>上海市徐家汇商务大厦</span>
                                    </div>

                                </h2>

                            </div>
                        </li>
                    </ul>
                </div>
                <div class="coursedetail_nav">
                    <div class="fl operating">
                        <span>x</span>
                        <a href="javascript:;" onclick="ShowComment(this,'div7',1)">H5前端工程师</a>
                    </div>
                    <div class="fl operating">
                        <span>x</span>
                        <a href="javascript:;" onclick="ShowComment(this,'div7',2)">软件架构师</a>
                    </div>
                    <div class="fl operating">
                        <span>x</span>
                        <a href="javascript:;" onclick="ShowComment(this,'div7',3)">分布式开发</a>
                    </div>
                    <div class="fl operating">
                        <span>x</span>
                        <a href="javascript:;" onclick="ShowComment(this,'div7',4)">硬件工程师</a>
                    </div>
                    <div class="distributed fr" style="margin: 0px;">
                        <a href="javascript:void(0);" onclick="" style="background: #1472b9"><i class="icon icon-plus"></i>添加</a>
                    </div>
                </div>
                <div class="shadow">
                </div>
            </div>
        </div>--%>
        <%--<div class="width coursedetail_wrap mb10 bordshadrad none" id="div7">
            <div class="coursedetail clearfix pr">
                <div class="shadow_left">
                    <span></span>
                    <span></span>
                </div>
                <div class="shadow_right">
                    <span></span>
                    <span></span>
                </div>
                <!--岗位简介-->
                <div class="operating_briefing clearfix">
                    <h1>岗位简介:</h1>
                    <div class="content">
                        h5前端开发工程师 做webapp，微信开发
                    <br />
                        h5前端开发工程师 做webapp，微信开发
                    </div>
                </div>
                <div class="note_wrap">
                    <div class="discuss_listswrap">
                        <ul>
                            <li class="noteitem">
                                <div class="notedit">
                                    <a href="" class="img">
                                        <img src="/images/discuss_img_01.jpg" />
                                    </a>
                                    <div class="mnc">
                                        <div class="notehead clearfix">
                                            <span class="note_user fl">技术要求
                                            </span>
                                           
                                        </div>
                                        <div class="notecnt">
                                            H5前端工程师岗位对于技术方面及专业方面的要求                                 
                                        </div>
                                        <div class="noteinfo clearfix">
                                            <div class="note_date fl">
                                                7月18号
                                            </div>
                                            <div class="note_oper fr clearfix">

                                                <div class="fl comment">
                                                    <i class="icon icon-comment-alt"></i>
                                                    <span>(2)</span>
                                                </div>

                                            </div>
                                        </div>
                                        <!--讨论发表隐藏-->
                                        <div class="comment_wrap none">
                                            <ul class="commenta">
                                                <li class="clearfix">
                                                    <div class="imga">
                                                        <img src="/images/comment_img_01.jpg" alt="">
                                                    </div>
                                                    <div class="comment_contentwrap">
                                                        <div class="comment_content">
                                                            <div class="comment_opt">
                                                                <span class="comment_name">胡永娣</span>
                                                                <span class="comment_time">7月18号
                                                                </span>
                                                            </div>
                                                            <div class="comment_desc">
                                                                计算机专业、系统的学习过前端开发、精通css3及html5
                                                            </div>
                                                        </div>

                                                    </div>
                                                </li>
                                                <li class="clearfix">
                                                    <div class="imga">
                                                        <img src="/images/comment_img_01.jpg" alt="">
                                                    </div>
                                                    <div class="comment_contentwrap">
                                                        <div class="comment_content">
                                                            <div class="comment_opt">
                                                                <span class="comment_name">胡永娣</span>
                                                                <span class="comment_time">7月18号
                                                                </span>
                                                            </div>
                                                            <div class="comment_desc">
                                                                有工作经验优先
                                                            </div>
                                                        </div>

                                                    </div>
                                                </li>
                                            </ul>
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
                            <li class="noteitem">
                                <div class="notedit">
                                    <a href="" class="img">
                                        <img src="/images/discuss_img_01.jpg" />
                                    </a>
                                    <div class="mnc">
                                        <div class="notehead clearfix">
                                            <span class="note_user fl">专业要求
                                            </span>
                                           
                                        </div>
                                        <div class="notecnt">
                                            岗位的专业要求
                                        </div>
                                        <div class="noteinfo clearfix">
                                            <div class="note_date fl">
                                                4月18号
                                            </div>
                                            <div class="note_oper fr clearfix">

                                                <div class="fl comment">
                                                    <i class="icon icon-comment-alt"></i>
                                                    <span>(1)</span>
                                                </div>

                                            </div>
                                        </div>
                                        <!--讨论发表隐藏-->
                                        <div class="comment_wrap none">
                                            <ul class="commenta">
                                                <li class="clearfix">
                                                    <div class="imga">
                                                        <img src="/images/comment_img_01.jpg" alt="">
                                                    </div>
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

                                            </ul>
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

                        </ul>
                    </div>
                </div>
            </div>
        </div>--%>
    </div>
    <div class="page">
        <div id="pageBar"></div>
    </div>
    <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/system.js"></script>
    <script>
        $(function () {
            BindEnter(1, 10);
        })
        //企业信息
        function BindEnter(startIndex, pageSize) {
            //alert("123");
            //初始化序号 
            pageNum = (startIndex - 1) * pageSize + 1;
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "Recommended/Recommended.ashx", "Func": "GetEnterList", PageIndex: startIndex, pageSize: pageSize, "Name": $("#txt_topicTitle").val()
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#NoEnterprise").hide();
                        $("#Enterprise").html('');
                        $.each(json.result.retData.PagedData, function () {
                            var divID = "div" + this.ID;
                            var EnterID = "EnterID" + this.ID;
                            var html = "<div class=\"onlinetest_item width\"><div class=\"myexam bordshadrad\"><div class=\"mycourse\"><ul class=\"mycourse_lists\"><li class=\"clearfix\">" +
                                "<i onclick=\"DelEnterprise(" + this.ID + ")\" class=\"icon  icon-trash\" style='width:20px;height:20px;position:absolute;right:10px;top:10px;color:#1677BE;cursor:pointer;display:none;'></i><div class=\"mycourse_mes\"><h1 class=\"mycourse_name\">" +
                            this.Name + "</h1><h2 class=\"clearfix\"><div class=\"fl lecturer\">负责人： <span>" + this.RelationName +
                            " </span></div><div class=\"fl course_type\">联系电话 <span>" + this.RelationPhone
                            + "</span></div><div class=\"fl people_number\">招聘人数： <span>" + this.RecruitNum
                            + "</span></div><div class=\"fl class_venue\">地址：<span>" + this.Address + "</span></div><div class=\"fl class_venue\">公司简介：<span>" + this.Introduction +
                            "</span></div></h2></div></li></ul></div><div class=\"coursedetail_nav\" id=\"" +
                            EnterID + "\"></div><div class=\"shadow\"></div></div></div>";
                            $("#Enterprise").append(html);
                            $("#Enterprise").append("<div class=\"width coursedetail_wrap mb10 bordshadrad none\" id=\"" + divID + "\"></div>");

                            BindJob(this.ID);
                        })
                        //$("#div_Enter").tmpl(json.result.retData.PagedData).appendTo("#Enterprise");
                        makePageBar(BindEnter, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, pageSize, json.result.retData.RowCount);
                    }
                    else {
                        $("#NoEnterprise").show();
                        $("#Enterprise").html("");
                    }
                    $('.mycourse_lists li').hover(function () {
                        $(this).find('.icon').show();
                    }, function () {
                        $(this).find('.icon').hide();
                    })
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //企业岗位信息
        function BindJob(ID) {
            var Enterdivid = "EnterID" + ID;
            $("#" + Enterdivid).html("");
            $("#" + divid).html('');
            var divid = "div" + ID;
            var ulid = "ul" + ID;
            var JobDiv = "job" + ID;
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                data: {
                    "PageName": "Recommended/Recommended.ashx", "Func": "GetJobList", Ispage: false, "EnterID": ID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#" + divid).html("");
                        $.each(json.result.retData, function () {
                            var html = "<div class=\"fl operating\"><span onclick=\"DelJob(" + this.ID + "," + ID + ")\">x</span><a href=\"javascript:;\" onclick=\"ShowComment(this,'" + divid + "'," + this.ID + "," + ID + ",'" + this.Introduction + "')\">" + this.Name + "</a></div>";
                            $("#" + Enterdivid).append(html);
                        })
                        $("#" + Enterdivid).append(" <div class=\"distributed fr\" style=\"margin: 0px;\"><a href=\"javascript:void(0);\" onclick=\"AddEnterJob(" + ID + ")\" style=\"background: #1472b9\"><i class=\"icon icon-plus\"></i>添加岗位</a></div></div>");
                        $("#" + divid).append("<div class=\"coursedetail clearfix pr\"><div class=\"shadow_left\"><span></span><span></span></div><div class=\"shadow_right\"><span></span><span></span></div><div class=\"operating_briefing clearfix\"><h1>岗位简介:</h1><div class=\"content\" id=" + JobDiv + ">" +
                            "</div></div><div class=\"note_wrap\"><div class=\"discuss_listswrap\"><ul id=\"" +
                            ulid + "\"> </ul></div></div></div>");

                    }
                    else {
                        $("#" + Enterdivid).append(" <div class=\"distributed fr\" style=\"margin: 0px;\"><a href=\"javascript:void(0);\" onclick=\"AddEnterJob(" + ID + ")\" style=\"background: #1472b9\"><i class=\"icon icon-plus\"></i>添加岗位</a></div></div>");
                        $("#" + divid).append("<div class=\"coursedetail clearfix pr\"><div class=\"shadow_left\"><span></span><span></span></div><div class=\"shadow_right\"><span></span><span></span></div><div class=\"operating_briefing clearfix\"><h1>岗位简介:</h1><div class=\"content\" id=" + JobDiv + ">" +
                            "</div></div><div class=\"note_wrap\"><div class=\"discuss_listswrap\"><ul id=\"" +
                            ulid + "\"> </ul></div></div></div>");
                    }

                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //问题显示
        function ShowComment(em, EnterDivID, JobID, EnID, Introduction) {
            $("#EnID").val(EnID);
            $("#JobID").val(JobID);
            $("#Introduction").val(Introduction);
            var CurrentCss = $(em).attr("class");
            var CurrentID = $("#CurrentID").val();
            $("#CurrentID").val(JobID)
            if (CurrentID == JobID) {
                if (CurrentCss == "on") {
                    $("#" + EnterDivID).hide();
                    $(em).removeClass('on');
                }
                else {
                    BindComment(EnID, JobID, Introduction);
                    $(em).addClass('on').parent().siblings('.operating').children('a').removeClass('on');
                    $("#" + EnterDivID).show();
                }
            }
            else {
                BindComment(EnID, JobID, Introduction);
                $(em).addClass('on').parent().siblings('.operating').children('a').removeClass('on');
                $("#" + EnterDivID).show();
            }
        }
        //问题
        function BindComment(EnterID, JobID, Introduction) {
            var JobDiv = "job" + EnterID;
            $("#" + JobDiv).html(Introduction);
            var ulid = "ul" + EnterID;

            $("#" + ulid).html("");
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                async: false,
                data: { "PageName": "/Recommended/Recommended.ashx", "Func": "GetJobTopic", IsPage: false, JobID: JobID },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $.each(json.result.retData, function () {

                            var AnserdivID = "Anserdiv" + this.Id;
                            //var TId = this.Id;
                            $("#" + ulid).append("<li class=\"noteitem\"><div class=\"notedit\" style=\"margin-left:0;\"><div class=\"mnc\"><div class=\"notecnt\">" +
                                this.Contents + "</div><div class=\"noteinfo clearfix\"><div class=\"note_date fl\">" + this.CreateTime + "</div><div class=\"note_oper fr clearfix\">" +
           "<div class=\"fl comment\"><i class=\"icon icon-comment-alt\"></i><span>(0)</span> </div></div></div><div class=\"comment_wrap none\"><ul class=\"commenta\" id=" + AnserdivID
           + "></ul><div class=\"add_commentwrap\"><div class=\"add_comment\"><textarea name=\"\" rows=\"\" cols=\"\" id=\"Anser\">请添加你的回复...</textarea></div></div>" +
           "<div class=\"editopt clearfix\"><a href=\"javascript:;\" class=\"fr\" onclick=\"Comment(" + this.Id + ")\">回复" +
           "</a></div></div></div></div></div></li>");
                            BindAnser(AnserdivID);
                            var Num = $("#" + AnserdivID).children("li").length;

                        });
                    }
                    $('.comment').click(function () {
                        $(this).parents('li').find('.comment_wrap').toggle();
                    })
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });

        }
        function Comment(topicID) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    "PageName": "/Recommended/Recommended.ashx", "Func": "GetJobTopic_Comment", Contents: $("#Anser").val(), TopicId: topicID
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        BindComment($("#EnID").val(), $("#JobID").val(), $("#Introduction").val());
                    }
                    else { layer.msg(json.result.errMsg); }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //回复
        function BindAnser(AnserdivID) {
            var TopicId = AnserdivID.substring(8);
            $.ajax({
                url: "../Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                dataType: "json",
                async: false,
                data: {
                    "PageName": "/Recommended/Recommended.ashx", "Func": "GetJobTopic_Comment", IsPage: false, TopicId: TopicId
                },
                success: function (json) {
                    if (json.result.errNum.toString() == "0") {
                        $("#" + AnserdivID).html('');
                        $("#" + AnserdivID).parents(".mnc").find(".comment").find("span").html('(' + json.result.retData.length + ')')
                        $.each(json.result.retData, function () {
                            $("#" + AnserdivID).append("<li class=\"clearfix\"><div class=\"imga\"><img src=\"" + this.PhotoURL + "\" alt=\"\"></div><div class=\"comment_contentwrap\"><div class=\"comment_content\"><div class=\"comment_opt\">" +
     "<span class=\"comment_name\">" + this.CreateName + "</span><span class=\"comment_time\">" + this.CreateTime + "</span></div><div class=\"comment_desc\">" + this.Contents + "</div></div></div></li>");

                        })
                    }
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
        }
        //添加企业
        function AddEnterprise() {
            OpenIFrameWindow('添加企业', 'AddEnterprise.aspx', '350px', '480px');
        }
        //添加岗位
        function AddEnterJob(EnterID) {
            OpenIFrameWindow('添加岗位', 'AddEnterJob.aspx?EnterID=' + EnterID, '350px', '350px');
        }
        //删除岗位信息
        function DelJob(JobID, EnterID) {
            if (confirm("确定要删除岗位信息 吗？")) {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: {
                        "PageName": "/Recommended/Recommended.ashx", "Func": "DelJob", "JobID": JobID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("岗位信息删除成功！");
                            BindJob(EnterID);
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                })
            }
        }
        //删除企业信息
        function DelEnterprise(EnID) {
            if (confirm("确定要删除企业及相关信息吗？")) {

                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    dataType: "json",
                    async: false,
                    data: {
                        "PageName": "/Recommended/Recommended.ashx", "Func": "DelEnterprise", "EnterID": EnID
                    },
                    success: function (json) {
                        if (json.result.errNum.toString() == "0") {
                            layer.msg("企业信息删除成功！");
                            BindEnter(1, 10);
                        }
                        else {
                            layer.msg(json.result.errMsg);
                        }
                    },
                    error: function (errMsg) {
                        layer.msg(errMsg);
                    }
                })
            }
        }
    </script>
</body>
</html>

