<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MarkExamPaper.aspx.cs" Inherits="SMSWeb.Exam.MarkExamPaper" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>组卷</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
    <link rel="stylesheet" type="text/css" href="../css/onlinetest.css" />
    <script type="text/javascript" src="../js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="../js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="../js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <%-- 学年--%>
        <input id="HPeriod" type="hidden" value="0" />
        <%-- 科目--%>
        <input id="HSubject" type="hidden" value="0" />
        <%-- 教材--%>
        <input id="HTextboox" type="hidden" value="0" />
        <%-- 目录--%>
        <input id="HChapterID" type="hidden" value="0" />

        <input id="bookVersion" type="hidden" value="0" />
        <!--难度-->
        <input id="Difficult" type="hidden" value="0" />
        <!--题型-->
        <input id="Type" type="hidden" value="0" />
        <!--题型分类-->
        <input id="hf_Type" type="hidden" value="2" />
        <input id="hname" type="hidden" runat="server" />
        <asp:HiddenField ID="hIDCard" runat="server" />
        <asp:HiddenField ID="HPeriodid" runat="server" />
            <asp:HiddenField ID="HSubjectid" runat="server" />
            <asp:HiddenField ID="HTextbooxid" runat="server" />
            <asp:HiddenField ID="bookVersionid" runat="server" />
            <asp:HiddenField ID="HChapterIDid" runat="server" />
            <asp:HiddenField runat="server" ID="srcurl" />
        <div>
            
            <header class="repository_header_wrap manage_header">
                <div class="width repository_header clearfix">
                    <a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
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
                         <a href="/PersonalSpace/PersonalSpace_Teacher.aspx target="_blank""><span>个人中心</span></a>
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
                        </div>
                        <a href="javascript:;" class="stytem_items_more fr">
                            <span>更多</span>
                            <i class="icon icon-angle-down"></i>
                        </a>
                    </div>
                    <div class="stytem_item clearfix none" id="textbookv">
                        <div class="stytem_items_title fl">
                            版本
                        </div>
                        <div class="stytem_items_list fl" id="TextbookVersion">
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
                            <a href="javascript:;" id="hand" onclick="MakeExamPaper()">手动组卷</a>
                            <a href="javascript:;" id="intelligent" onclick="MakeExamPaperintelligent()">智能组卷</a>
                        </div>
                        <div class="stytem_select_right fr">
                            <a href="ExamManager.aspx?ParentID=19">
                                <i class="icon icon-reply"></i>
                                <span>试卷管理</span>
                            </a>
                        </div>
                    </div>
                    <div class="testassem">
                        <!--手动组卷-->
                        <div class="manualtest">
                            <!--面包屑-->
                            <div class="crumbs">
                                <a href="javascript:;" id="src"></a>
                                <span>></span>
                                <a href="MarkExamPaper.aspx">组卷</a>
                            </div>
                            <div class="manualtest_title clearfix">
                                <div class="clearfix fl">
                                    <label for="">请输入试卷名称：</label>
                                    <input type="text" placeholder="请输入试卷名称" class="manualtest_name" id="ExaminationName" />
                                    <i class="star"></i>
                                </div>
                                <div class="clearfix fl">
                                    <label for="">完成时间：</label>
                                    <input type="text" placeholder="请输入时间" class="manualtest_time" id="ExaminationTime" />
                                    <em class="fl  minute">分钟</em>
                                    <i class="star"></i>
                                </div>
                                <div class="clearfix fl">
                                    <label for="">题型难易程度：</label>
                                    <span class="select">
                                        <span value="0" id="diffice">请选择</span><i class="icon icon-angle-down"></i>
                                        <div class="enable_wrap none">
                                            <span value="0" class="active">请选择</span>
                                            <span value="1">简单</span>
                                            <span value="2">中等</span>
                                            <span value="2">困难</span>
                                        </div>
                                    </span>
                                    <i class="star"></i>
                                </div>
                                <div class="clearfix fl">
                                    <label for="">状态：</label>
                                    <span class="select">
                                        <span value="1" id="Staticc">启用</span><i class="icon icon-angle-down"></i>
                                        <div class="enable_wrap none">
                                            <span value="1" class="active">启用</span>
                                            <span value="2">禁用</span>
                                        </div>
                                    </span>
                                    <i class="star"></i>
                                </div>
                                <div class="fl clearfix" >
                                    <label for="">适用范围:</label>
                                    <input type="radio" name="radio" id="exam" value="1" checked="checked" />
                                    <label for="">考试</label>
                                    <input type="radio" name="radio" id="ceaxm" value="2" />
                                    <label for="">测验</label>
                                    <input type="radio" name="radio" id="cesam" value="3" />
                                    <label for="">作业</label>
                                    <input type="radio" name="radio" id="cesam" value="4" />
                                    <label for="">问卷调查</label>
                                    <i class="star"></i>
                                </div>
                                <div class="fl clearfix" id="zongfen">
                                </div>
                            </div>
                           <div class="manualtest_settings">
                               <span id="seetings"></span>
                               <span id="seetings1"></span>
                            </div>
                        </div>
                        
					<h1 class="testassem_btn">
						<div>
							<a href="javascript:;" class="back_testassem" id="return">返回组卷</a>
							<a href="javascript:;" id="ADDExamExamination" class="back_testassem" onclick="ADDExamExamination()" style="background-color:blue;">确认组卷</a>
						</div>
					</h1>
                    </div>
                    <div class="confirm_testassemdialog none" id="confirm_testassemdialog">
					<div class="testdialog_title">
						确认组卷
						<span class="close fr">
							<i class="icon icon-remove"></i>
						</span>
					</div>
					<div class="testassem_succcess">
						<i class="icon icon-ok"></i>
					</div>
					<p>恭喜您组卷成功！</p>
					<p>您可以返回试卷管理进行<a href="ExamManager.aspx?ParentID=19">【试卷发布】</a></p>
					<p>或者<a href="ManualChooseQ.aspx?ParentID=19">【继续组卷】</a></p>
				</div>
                </div>
                <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
                <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
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
        </div>
    </form>
