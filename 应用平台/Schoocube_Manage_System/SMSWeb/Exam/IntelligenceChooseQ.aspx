<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="IntelligenceChooseQ.aspx.cs" Inherits="SMSWeb.Exam.IntelligenceChooseQ" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>智能组卷</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%-- 学段--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />

        <input id="bookVersion" type="hidden" value="0" />
        <!--难度-->
        <%--<input id="Difficult" type="hidden" value="0" />--%>
        <!--题型-->
        <input id="Type" type="hidden" value="0" />
        <!--题型分类-->
        <input id="hf_Type" type="hidden" value="2" />
        <asp:HiddenField ID="HPeriodid" runat="server" />
            <asp:HiddenField ID="HSubjectid" runat="server" />
            <asp:HiddenField ID="HTextbooxid" runat="server" />
            <asp:HiddenField ID="bookVersionid" runat="server" />
            <asp:HiddenField ID="HChapterIDid" runat="server" />
        <div>
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="/HZ_Index.aspx">
                <img src="/images/logo.png" /></a>
                    <div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
                    <nav class="navbar menu_mid fl">
                        <ul>
                            <li currentclass="active"><a href="ExamQManager.aspx?ParentID=19">题库管理</a></li>
                            <li currentclass="active"><a href="ExamManager.aspx?ParentID=19">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx?ParentID=19">我的试卷</a></li>
                            <li currentclass="active"><a href="charts.aspx?ParentID=19">分析统计</a></li>
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
            <div class="onlinetest_item width pt90 pr">
                <div class="stytem_items">
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            学年
                        </div>
                        <div class="stytem_items_list fl" id="Period">
                            <%-- <a href="javascript:;">学前教育</a>                           
                            <a href="javascript:;" class="on">学前教育</a>    --%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility:hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix a">
                        <div class="stytem_items_title fl">
                            科目
                        </div>
                        <div class="stytem_items_list fl" id="Subject">
                            <%--<a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix  none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion">
                            <%--<a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility:hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="text">
                        <div class="stytem_items_title fl">
                            教材
                        </div>
                        <div class="stytem_items_list fl" id="Textbook">
                            <%-- <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;" class="on">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>
                            <a href="javascript:;">学前教育</a>--%>
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr" style="visibility:hidden;">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                </div>
                <a href="javascript:;" class="moreoptions">
                        <span id="sput">更多选项</span><i class="icon icon-angle-down fr"></i>
                    </a>
            </div>
            <div class="width clearfix testsystem_wrap  pt20">
                <section class="menu fl">
                    <div class="grade pr">
                        <div class="item">
                            <span class="icon-th-list icon icon_list"></span>
                            <span class="title" id="textbook">全部</span>
                            <span class="icon icon-angle-right icon_right"></span>
                        </div>
                    </div>
                    <div class="items" id="menuChapater">
                    </div>
                </section>
                <div class="onlinetest_right fr bordshadrad pr">
                    <!---->
                    <div class="stytem_select clearfix">
                        <div class="stytem_select_left fl">
                            <a href="javascript:;" onclick="MakeExamPaperintelligent()">手动组卷</a>
                            <a href="javascript:;" class="on">智能组卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <a href="ExamManager.aspx?ParentID=19">
                                <i class="icon icon-reply"></i>
                                <span>试卷管理</span>
                            </a>
                        </div>
                    </div>
                    <div class="testassem">
                        <!--智能组卷-->
                        <div class="autotest">
                            <div class="autotest_steps">
                                <p class="autotest_step">
                                    第 <span>1 </span>步 题型难度设置
                                </p>
                                <div class="autotest_setting">
                                    <div class="clearfix">
                                        <label for="">题型难易程度：</label>
                                        <span class="select">
                                            <span value="0" id="Difficult">请选择</span><i class="icon icon-angle-down"></i>
                                            <div class="enable_wrap none">
                                                <span value="" class="active" onclick="annanduchaxun(null)">请选择</span>
                                                <span value="1" onclick="annanduchaxun(1)">简单</span>
                                                <span value="2" onclick="annanduchaxun(2)">中等</span>
                                                <span value="3" onclick="annanduchaxun(3)">困难</span>
                                            </div>
                                        </span>
                                        <i class="star"></i>
                                    </div>
                                </div>
                            </div>
                            <div class="autotest_steps">
                                <p class="autotest_step">
                                    第 <span>2 </span>步 题型数量设置
                                </p>
                                <div class="autotest_setting">
                                    <p class="test_number">
                                        题型数量：<span>已设置<span id="Number">0</span>道题</span>
                                    </p>
                                    <div class="test_setting clearfix">
                                        <span id="testqdiv"></span>
                                        <span id="testqdiv1"></span>
                                    </div>
                                </div>
                            </div>
                            <a href="javascript:;" onclick="MakeExamPaper()"><input type="button" name="" class="btn" value="开始组卷" /></a>
                           <%--<input type="text" onblur="importevent(this.value,'nhaom')" class="btn" value="0" />--%>
                        </div>
                    </div>
                </div>

                <!--试题篮返回顶部-->
                <div class="testbask_backtop">
                    <div class="test_bask">
                        <span class="icon icon-shopping-cart"></span>
                        <i class="test_num" id="i_test_num">0
                        </i>
                        <div class="test_basket_wrap none">
                            <h1>试题篮
							<span class="fr">共计<span id="tcount">0</span>题</span>
                            </h1>
                            <div class="test_basklists">
                                <ul id="baskul">
                                </ul>
                                <div class="releasebtn" id="ssss">
                                    <a href="javascript:;" onclick="ClearTestbask();">清空全部</a>
                                    <a href="javascript:;" onclick="MakeExamPaper()">组卷</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="backTop mt10">
                        <span class="icon  icon-angle-up"></span>
                    </div>
                </div>
            </div>
            <script type="text/javascript" src="/js/common.js" charset="utf-8"></script>
            <script type="text/javascript" src="/js/system.js" charset="utf-8"></script>
            <%--<script type="text/javascript" src="/js/addreduce.js"></script>--%>
            <script>

                $(function () {
                    //menu显示隐藏
                    $('.grade').find('.item').click(function () {
                        clickTab($('.grade'), '.icon_right');
                    });
                })
                //试题答案隐藏显示
                $('.test_lists_basket ul li').find('.quesdiv').click(function () {
                    var $hidden = $(this).children('.ques_answer');
                    if ($hidden.is(':hidden')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                });
                //点击checkbox显示隐藏答案
                $('.labelcheck').click(function () {
                    var $check = $(this).find('input[type=checkbox]');
                    var $hidden = $('.test_lists_basket').find('.ques_answer');
                    if ($check.is(':checked')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //试题库总数，右边显示 隐藏
                $('.test_bask').click(function () {
                    var $hidden = $(this).find('.test_basket_wrap');
                    if ($hidden.is(':hidden')) {
                        $hidden.show();
                    } else {
                        $hidden.hide();
                    }
                })
                //返回顶部
                backTop($('.backTop'), 400);
                //
                onscroll($('.testsystem_wrap>.menu'));
            </script>
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }
    function MakeExamPaper() {
        var Count = $("#tcount").html();

        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        if (Count == "0") {
            layer.msg("未选择试题");
        }
        else {
            var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter + "&url=IntelligenceChooseQ.aspx") : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&url=IntelligenceChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&url=IntelligenceChooseQ.aspx")) : ("?Period=" + Period + "&Subject=" + Subject + "&url=IntelligenceChooseQ.aspx")) : "?Period=" + Period + "&url=IntelligenceChooseQ.aspx") : "?url=IntelligenceChooseQ.aspx";
            location.href = "MarkExamPaper.aspx" + parm;
        }
    }
    function MakeExamPaperintelligent() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "ManualChooseQ.aspx" + parm;
    }
    var book = "";
    var HPeriodid = $("#HPeriodid").val();
    var HSubjectid = $("#HSubjectid").val();
    var HTextbooxid = $("#HTextbooxid").val();
    var bookVersionid = $("#bookVersionid").val();
    var HChapterIDid = $("#HChapterIDid").val();
    $(function () {
        $("#HPeriod").val(HPeriodid);
        $("#HSubject").val(HSubjectid);
        $("#bookVersion").val(bookVersionid);
        $("#HTextboox").val(HTextbooxid);
        $("#HChapterID").val(HChapterIDid);
        getBaskTypedata();
        BindCatagory();
        //getData();
    });
    function annanduchaxun(Difficulty) {
        //$('#Difficult').val(Difficulty);
        //getData();
        annanduchakexun(Difficulty);
        annanduchazhuxun(Difficulty);
    }
    function annanduchakexun(Difficulty) {
        var Klpoint = $("#HChapterID").val();
        var actionke = "checknumberke";
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "annanduchakexun","Difficulty": Difficulty, "Klpoint": Klpoint
            },
            success: function (json) {
                var html = "";
                //var count = 0;
                $.each(json.result.retData, function () {
                       // count = parseInt(this.Count) + parseInt(count);
                        html += "<div class=\"clearfix\">"
                                            +"<label for=\"\">"+this.Title+"</label>"
                                            + "<span onclick=\"addrandom('" + this.Title + "','"+actionke+"')\">+</span>"
                                            + "<input type=\"text\" onblur=\"importevent(this.value,'"+this.Title+"','"+actionke+"')\" value=\"0\" />"
                                            + "<span onclick=\"delrandom('" + actionke + "')\">-</span>"
                                            + "<em>共设置<i>0</i>道题</em>"
                                        +"</div>";


                });
                $("#testqdiv").html(html);
                
                //" + this.Title + ","+actionke+"
            }
        });
    }
    
    var arrke = [];
    var arrzhu = [];
    function importevent(value, Title,action) {
        //cd, Title, action
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "checktypeid", "Title": Title
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    
                    deletetype(this.ID);
                })
            }
        });
        for (var i = 0; i < value; i++) {
            addrandom(Title, action)
        }
    }
    function addrandom(Title, action) {
        var arrray = [];
        //Title, action
        var json = {};
        var id = 0;
        var actionke = "checkrandomIDke";
        var actionzhu = "checkrandomIDzhu";
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": action, "Title": Title 
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    arrray.push(this.ID);
                    
                })
                
                if (action == "checknumberke") {
                    
                    id = arrray[Math.floor(Math.random() * arrray.length)];
                    
                    if (!json[id]) {
                        json[id] = 1;
                        arrke.push(id);
                        checkrandom(id, actionke);
                    }
                } else if (action == "checknumberzhu") {
                    
                    id = arrray[Math.floor(Math.random() * arrray.length)];
                    
                    if (!json[id]) {
                        json[id] = 1;
                        arrzhu.push(id);
                        checkrandom(id, actionzhu);
                    }
                }
                    
            }
        });
    }
    function delrandom(action) {
        var id = 0;
        var actionke = "checkrandomIDke";
        var actionzhu = "checkrandomIDzhu";
        if (action == "checknumberke") {
            id = arrke[Math.floor(Math.random() * arrke.length)];
            arrke.splice($.inArray(id, arrke), 1);
            checkrandomdel(id, actionke);
        } else if (action == "checknumberzhu")
        {
            id = arrzhu[Math.floor(Math.random() * arrzhu.length)];
            arrzhu.splice($.inArray(id, arrzhu), 1);
            checkrandomdel(id, actionzhu);
            
            
        }
        
    }
    function checkrandomdel(id, action) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": action, "ID": id
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    DelqTextBasketbal(this, this.ID, this.Type, this.QType, this.Score);
                })
            }
        });
    }
    function checkrandom(id, action) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": action, "ID": id
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    AddTextBasketbal(this, this.ID, this.Type, this.QType, this.Score);
                })
            }
        });
    }
    function annanduchazhuxun(Difficulty) {
        var Klpoint = $("#HChapterID").val();
        var actionzhu = "checknumberzhu";
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "annanduchazhuxun", "Difficulty": Difficulty, "Klpoint": Klpoint
            },
            success: function (json) {
                var html = "";
                //var count = 0;
                $.each(json.result.retData, function () {
                    //count = parseInt(this.Count) + parseInt(count);
                    html += "<div class=\"clearfix\">"
                                        + "<label for=\"\" >" + this.Title + "</label>"
                                        + "<span onclick=\"addrandom('" + this.Title + "','" + actionzhu + "')\">+</span>"
                                        + "<input type=\"text\" onblur=\"importevent(this.value,'" + this.Title + "','" + actionzhu + "')\" value=\"0\" />"
                                        + "<span onclick=\"delrandom('" + actionzhu + "')\">-</span>"
                                        + "<em>共设置<i>0</i>道题</em>"
                                    + "</div>";
                });
                $("#testqdiv1").html(html);
                var totalText = $('.test_number').find('#Number');
                $('.test_setting>span>div').each(function () {
                    var $curInput = $(this).find('input');
                    var $add = $(this).find('span:eq(0)');
                    var $reduce = $(this).find('span:eq(1)');
                    var $curNumber = $(this).find('em').children('i');
                    $add.click(function () {
                        var n = Number($curInput.val()) + 1;
                        $curInput.val(n);
                        $curNumber.text(n);
                        totalText.text(sum());
                    })
                    $reduce.click(function () {
                        var n = Number($curInput.val()) - 1;
                        if (n < 0) {
                            return;
                        };
                        $curInput.val(n);
                        $curNumber.text(n);
                        totalText.text(sum());
                    })
                    $curInput.blur(function () {
                        var $val = Number($(this).val());
                        $curNumber.text($val);
                        totalText.text(sum());
                    })
                })
                function sum() {
                    var sum = 0;
                    $('.test_setting').find('em').children('i').each(function (i, elem) {

                        sum += Number($(elem).text());
                    })
                    return sum;
                }

                //$("#testqdiv").html() += $("#testqdiv").html(html);
            }
        });
    }
    function CheckNumber(obj, id, type) {
        if ($(obj).val().length > 0) {
            if (isNaN($(obj).val())) {
                alert("请正确输入！");
                $(obj).val($(obj).next().val());
                return;
            }
            if ($(obj).val().indexOf('.') >= 0 || $(obj).val() < 0) {
                alert("请输入正数！");
                $(obj).val($(obj).next().val());
                return;
            }
        } else {
            alert("请输入数量!");
            $(obj).val($(obj).next().val());
            return;
        }
        if ($(obj).val() == $(obj).next().val()) {
            return;
        }
        if (parseInt($(obj).val()) > parseInt($(obj).next().next().val())) {
            alert("请输入不超过总题数的数字!");
            $(obj).val($(obj).next().val());
            return;
        }
        var diff = $('#Difficult').attr('value');
        var num = $(obj).val();
        var oldnum = $(obj).next().val();
        if (id != null && id != "" && type != null && type != "" && num != null && num != "") {
            jQuery.ajax({
                url: "/Common.ashx",   // 提交的页面
                type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action":"ChangeNum",
                    "id": id, "type": type, "oldnum": oldnum, "num": num, "diff": diff
                },
                beforeSend: function ()          // 设置表单提交前方法
                {
                    //alert("准备提交数据");


                },
                error: function (request) {      // 设置表单提交出错
                    //alert("表单提交出错，请稍候再试");
                    //rebool = false;
                },
                success: function (result) {
                    if (result.result.errNum == 0) {
                        //修改显示（数量/金额）
                        if (parseInt($('#Number').html()) + parseInt(result.result.retData) >= 0) {
                            $('#Number').html(parseInt($('#Number').html()) + parseInt(json.result.retData));
                        }
                        $(obj).val(parseInt($(obj).next().val()) + parseInt(json.result.retData));
                        $(obj).next().val(parseInt($(obj).next().val()) + parseInt(json.result.retData));
                    } else {
                        $(obj).val($(obj).next().val());
                    }
                }

            });
        }
    }
    function AddTextBasketbal(obj, id, typeid, Qtype, Score) {
        //var isadd = $(obj).attr("disabled");
        //if (isadd != "disabled") {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "AddQToTesstBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score
            },
            success: function (json) {
                var html = "";
                var count = 0;
                if (json.result.errNum == 0) {
                    //$(obj).attr("disabled", "disabled");
                    $(obj).removeClass("ques_addbtn");
                    $(obj).addClass("ques_removebtn");
                    $(obj).html("移除试题");
                    $(obj).attr("onclick", "DelqTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    getBaskTypedata();
                }

            }
            // error: OnError
        });
        //}
        //var BookID = $("#hf_Book").val();
        //var KlpointID = $("#hf_Klpoint").val();
        //var parm = BookID.trim() != "" ? (KlpointID.trim() != "" ? ("?BookID=" + BookID + "&KlpointID=" + KlpointID) : "?BookID=" + BookID) : "";
        //OpenIFrameWindow('新增试题', 'AddQuestion.aspx' + parm, '450px', '70%');
    }
    function DelqTextBasketbal(obj, id, typeid, Qtype, Score) {
        var isadd = $(obj).attr("disabled");
        //if (isadd != "disabled") {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket", "ID": id, "Type": typeid, "QType": Qtype, "Score": Score
            },
            success: function (json) {
                var html = "";
                var count = 0;
                if (json.result.errNum == 0) {
                    // $(obj).attr("disabled", "disabled");
                    $(obj).removeClass("ques_removebtn");
                    $(obj).addClass("ques_addbtn");
                    $(obj).html("加入试题");
                    $(obj).attr("onclick", "AddTextBasketbal(this," + id + ", " + typeid + ", " + Qtype + "," + Score + ")");
                    getBaskTypedata();
                }

            },
            // error: OnError
        });
        //}
    }
    function getBaskTypedata() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "getTextBasketTypeQ"
            },
            success: function (json) {
                var html = "";
                var count = 0;
                $.each(json.result.retData, function () {
                    count = parseInt(this.Count) + parseInt(count);
                    html += "<li><span>" + this.Type + "</span><span>" + this.Count + " 题 </span><span><i class=\"icona icon-trash\" onclick=\"deletetype(" + this.TypeID + ")\"></i></span></li>";


                });
                $("#baskul").html(html);
                $("#tcount").html(count);
                $("#i_test_num").html(count);
            },
            // error: OnError
        });
    }
    function ClearTestbask() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket"
            },
            success: function (json) {
                getBaskTypedata();
            },
            // error: OnError
        });
    }
    function deletetype(typeid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "DelTestBasket", "Type": typeid
            },
            success: function (json) {
                getBaskTypedata();
            }
            // error: OnError
        });
    }
    function AddNum(obj, Id, typeid) {
        var prevobj = $(obj).next();
        var diff = $('#Difficult').attr('value');
        jQuery.ajax({
            url: "/Common.ashx",   // 提交的页面
            type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "AddNum",
                "id": Id, "type": typeid, "diff": diff },
            beforeSend: function ()          // 设置表单提交前方法
            {
                //alert("准备提交数据");


            },
            error: function (request) {      // 设置表单提交出错
                //alert("表单提交出错，请稍候再试");
                //rebool = false;
            },
            success: function (result) {
                if (result.result.errNum == 0) {
                    //修改显示（数量/金额）
                    var nownum = parseInt($(prevobj).val()) + parseInt(json.result.retData);
                    $(prevobj).val(nownum);

                    $('#Number').html(parseInt($('#Number').html()) + parseInt(json.result.retData));
                    $(prevobj).next().val(nownum);

                } else { $(prevobj).val($(prevobj).next().val()); }
            }

        });
    }
    function ReduceNum(obj, Id, typeid) {
        var nextvobj = $(obj).parent().find("[id$='txtNumber']");
        var newcount = parseInt($(nextvobj).val()) + parseInt(-1);
        var diff = $('#Difficult').attr('value');
        if (parseInt(newcount) >= 0) {
            jQuery.ajax({
                url: "/Common.ashx",   // 提交的页面
                type: "POST",                   // 设置请求类型为"POST"，默认为"GET"
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action":"ReduceNum",
                    "id": Id, "type": typeid, "diff": diff
                },
                beforeSend: function ()          // 设置表单提交前方法
                {
                    //alert("准备提交数据");


                },
                error: function (request) {      // 设置表单提交出错
                    //alert("表单提交出错，请稍候再试");
                    //rebool = false;
                },
                success: function (result) {
                    if (result.result.errNum == 0) {
                        //修改显示（数量）
                        $(nextvobj).val(parseInt($(nextvobj).val()) + parseInt(-1));

                        $('#Number').html(parseInt($('#Number').html()) + parseInt(-1));
                        $(nextvobj).next().val($(nextvobj).val());
                    } else { $(nextvobj).val($(nextvobj).next().val()); }
                }

            });
        }
    }
    function Chapator() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                //BindleftMenu(json);
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    BindleftMenu(json.result.retData, 0);
                    $("#menuChapater").html("");
                    $("#menuChapater").append(div);
                    menuSel();
                }
                else {
                    layer.msg(json.result.errMsg);
                }
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    var div = "";
    var TopMenuNum = 0;

    function BindleftMenu(data, id) {
        var i = 0;
        $(data).each(function () {
            if (this.TextbooxID == $("#HTextboox").val()) {

                if (this.PID == 0 && this.PID == id) {

                    div += "<div class=\"units\">";
                    div += " <div class=\"item_title\"><span class=\"text\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                    BindleftMenu(data, this.Id);
                    if (i > 0) {
                        div += "</ul>";
                    }
                    i = 0;
                    div += "</div>";
                    TopMenuNum++;
                }
                else if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li class=\"active\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(this.Id);
                        //getData(1, 10);
                    }
                    else if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    else if (i > 0) {
                        div += "<li onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
        //getData(1, 10);
    }
    $(function () {
        if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
            //getData(1, 10);
        }
    });

    function changeMenu(id) {
        $("#HChapterID").val(id);
        //getData(1, 10);
    }
    function menuSel()//menu折叠展开 选中切换
    {
        $('.items').find('.units').each(function () {
            var oLi = $('.items').find('li')
            oLi.click(function () {
                oLi.removeClass('active');
                $(this).addClass('active');
            });
            $(this).find('.item_title').click(function () {
                var $next = $(this).next();
                var $icon = $(this).find('.icon');
                $icon.toggleClass('active');
                $next.stop().slideToggle();
                $('.items').find('.contentbox').not($next).slideUp();
                $('.items').find('.icon').not($icon).removeClass('active');
            })
        })
    }
    //var CatagoryJson = "";
    function BindCatagory() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Period" },
            success: function (json) {
                CatagoryJson = json;
                //学年
                BindPeriod();
            },
            error: function (errMsg) {
                layer.msg(errMsg);
            }
        });
    }
    //学年
    function BindPeriod() {
        $("#Period").children().remove();
        option = "<a href=\"javascript:;\" id='0' onclick=' PeriodChangeall(0,this)' value=\"全部\">全部</a>";
        $("#Period").append(option);
        $("#HChapterID").val(0);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            for (var i = 0, nm = CatagoryJson.GradeOfSubject.retData; i < nm.length; i++) {

                if (i == 0) {
                    option = "<a href=\"javascript:;\" id=\"" + nm[i].GradeID + "\" onclick=' PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#HPeriod").val(HPeriodid);
                    $("#Period").append(option);
                    BindSubject();
                }
                else if (nm[i].GradeName != nm[i - 1].GradeName) {
                    option = "<a href=\"javascript:;\" id=\"" + nm[i].GradeID + "\"' onclick='PeriodChange(" + nm[i].GradeID + ",this)'>" + nm[i].GradeName + "</a>";
                    $("#Period").append(option);
                }

            }
            $("#" + HPeriodid + "").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
    }
    var gradeid = 0;
    var booo = "";
    function PeriodChangeall(GradeID, em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html("全部");
        gradeid = GradeID;
        $("#HTextboox").val(0);
        $("#HPeriod").val(GradeID);
        BindSubject();
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        $("#Title").attr("value", "");
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        book = "";
        booo = book;
        getData(1, 10);
    }

    function PeriodChange(GradeID, em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html("全部");
        gradeid = GradeID;
        book = "" + GradeID + "|%|%|%";
        $("#HTextboox").val(0);
        TopMenuNum = 0;
        $("#HPeriod").val(GradeID);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        BindSubject();
        booo = book;
        getData(1, 10);
    }
    //科目
    function BindSubject() {

        //var Period = $("#Period").val();
        //$("#HPeriod").val();
        $("#Subject").children().remove();
        var SelPeriod = $("#HPeriod").val();
        $("#HChapterID").attr("value", "");

        if (SelPeriod == "0") {
            option = "<a id='0' onclick='SubjectChange(this)'>全部</a>";
            $("#Subject").append(option);
            $("#HChapterID").attr("value", "");
            //版本
            TextbookVersion();
            return;
        }

        option = "<a id='0' onclick='SubjectChangeall(this)'>全部</a>";
        $("#Subject").append(option);
        if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
            var j = 0;
            $(CatagoryJson.GradeOfSubject.retData).each(function () {
                var option = "";
                if (this.GradeID == SelPeriod) {
                    if (j == 0) {

                        option = "<a id='" + this.SubjectID + "'  onclick='SubjectChange(this," + this.GradeID + ")'>" + this.SubjectName + "</a>";
                        //$("#HSubject").val(HSubjectid);
                        //版本
                        TextbookVersion();
                    }
                    else {
                        option = "<a id='" + this.SubjectID + "'onclick='SubjectChange(this," + this.GradeID + ")'> " + this.SubjectName + "</a>";
                    }
                    j++;
                    $("#Subject").append(option);
                }

            });
            $("#" + HSubjectid + "").attr("class", "on");
            if (HSubjectid > 0) {
                $("#textbookv").attr("style", "display: block;");
                $("#text").attr("style", "display: block;");
                $("#angle-down").attr("class", "icon fr icon-angle-up");
            }
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
    }
    var emid = 0;
    var bok = "";
    function SubjectChangeall(em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbookv").attr("style", "display: block;");
        $("#text").attr("style", "display: block;");
        $("#angle-down").attr("class", "icon fr icon-angle-up");
        $("#textbook").html("全部");
        emid = em.id;
        book = booo;
        $("#HSubject").val(em.id);
        TextbookVersion();
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        bok = book;
        getData(1, 10);
    }

    function SubjectChange(em, GradeID) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbookv").attr("style", "display: block;");
        $("#text").attr("style", "display: block;");
        $("#angle-down").attr("class", "icon fr icon-angle-up");
        $("#textbook").html("全部");
        emid = em.id;
        book = "" + GradeID + "|" + em.id + "|%|%";
        TopMenuNum = 0;
        $("#HSubject").val(em.id);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        TextbookVersion();
        bok = book;
        getData(1, 10);
    }
    //版本
    function TextbookVersion() {
        $("#TextbookVersion").children().remove();
        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#HChapterID").attr("value", "");
        $("#HTextboox").val(0);
        if (currentPeriod == "0" || currentSubjectID == "0") {
            option = "<a id='0' onclick='VersionChangeall(this)'>全部</a>";
            $("#TextbookVersion").append(option);
            $("#HChapterID").attr("value", "");
            Textbook();
            return;
        }
        option = "<a id='0' onclick='VersionChangeall(this)'>全部</a>";
        $("#TextbookVersion").append(option);
        if (CatagoryJson.TextbookVersion.errNum.toString() == "0") {
            var i = 0

            $(CatagoryJson.TextbookVersion.retData).each(function () {

                var option = "";
                if (i == 0) {

                    option = "<a id='" + this.Id + "'  onclick='VersionChange(this)'>" + this.Name + "</a>";
                    $("#bookVersion").val(bookVersionid);
                    Textbook();
                }
                else {
                    option = "<a id='" + this.Id + "' onclick='VersionChange(this)'>" + this.Name + "</a>";
                }
                $("#TextbookVersion").append(option);
                i++;
            });
            $("#" + bookVersionid + "").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.TextbookVersion.errMsg);
        }
    }
    var vcid = 0;
    var bk = "";
    function VersionChangeall(em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html("全部");
        vcid = em.id;
        book = bok;
        $("#bookVersion").val(em.id);
        Textbook();
        $("#HTextboox").val(0);
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        bk = book;
        getData(1, 10);
    }

    function VersionChange(em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html("全部");
        vcid = em.id;
        book = "" + gradeid + "|" + emid + "|" + vcid + "|%";
        i = 0;
        TopMenuNum = 0;
        $("#bookVersion").val(em.id);
        $(em).addClass("on").siblings().removeClass("on");
        $("#HTextboox").val(0);
        $("#HChapterID").attr("value", "");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
        Textbook();
        bk = book;
        getData(1, 10);
    }
    //教材
    function Textbook() {

        $("#HTextboox").val(0);
        var currentPeriod = $("#HPeriod").val();
        var currentSubjectID = $("#HSubject").val();
        $("#Textbook").children().remove();
        var bookVersion = $("#bookVersion").val();
        if (currentPeriod == "0" || currentSubjectID == "0" || bookVersion == "0") {
            option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
            $("#Textbook").append(option);
            $("#BookName").html("全部");
            $("#HTextboox").val("0");
            return;
        }
        option = "<a id='0' onclick=' TextbookChangeall(this)'>全部</a>";
        $("#Textbook").append(option);
        if (CatagoryJson.Textbook.errNum.toString() == "0") {

            var i = 0;
            $(CatagoryJson.Textbook.retData).each(function () {
                var option = "";
                if (bookVersion == this.VersionID && currentPeriod == this.GradeID && currentSubjectID == this.SubjectID) {

                    if (i == 0) {
                        option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                        $("#BookName").html(this.Name);
                        $("#HTextboox").val(HTextbooxid);
                        Chapator();
                    }
                    else {
                        option = "<a id='" + this.Id + "' onclick='TextbookChange(this)' name='" + this.Name + "'>" + this.Name + "</a>";
                    }
                    $("#Textbook").append(option);
                    i++;
                }

            });
            $("#" + HTextbooxid + "").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
    }
    var tbid = 0;
    var btk = "";
    function TextbookChangeall(em) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html("全部");
        tbid = em.id;
        book = bk;
        $("#HTextboox").val(em.id);
        //版本
        $(em).addClass("on").siblings().removeClass("on");
        $("#HChapterID").attr("value", "");
        $("#sel_Type").attr("value", "");
        $("#Title").attr("value", "");
        btk = book;
        Chapator();
        getData(1, 10);
    }

    function TextbookChange(em, name) {
        HPeriodid = "";
        HSubjectid = "";
        HTextbooxid = "";
        bookVersionid = "";
        HChapterIDid = "";
        $("#textbook").html(em.name);
        tbid = em.id;
        book = "" + gradeid + "|" + emid + "|" + vcid + "|" + tbid + "";
        TopMenuNum = 0;
        $(em).addClass("on").siblings().removeClass("on");
        $("#BookName").html($("#Textbook").text());
        $("#HTextboox").val(em.id);
        $("#HChapterID").attr("value", "");
        Chapator();
        btk = book;
        getData(1, 10);
    }
</script>


