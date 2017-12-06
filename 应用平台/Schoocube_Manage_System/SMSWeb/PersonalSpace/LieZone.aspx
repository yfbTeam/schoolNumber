<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LieZone.aspx.cs" Inherits="SMSWeb.PersonalSpace.LieZone" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>休闲区</title>
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
     <link  rel="stylesheet" type="text/css" href="/css/Css.css"/>
    <script type="text/javascript" src="/js/menu_top.js"></script>
     <script src="/Scripts/KindUeditor/kindeditor.js"></script>
    <script src="/Scripts/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Scripts/KindUeditor/lang/zh_CN.js"></script>
    <script src="/js/jquery.kkPages.js"></script>
    <style>
        .generalDom {
            border-bottom: 1px solid #ececec;
            padding: 10px;
        }
        .generalImg{width:93px;height:93px;border-radius:50%;border:1px solid #dcdcdc;margin-right: 15px;}
        .generalImg img {
            width:93px;height:93px;
        }
        .generalInfo h2 {
            font-size: 24px;
            font-weight: 500;
            color:#666;
        }
        .generalInfo p {
            margin-top: 10px;
        }
        .Concern {
            width: 71px;
            border: 1px solid #e1dfdf;;
        }
         .Concern, .onConcern a {
            display: inline-block;
            height: 26px;
            line-height: 24px;
            border-radius: 2px;
            text-align: center;
            box-shadow: 0 2px 3px #ececec;
        }
        .hotPlate a:hover, .Concern {
            color: #666;
            background: #f5f7f8;
        }
        .color_grey {
            color: #7b7b7b;
        }
        .color_red, .nav_list a:hover {
            color: #1775bc;
        }
        .postSingle {
            position: relative;
            min-height: 78px;
            padding: 10px;
            border-bottom: 1px solid #ececec;
        }
        .postSingle:hover{background: #f1f7fb;}
        .postTitle {
            font-size: 18px;
            height: 40px;
            line-height: 40px;
            font-weight: 100;
            position: relative;
        }
        .postTitle .titles {
            display: inline-block;
            max-width: 850px;
            vertical-align: bottom;
            color:#666;
        }
        .overflow {
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
         .postTitle b {
            position: absolute;
            right: 0;
            top: 3px;
        }
        .font18 {
            font-size: 18px;
        }
        .postImg ul li {
            float: left;
            margin: 10px 5px;
            height: 88px;
            line-height: 88px;
            max-width: 193px;
            min-width: 88px;
            text-align: center;
        }
        .postOper {
            height: 30px;
            padding-top: 8px;
        }

        .font12 {
            font-size: 12px;
        }
        .smallUser {
            position: relative;
        }
        .smallUser a span {
            display: inline-block;
            width: 25px;
            height: 25px;
            margin-right: 3px;
            overflow: hidden;
            border-radius:50%;
        }
        .eliteDom {
            border-bottom: 2px solid #ececec;
            margin-top: 10px;
        }
        .eliteDom a:hover, .eliteDom a.check {
            background: #fff;
            border-top: 2px solid #1775bc;
            border-bottom: 0;
            color: #1775bc;
        }
        .eliteDom a {
            display: block;
            float: left;
            width: 93px;
            height: 42px;
            line-height: 42px;
            text-align: center;
            background: #f5f7f8;
            margin-left: -1px;
            margin-bottom: -2px;
            transition: none;
            font-size:14px;
        }
        .eliteDom a {
            border: 1px solid #e1dfdf;
        }
        .mag_b11 {
            margin-bottom: 11px;
        }
        .font18 {
            font-size: 18px;
        }
        .textTitle {
            width: 98.5%;
            border:none;
            border:1px solid #ccc;
            height:35px;
            padding-left:1.5%;
            border-radius:2px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div>
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
        <div class="onlinetest_item width pt90 pr">
        <div class="space_centerwrap bordshadrad" style="padding:20px;background: #fff;">
            <div class="crumbs"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a> <span>&gt;</span><a href="/PersonalSpace/LieZone.aspx">就业区</a></div>
            <div class="generalDom clearfix">
                <div class="generalImg fl">
                    <img width="93" height="93" src="/images/community_02.png" alt="前端">
                </div>
                <div class="generalInfo">
                    <h2>休闲区</h2>
                    <p>
                        <a class="Concern" href="javascript:void(0);" id="concernSection" title="已关注"><i class="icon  icon-ok" style="display:inline-block;color:#1AA43B;"></i>已关注</a>
                    </p>
                    <p>
                        <span class="color_grey">帖子：<i class="color_red">45</i></span>
                        <i class="color_gray">&nbsp;&nbsp;|&nbsp;&nbsp;</i>
                        <span class="color_grey">粉丝：<i class="color_red">22</i></span>
                    </p>
                </div>
            </div>
            <div class="eliteDom clearfix">
                <a href="javascript:void(0);" class="check">全部</a>
            </div>
            <div class="community_wrap">
                <div class="postSingle">
                    <h2 class="postTitle">
                        <a href="javascript:;" target="_blank" class="overflow titles"  title="校园篮球比赛排名公布">校园篮球比赛排名公布</a>
                        <b class="color_red font18">0</b>
                    </h2>
                    <div class="postImg">
                        <ul class="postUlImg clearfix">
                        </ul>
                    </div>
                    <div class="postOper font12 clearfix">
                        <div class="fl smallUser">
                            <a href="" class="color_grey">
                                <span class="fl">
                                        <img width="25" height="25" src="/images/Ci27jlb2Gx2ASFzgAADHFMGWmVs371.jpg" >
                                </span>
                                <strong class="fl" style="line-height: 25px;">女王大人</strong>
                            </a>
                        </div>
                        <i class="dislb color_gray" style="line-height: 25px;">&nbsp;|&nbsp;</i>
                        <span class="dislb color_grey" style="line-height: 25px;">7月26日 11:39</span>
                        <span class="color_red dislb" style="line-height: 25px;">&nbsp;&nbsp;休闲</span>
                        <div class="fr" style="margin-top: 5px;">
                            <span titie="赞" class="color_red  dislb" style="line-height: 16px;"><i class="icon icon-thumbs-up dislb" style="float:left;color:#1AA43B;width:16px;height:16px;margin-right: 3px;"></i>7</span>
                            <i class="color_gray  dislb">&nbsp;&nbsp;|&nbsp;&nbsp;</i>
                            <span titie="预览" class="color_red  dislb" style="line-height: 16px;"><i class="icon icon-eye-open dislb" style="float:left;color:#999;width:16px;height:16px; margin-right: 3px;"></i>345</span>
                            <i class="color_gray dislb">&nbsp;&nbsp;|&nbsp;&nbsp;</i>
                            <span title="留言" class="color_gre dislb" style="line-height: 16px;"><i class="icon icon-comment-alt dislb" style="float:left;color:#999;width:16px;height:16px; margin-right: 3px;" ></i>最后回复：</span>
                            <span class=" dislb" style="line-height: 16px;">&nbsp;5373371&nbsp;</span>
                            <span class="color_grey dislb" style="line-height: 16px;">7月26日 17:11</span>
                        </div>
                    </div>
                </div>
                <div class="postSingle">
                    <h2 class="postTitle">
                        <a href="javascript:;" target="_blank" class="overflow titles"  title="餐厅好吃的饭是什么">餐厅好吃的饭是什么？</a>
                        <b class="color_red font18">3</b>
                    </h2>
                    <div class="postImg">
                        <ul class="postUlImg clearfix">
                        </ul>
                    </div>
                    <div class="postOper font12 clearfix">
                        <div class="fl smallUser">
                            <a href="" class="color_grey">
                                <span class="fl">
                                        <img width="25" height="25" src="/images/Ci27jlb8o1yAAVzUAAAXXN3q5BM579.jpg" >
                                </span>
                                <strong class="fl" style="line-height: 25px;">000425</strong>
                            </a>
                        </div>
                        <i class="dislb color_gray" style="line-height: 25px;">&nbsp;|&nbsp;</i>
                        <span class="dislb color_grey" style="line-height: 25px;">7月29日 11:39</span>
                        <span class="color_red dislb" style="line-height: 25px;">&nbsp;&nbsp;休闲</span>
                        <div class="fr" style="margin-top: 5px;">
                            <span titie="赞" class="color_red  dislb" style="line-height: 16px;"><i class="icon icon-thumbs-up dislb" style="float:left;color:#1AA43B;width:16px;height:16px;margin-right: 3px;"></i>3</span>
                            <i class="color_gray  dislb">&nbsp;&nbsp;|&nbsp;&nbsp;</i>
                            <span titie="预览" class="color_red  dislb" style="line-height: 16px;"><i class="icon icon-eye-open dislb" style="float:left;color:#999;width:16px;height:16px; margin-right: 3px;"></i>51</span>
                            <i class="color_gray dislb">&nbsp;&nbsp;|&nbsp;&nbsp;</i>
                            <span title="留言" class="color_gre dislb" style="line-height: 16px;"><i class="icon icon-comment-alt dislb" style="float:left;color:#999;width:16px;height:16px; margin-right: 3px;" ></i>最后回复：</span>
                            <span class=" dislb" style="line-height: 16px;">&nbsp;智商已欠费&nbsp;</span>
                            <span class="color_grey dislb" style="line-height: 16px;">7月29日 17:11</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="EditorDom bordshadrad width" style="background: #fff;margin-top: 20px;">
        <div style="padding:20px;">
            <p class="font18 mag_b11">发布内容</p>
            <div class="mag_b11" >
                <input class="textTitle" type="text"  maxlength="80" placeholder="请填写标题..." style="border-color: rgb(225, 223, 223); box-shadow: none;" />
            </div>
            <div class="textEditor mag_b11">
                  <textarea id="editor_id" name="content" style="width:100%;height:300px;"></textarea>
            </div>
            <div class="mag_b11 editopt clearfix">
                <a href="javascript:;" class="fr">
                    发表内容
                </a>
            </div>
        </div>
    </div>
        <footer>
        <div class="footer width clearfix">
            <div class="logo fl">
                <img src="/images/footer_logo.png" alt="" style="margin-top: 10px;" />
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
            KindEditor.ready(function (K) {
                window.editor = K.create('#editor_id', {
                    uploadJson: '',
                    allowFileManager: false,//true时显示浏览服务器图片功能。
                    allowImageRemote: false,//网络图片
                    resizeType: 0,
                    items: [
                        'source', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', "strikethrough",
                        'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
                        'insertunorderedlist', '|', 'undo', 'redo', '|', 'emoticons', 'image', 'link'],
                    afterFocus: function () {
                        self.edit = edit = this; var strIndex = self.edit.html().indexOf("请添加你的描述..."); if (strIndex != -1) { self.edit.html(self.edit.html().replace("请添加你的描述...", "")); }
                    },
                    //失去焦点事件
                    afterBlur: function () { this.sync(); self.edit = edit = this; if (self.edit.isEmpty()) { self.edit.html("请添加你的描述..."); } },
                    afterUpload: function (data) {
                        if (data.result) {
                            //data.url 处理
                        } else {

                        }
                    },
                    afterError: function (str) {
                        //alert('error: ' + str);
                    }
                });
            });
            $('.community_wrap').kkPages({
                PagesClass: '.postSingle', //需要分页的元素
                PagesMth: 6, //每页显示个数
                PagesNavMth: 4 //显示导航个数
            });
    </script>
    </div>
    </form>
</body>
</html>