</body>
</html>
<script type="text/javascript">
    var sxk = 0;
    var sxz = 0;
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }
    function MakeExamPaper() {
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
    function MakeExamPaperintelligent() {
        var Period = $("#HPeriod").val();
        var Subject = $("#HSubject").val();
        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        var bookVersion = $("#bookVersion").val();
        var Textboox = $("#HTextboox").val();
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        var Chapter = $("#HChapterID").val();
        var parm = Period.trim() != "" ? (Subject.trim() != "" ? (bookVersion.trim() != "" ? (Textboox.trim() != "" ? (Chapter.trim() != "" ? ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox + "&Chapter=" + Chapter) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion + "&Textboox=" + Textboox)) : ("?Period=" + Period + "&Subject=" + Subject + "&bookVersion=" + bookVersion)) : ("?Period=" + Period + "&Subject=" + Subject)) : "?Period=" + Period) : "";
        location.href = "IntelligenceChooseQ.aspx" + parm;
    }

    var book = "";
    var srcurl = $("#srcurl").val();
    var url="";
    if (srcurl == "ManualChooseQ.aspx") {
        url = "手动组卷";
        $("#hand").attr("class", "on");
        $("#return").attr("onclick", "MakeExamPaper()");
        $("#hand").attr("onclick", "MakeExamPaper()");
        $("#src").attr("onclick", "MakeExamPaper()");
    } else {
        url = "智能组卷";
        $("#intelligent").attr("class", "on");
        $("#return").attr("onclick", "MakeExamPaperintelligent()");
        $("#intelligent").attr("onclick", "MakeExamPaperintelligent()");
        $("#src").attr("onclick", "MakeExamPaperintelligent()");
    }
    $("#src").html(url);
    var HPeriodid = $("#HPeriodid").val();
    var HSubjectid = $("#HSubjectid").val();
    var HTextbooxid = $("#HTextbooxid").val();
    var bookVersionid = $("#bookVersionid").val();
    var HChapterIDid = $("#HChapterIDid").val();
    if (HSubjectid != "0") {
        $("#sput").html("收起");
    }
    $(function () {
        $("#HPeriod").val(HPeriodid);
        $("#HSubject").val(HSubjectid);
        $("#bookVersion").val(bookVersionid);
        $("#HTextboox").val(HTextbooxid);
        $("#HChapterID").val(HChapterIDid);
        BindCatagory();
        //Chapator();
        getBaskdata();
        //getType();
    });
    function getBaskdata() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "getTestBasket"
            },
            success: function (json) {
                var action="";
                var html = "";
                var count = "";
                var Score = 0;
                var div = "";
                var num="";
                $.each(json.result.retData, function () {
                    Score += parseInt(this.Score);
                    if (this.QType == 1)
                    {
                        num += this.ID + ',';
                    }
                    else if (this.QType == 2)
                    {
                        count += this.ID + ',';
                    }
                });
                num = num.substr(0, num.length - 1);
                count = count.substr(0, count.length - 1);
                chaxuntileike(count);
                chaxunmuke(count);
                chaxunzhu(num);
                div += "<label for=\"\">试卷总分：</label>"
                                    + "<span class=\"fl test_sum\" id=\"zongfeng\" value=\"" + Score + "\">" + Score + "</span>";
                chaxuntileizhu(num);
                $("#zongfen").html(div);
            },
             //error: OnError
        });
    }
    var fhr = "";
    function chaxuntileike(count) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            //async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileike", "ID": count
            },
            success: function (json) {
                
                $.each(json.result.retData, function () {
                    
                    fhr += "<div class=\"maunualtest_type\">"
                                    + "<div class=\"maunualtest_type_name clearfix\">"
                                        + "<div class=\"fl test_type_name\">"
                                            + "<span>" + this.Title + "</span>"
                                            + "<em>" + this.sum + "</em>"
                                        + "</div>"
                                        + "<div class=\"fl test_type_settings ml20\">"
                                            + "<em>总" + this.score + "分"
                                            + "</em>"
                                        + "</div>"
                                        + "<div class=\"maunualtest_type_silde fr\">"
                                            + "<i class=\"icon icon-angle-up active\"></i>"
                                        + "</div>"
                                    + "</div>"
                                    + "<div class=\"maunualtest_type_detail\" style=\"display: block;\">"
                                        + "<div class=\"test_detail\" id=\"tixianshi\">";
                     chaxunzhutimuke(this.Title, count);
                     fhr += "<div class=\"revise none\">"
                                             + "<i class=\"icon icon_moveup\"></i>"
                                             + "<i class=\"icon icon_movedown\"></i>"
                                             + "<i class=\"icon icon-trash\"></i>"
                                         + "</div>"
                                         + "</div>"
                                     + "</div>"
                                 + "</div>";
                     $('#seetings').html(fhr);
                });
                
                
                
            }
        })
    }
    var objective = "";
    function chaxunzhutimuke(Title, count)
    {
        
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuke", "ID": count, "Title": Title
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    sxk++;
                    fhr += "<li><div>";
                    fhr += "<h1>";
                    fhr += "	<em>" + this.Title + "</em>";
                    fhr += "	<span>(" + this.Score + "分)</span>";
                    fhr += "	</h1>";
                    if (this.QType == 2) {
                        if (this.OptionA != "") {
                            var OptionA = "";
                            OptionA = "" + this.OptionA + "";
                            OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                            if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                                fhr += "A.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>A：" + this.OptionA + "</p>"; }

                        }
                        if (this.OptionB != "") {
                            var OptionB = "";
                            OptionB = "" + this.OptionB + "";
                            OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                            if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                                fhr += "B.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>B：" + this.OptionB + "</p>"; }

                        }
                        if (this.OptionC != "") {
                            var OptionC = "";
                            OptionC = "" + this.OptionC + "";
                            OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                            if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                                fhr += "C.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>C：" + this.OptionC + "</p>"; }

                        }
                        if (this.OptionD != "") {
                            var OptionD = "";
                            OptionD = "" + this.OptionD + "";
                            OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                            if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                                fhr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>D：" + this.OptionD + "</p>"; }

                        }
                        if (this.OptionE != "") {
                            var OptionE = "";
                            OptionE = "" + this.OptionE + "";
                            OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                            if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                                fhr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>E：" + this.OptionE + "</p>"; }

                        }
                        if (this.OptionF != "") {
                            var OptionF = "";
                            OptionF = "" + this.OptionF + "";
                            OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                            if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                                fhr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>F：" + this.OptionF + "</p>"; }

                        }
                    }
                    fhr += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    fhr += " <span >解析：" + this.Analysis + "</span></p>";
                    fhr += "<input type=\"text\" name=\"OrderID\" placeholder=\"请输入题目显示顺序\" value=\"" + sxk + "\" /><i class=\"star\"></i>";
                    fhr += "</div>";
                    fhr += "</li>";
                    
                    
                });
                
                
            }
        })
    }
    var htmll = "";
    function chaxuntileizhu(num) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileizhu", "ID": num
            },
            success: function (json) {
                
                $.each(json.result.retData, function () {
                    htmll += "<div class=\"maunualtest_type\">"
                                    + "<div class=\"maunualtest_type_name clearfix\">"
                                        + "<div class=\"fl test_type_name\">"
                                            + "<span>" + this.Title + "</span>"
                                            + "<em>" + this.sum + "</em>"
                                        + "</div>"
                                        + "<div class=\"fl test_type_settings ml20\">"
                                            + "<em>总" + this.score + "分"
                                            + "</em>"
                                        + "</div>"
                                        + "<div class=\"maunualtest_type_silde fr\">"
                                            + "<i class=\"icon icon-angle-up active\"></i>"
                                        + "</div>"
                                    + "</div>"
                                    + "<div class=\"maunualtest_type_detail\" style=\"display: block;\">"
                                        + "<div class=\"test_detail\" id=\"tixianshi\">";
                    chaxunzhutimuzhu(this.Title, num);
                    htmll += "<div class=\"revise none\">"
                        + "<i class=\"icon icon_moveup\"></i>"
                        + "<i class=\"icon icon_movedown\"></i>"
                        + "<i class=\"icon icon-trash\"></i>"
                    + "</div>"
                    + "</div>"
                + "</div>"
            + "</div>";
										$('#seetings1').html(htmll);
                });
                
            }
        })
    }
    var subjective = "";
    function chaxunzhutimuzhu(Title, num) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuzhu", "ID": num, "Title": Title
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    sxz++;
                    htmll += "<li><div>";
                    htmll += "<h1>";
                    htmll += "	<em>" + this.Title + "</em>";
                    htmll += "	<span>(" + this.Score + "分)</span>";
                    htmll += "	</h1>";
                    if (this.QType == 2) {
                        if (this.OptionA != "") { htmll += "<p>A：" + this.OptionA + "</p>"; }
                        if (this.OptionB != "") { htmll += "<p>B：" + this.OptionB + "</p>"; }
                        if (this.OptionC != "") { htmll += "<p>C：" + this.OptionC + "</p>"; }
                        if (this.OptionD != "") { htmll += "<p>D：" + this.OptionD + "</p>"; }
                        if (this.OptionE != "") { htmll += "<p>E：" + this.OptionE + "</p>"; }
                        if (this.OptionF != "") { htmll += "<p>F：" + this.OptionF + "</p>"; }
                    }
                    htmll += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    htmll += " <span >解析：" + this.Analysis + "</span></p>";
                    htmll += "<input type=\"text\" name=\"OrderIDzhu\" placeholder=\"请输入题目显示顺序\" value=\"" + sxz + "\" /><i class=\"star\"></i>";
                    htmll += "</div>";
                    htmll += "</li>";


                });


            }
        })
    }
    function chaxunzhu(num) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhu", "ID": num,
            },
            success: function (json) {
                subjective = json.result.retData;
            }
        })
    }
    function chaxunmuke(count) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunke", "ID": count,
            },
            success: function (json) {
                objective = json.result.retData;
            }
        })
    }

    function ADDExamExamination()
    {
        var jk = 1;
        var Author = $("#hname").val();
        var Klpoint = $("#HChapterID").val();
        if (Klpoint != 0) {
            var ExaminationName = $('#ExaminationName').val();
            if (ExaminationName != "") {
                var ExaminationTime = $('#ExaminationTime').val();
                if (ExaminationTime != "") {
                    var Book = $("#HPeriod").val() + "|" + $("#HSubject").val() + "|" + $("#bookVersion").val() + "|" + $("#HTextboox").val();
                    if (Book != "") {
                        var IsRelease = 2;
                        var math = new Date();
                        var CreateTime = math.toLocaleDateString();
                        CreateTime = CreateTime.replace("年", "/");
                        CreateTime = CreateTime.replace("月", "/");
                        CreateTime = CreateTime.replace("日", "");
                        CreateTime = CreateTime.replace("下午", "");
                        CreateTime = CreateTime.replace("上午", "");
                        var diffice = $('#diffice').attr("value");
                        if (diffice != 0) {
                            var examtype = $('input[name="radio"]:checked ').val();
                            var zongfen = $('#zongfeng').attr("value");
                            var Static = $('#Staticc').attr("value");
                            $("input[name='OrderIDzhu']").each(function () {
                                if ($(this).val() == "") {
                                    jk = 0;
                                }
                            });
                            $("input[name='OrderID']").each(function () {
                                if ($(this).val() == "") {
                                    jk = 0;
                                }
                            });
                            if (jk == 1) {
                                $.ajax({
                                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                                    type: "post",
                                    async: false,
                                    dataType: "json",
                                    data: {
                                        PageName: "/Exam/ExamHandler.ashx",
                                        "action": "addexamlist",
                                        "Title": ExaminationName, "ExamTime": ExaminationTime, "Difficulty": diffice, "Status": Static, "Type": examtype, "FullScore": zongfen, "Klpoint": Klpoint, "Book": Book, "IsRelease": IsRelease, "CreateTime": CreateTime, "Author": Author,
                                    },
                                    success: function (json) {
                                        addExam_ExamPaperObjQ(json.result.retData);
                                        addExam_ExamPaperSubQ(json.result.retData);
                                        alert('组卷成功');
                                        $("#ADDExamExamination").attr("class", "confirm_testassem ml10");
                                        $("#confirm_testassemdialog").attr("style", "display: block;");
                                    }
                                });
                            } else { alert('顺序不能为空'); }
                            
                        }
                        else { alert('请选择难度'); }

                    }
                    else { alert('请选择年级科目教材版本还有章节'); }

                }
                else { alert('请输入时间'); }

            } else { alert('请输入试卷名称'); }
        }
        else {
            alert('请选择年级科目教材版本还有章节');
        }
        
        
    }
    function addExam_ExamPaperSubQ(id)
    {
        var OrderID = "";
        $("input[name='OrderIDzhu']").each(function () {
            OrderID += $(this).val() + ",";
        });
        OrderID = OrderID.substr(0, OrderID.length - 1);
        OrderID = OrderID.split(",");
        for (var i = 0; i < subjective.length; i++) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "addExam_ExamPaperSubQ", "ExampaperID": id, "Type": subjective[i].Type, "Content": subjective[i].Content, "Answer": subjective[i].Answer, "OrderID": OrderID[i], "Analysis": subjective[i].Analysis, "Difficulty": subjective[i].Difficulty, "IsShowAnalysis": subjective[i].IsShowAnalysis, "Score": subjective[i].Score
                },
                success: function (json) {
                }
            });
        }
    }
    function addExam_ExamPaperObjQ(id)
    {
        var name = "";
        $("input[name='OrderID']").each(function(){
            name += $(this).val() + ",";
        });
        name = name.substr(0, name.length - 1);
        name = name.split(",");
        for (var i = 0; i < objective.length; i++) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "addExam_ExamPaperObjQ", "ExampaperID": id, "Type": objective[i].Type, "Content": objective[i].Title, "OptionA": objective[i].OptionA, "OptionB": objective[i].OptionB, "OptionC": objective[i].OptionC, "OptionD": objective[i].OptionD, "OptionE": objective[i].OptionE, "OptionF": objective[i].OptionF, "Difficulty": objective[i].Difficulty, "Answer": objective[i].Answer, "Score": objective[i].Score, "IsShowAnalysis": objective[i].IsShowAnalysis, "Analysis": objective[i].Analysis, "OrderID": name[i]
                },
                success: function (json) {
                }
            });
        }
    }
    function Chapator() {
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    div = "";
                    BindleftMenu(json.result.retData, 0);
                    $("#menuChapater").html("");
                    $("#menuChapater").append(div);
                    $("#chartp").find("#" + HChapterIDid + "").attr("class", "active");
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
                    div += "<div id=\"chartp\" class=\"units\">";
                    div += " <div class=\"item_title\"><span class=\"text\">" + this.Name + "</span><span class=\"icon icon-angle-down\"></span></div>";
                    BindleftMenu(data, this.Id);
                    if (i > 0) {
                        div += "</ul>";
                    }
                    i = 0;
                    div += "</div>";
                    TopMenuNum++;
                }
                if (this.PID != 0 && this.PID == id) {
                    if (TopMenuNum == 0 && i == 0) {
                        div += "<ul class=\"contentbox\" style=\"display: block;\"><li id=\"" + this.Id + "\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                        $("#HChapterID").val(this.Id);
                    }
                    if (TopMenuNum > 0 && i == 0) {
                        div += "<ul class=\"contentbox\">";
                    }
                    if (i > 0) {
                        div += "<li id=\"" + this.Id + "\" onclick=\"changeMenu(" + this.Id + ")\">\<span class=\"text\">" + this.Name + "</span> </li>";
                    }
                    i++;
                }
            }
        })
    }
    $(function () {
        if ($("#HChapterID").val() != "0" && $("#HChapterID").val() != undefined) {
        }
    });
    function changeMenu(id) {
        $("#HChapterID").val(id);
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
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
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
            $('#Period').find("#" + HPeriodid + "").attr("class", "on");
            //$("#Period").find("a[id=" + HPeriodid + "]").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Period.errMsg);
        }
    }
    var gradeid = 0;
    var booo = "";
    function PeriodChangeall(GradeID, em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }

    function PeriodChange(GradeID, em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }
    //科目
    function BindSubject() {
        $("#Subject").children().remove();
        var SelPeriod = $("#HPeriod").val();
        $("#HChapterID").attr("value", "");

        if (SelPeriod == "0") {
            option = "<a id='0' onclick='SubjectChangeall(this)'>全部</a>";
            $("#Subject").append(option);
            $("#HChapterID").attr("value", "");
            //版本
            TextbookVersion();
            $('#Subject').find("#" + HSubjectid + "").attr("class", "on");
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
                        $("#HSubject").val(HSubjectid);
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

            //$(this).parents('.dialog_detail').find('.checkbox').hide();
            //$("#Subject").find("a[id=" + HSubjectid + "]").attr("class", "on");
            if (HSubjectid > 0) {
                $("#textbookv").attr("style", "display: block;");
                $("#text").attr("style", "display: block;");
                $("#angle-down").attr("class", "icon fr icon-angle-up");
            }
        }
        else {
            layer.msg(CatagoryJson.PeriodOfSubject.errMsg);
        }
        $('#Subject').find("#" + HSubjectid + "").attr("class", "on");
    }
    var emid = 0;
    var bok = "";
    function SubjectChangeall(em) {
        $("#sput").html("收起");
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }

    function SubjectChange(em, GradeID) {
        $("#sput").html("收起");
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
            $("#TextbookVersion").find("#" + bookVersionid + "").attr("class", "on");
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

        }
        else {
            layer.msg(CatagoryJson.TextbookVersion.errMsg);
        }
        $("#TextbookVersion").find("#" + bookVersionid + "").attr("class", "on");
    }
    var vcid = 0;
    var bk = "";
    function VersionChangeall(em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }

    function VersionChange(em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
            $("#Textbook").find("#" + HTextbooxid + "").attr("class", "on");
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

            //$("#Textbook").find("a[id=" + HTextbooxid + "]").attr("class", "on");
        }
        else {
            layer.msg(CatagoryJson.Textbook.errMsg);
        }
        $("#Textbook").find("#" + HTextbooxid + "").attr("class", "on");
        if ($("#HTextboox").val() == "0") {
            Chapator();
        }
    }
    var tbid = 0;
    var btk = "";
    function TextbookChangeall(em) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }

    function TextbookChange(em, name) {
        HPeriodid = "0";
        HSubjectid = "0";
        HTextbooxid = "0";
        bookVersionid = "0";
        HChapterIDid = "0";
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
    }
    $("#textbook").html($("#Textbook").find("a[class=on]").val());
</script>
