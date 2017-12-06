<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuestionnaireSurvey .aspx.cs" Inherits="SMSWeb.Exam.QuestionnaireSurvey" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>问卷调查</title>
		<!--图标样式-->
<link href="../css/font-awesome.min.css" type="text/css" rel="stylesheet" />
    <link href="../css/reset.css" type="text/css" rel="stylesheet" />
    <link href="../css/common.css" type="text/css" rel="stylesheet" />
    <link href="../css/repository.css" type="text/css" rel="stylesheet" />
    <link href="../css/onlinetest.css" type="text/css" rel="stylesheet" />
    <script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="../js/menu_top.js" type="text/javascript"></script>
        <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
	</head>
	<body>
        <input type="hidden" id="hName" runat="server" value="<%=Name %>" />
		<!--header-->
		<header class="repository_header_wrap manage_header">
			<div class="width repository_header clearfix">
				<a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
				<div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
				<nav class="navbar menu_mid fl">
					<ul>
						<li currentClass="active"><a href="ExamQManager.aspx">题库管理</a></li>
						<li currentClass="active"><a href="ExamManager.aspx">试卷管理</a></li>
						<li currentClass="active" class="active"><a href="MyExam.aspx">我的试卷</a></li>
						<li currentClass="active"><a href="charts.aspx">分析统计</a></li>
					</ul>
				</nav>
				<div class="search_account fr clearfix">
					<ul class="account_area fl">
						<li>
							<a href="" class="dropdown-toggle">
								<i class="icon icon-envelope"></i>
								<span class="badge">3</span>
							</a>
						</li>
						<li>
							<a href="" class="login_area clearfix">
								<div class="avatar">
                                    <img src="<%=PhotoURL %>" />
								</div>
								<h2 id="hhname">
									<%=Name %>
								</h2>
							</a>
						</li>
					</ul>
					<div class="settings fl">
						<a href="#">
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
			<!--在线作答-->
			<div class="myexam bordshadrad">
				<!--面包屑-->
				<div class="crumbs">
					<a href="MyExam.aspx">未达试卷</a>
					<span>></span>
                    <span id="text"><%--<a href="onlineanswer.aspx">2016年高职模拟考数学试卷</a>--%></span>
				</div>
				<div class="answer_paper clearfix mt10">
					<div class="fl answer_paper_left mt20">
                        <span id="paperdiv"></span>
                    <span id="paperdiv1"></span>
                    <span id="paperdiv2"></span>
					</div>
					<div class="fr mt20 answer_paper_right">
					</div>
				</div>
			</div>
			<div class="testbask_backtop">
				<div class="backTop">
					<span class="icon  icon-angle-up"></span>
				</div>
			</div>
		</div>
        <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
		<%--<script>
		    $(function (id) {
		        $.ajax({
		            url: HanderServiceUrl + "ExamHandler.ashx",//random" + Math.random(),//方法所在页面和方法名
		            type: "post",
		            async: false,
		            dataType: "json",
		            data: {
		                "action": "GetExamNPBageList",
                        "id":id
		                //PageIndex: startIndex,
		                //pageSize: pageSize,
		                //"Status": Status,
		                //"Type": TypeId,
		                //"Title": Title
		            },
		            success: OnSuccess,
		            //error: OnError
		        });
		        function OnSuccess(json) {
		            var html = "";
		            $.each(json.result.retData.PagedData, function () {

		                html += "<li class=\"clearfix\">"
                                    + "<div class=\"exam_img fl\">"
                                        + "<img src=\"../images/exam_img.png\" />"
                                    + "</div>"
                                    + "<div class=\"test_description exam_description fl\" style=\"width:200px\">";
		                if (this.WorkBeginTime < myDate.toLocaleString() && myDate.toLocaleString() < this.WorkEndTime) {
		                    html += "<h2 style=\"width:200px\"><a href='onlineanswer.html?id=" + this.ID + "'>" + this.Title + "</a></h2>";
		                } else {
		                    html += "<h2 style=\"width:200px\"><a href='javacript:void(0);' style=\"color:gray;\" onclick=\"return confirm('不再规定时间内')\">" + this.Title + "</a></h2>";
		                }
		                html += "<p style=\"width:400px\"><span class=\"test_easy\">" + this.Difficultyshow + "</span><span class=\"test_easy\">" + this.typeid + "</span><span class=\"test_easy\">" + this.Statushow + "</span></p>"
		                html += "</div>"
                                    + "<div class=\"test_lists_right fr clearfix\" style=\"width:300px\">"
                                        + "<div class=\"public_name fl\">"
                                            + "发布人：" + this.Author
                                        + "</div>"
                                        + "<div class=\"dates_a dates_b fr pr\" style=\"width:200px\">"
                                            + "<div class=\"data\" style=\"width:200px\">"
                                                + "发布时间：" + this.CreateTime
                                            + "</div></div></div></li>";
		            });
		        }
		        //预览试卷 手风琴
		        $('.paper_numer h1').find('.icon').click(function () {
		            var $next = $(this).parents('h1').next();
		            var $this = $(this);
		            $this.toggleClass('active');
		            $next.stop().slideToggle();
		            $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
		            $('.paper_numer h1').find('.icon').not($this).removeClass('active');
		        });
		        //返回顶部
		        backTop($('.backTop'), 400);
		        //试题回答情况
		        $('.answer_number li').click(function () {
		            $(this).addClass('on');
		        });
		        //开始答题
		        var h = $('.remaintime p').find('span:eq(0)').text();
		        var m = $('.remaintime p').find('span:eq(1)').text();
		        var s = $('.remaintime p').find('span:eq(2)').text();
		        var timer;
		        $('.stopstart').click(function () {
		            var $icon = $(this).find('.icon');
		            var $text = $(this).find('p');
		            if ($text.text() == '开始') {
		                $icon.removeClass('icon-play').addClass('icon-pause');
		                $text.text('暂停');
		                timer = setInterval(run, 1000);
		            } else {
		                $icon.removeClass('icon-pause').addClass('icon-play');
		                $text.text('开始');
		                clearInterval(timer);
		            }
		        });
		        function run() {
		            --s;
		            if (s < 0) {
		                --m;
		                s = 59;
		            }
		            if (m < 0) {
		                --h;
		                m = 59
		            }
		            if (h < 0) {
		                s = 0;
		                m = 0;
		            }
		            $('.remaintime p').find('span:eq(0)').text(h);
		            $('.remaintime p').find('span:eq(1)').text(m);
		            $('.remaintime p').find('span:eq(2)').text(s);
		        }
		    })
		</script>--%>
	</body>
</html>
<script type="text/javascript">
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }
    $(function () {
        getExamPaper();
    });
    var id = window.location.search;
    id = id.substr(4);
    var TCount = 0;
    var QCount = 0;
    var html = "";
    var fhr = "";
    var htmll = "";
    var exid = "";
    function getExamPaper() {
        var hname = $("#hName").val();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetExamPaper", "ID": id
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    //GetPaperQ(id, "1");
                    //GetPaperQ(id, "2");
                    $.each(json.result.retData, function () {
                        exid = this.exid;
                        chaxuntileike(id);
                        chaxuntileizhu(id);
                        var html = "<div class=\"paper_title\">"
                              + "<h2>" + this.Title + "</h2>"
                              + "<p>(满分" + this.FullScore + "分 评价有效期" + this.WorkBeginTime + "~" + this.WorkEndTime + " 参与者： 当前用户:" + hname + ")</p>"
                        "</div>";
                        $("#paperdiv").html(html);
                    });


                } else {
                    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                    $("#paperdiv").html(html);
                }
            },
            error: function (errMsg) {
                $("#paperdiv").html(json.result.errMsg.toString());
            }
        });

    }
    var onclick = "";
    function chaxuntileike(idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            //async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileikeyulan", "ID": idd
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        TCount++;
                        onclick += "<p class=\"answer_type\">单项选择题 </p>"
							+ "<ul class=\"answer_number clearfix\">";
                        fhr += "<div class=\"paper_mes\">"
                            + "<div class=\"paper_numer\">"
                                + "<h1 class=\"clearfix\">"
                                    + "<div class=\"paper_number_name fl\"><span>"
                                    + this.Title + "</span>（本大题共" + this.sum + "小题，共" + this.score + "分）"
                                    + "</div>"
                                    + "<div class=\"paper_more fr\">"
                                        + "<i class=\"icon icon-angle-up active\"></i>"
                                    + "</div>"
                                + "</h1>"
                                + "<div class=\"paper_number_mes\" style=\"display: block;\">";
                        chaxunzhutimuke(this.Title, idd);
                        fhr += "</div>";
                        fhr += "</div>";
                        fhr += "</div>";
                        onclick += "</ul>";
                        $("#yihuida").html(onclick);
                        $("#paperdiv1").html(fhr);
                    });

                } else { $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString()); }
            },
            error: function (errMsg) {
                $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
            }
        });

    }
    function chaxuntileizhu(idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            //async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileizhuyulan", "ID": idd
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        TCount++;
                        //$('#TCount').val() = TCount;
                        htmll += "<div class=\"paper_mes\">"
                            + "<div class=\"paper_numer\">"
                                + "<h1 class=\"clearfix\">"
                                    + "<div class=\"paper_number_name fl\"><span>"
                                    + this.Title + "</span>（本大题共" + this.sum + "小题，共" + this.score + "分）"
                                    + "</div>"
                                    + "<div class=\"paper_more fr\">"
                                        + "<i class=\"icon icon-angle-up active\"></i>"
                                    + "</div>"
                                + "</h1>"
                                + "<div class=\"paper_number_mes\" style=\"display: block;\">";
                        chaxunzhutimuzhu(this.Title, idd);
                        htmll += "</div>";
                        htmll += "</div>";
                        htmll += "</div>";
                        $("#paperdiv2").html(htmll);
                    });

                } else { $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString()); }
            },
            error: function (errMsg) {
                $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
            }
        });

    }
    var objectiveanswer = "";
    function chaxunzhutimuke(Title, idd) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuyulanke", "ID": idd, "Title": Title
            },
            success: function (json) {
                objectiveanswer = json.result.retData;
                $.each(json.result.retData, function () {
                    QCount++;
                    onclick += "<li id=\"" + this.ID + "\">1</li>";
                    fhr += "<div style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    fhr += "<h1>";
                    fhr += "	<em>" + this.Content + "</em>";
                    fhr += "	<span>(" + this.Score + "分)</span>";
                    fhr += "	</h1>";
                    if (this.QType == 2) {
                        if (this.Template == 1) {
                            fhr += "<div class=\"radio\">";
                            if (this.OptionA != "") { fhr += "<p><input class=\"answer\" id=\"OptionA\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"A\" />A：" + this.OptionA + "</p>"; }
                            if (this.OptionB != "") { fhr += "<p><input class=\"answer\" id=\"OptionB\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"B\" />B：" + this.OptionB + "</p>"; }
                            if (this.OptionC != "") { fhr += "<p><input class=\"answer\" id=\"OptionC\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"C\" />C：" + this.OptionC + "</p>"; }
                            if (this.OptionD != "") { fhr += "<p><input class=\"answer\" id=\"OptionD\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"D\" />D：" + this.OptionD + "</p>"; }
                            if (this.OptionE != "") { fhr += "<p><input class=\"answer\" id=\"OptionE\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"E\" />E：" + this.OptionE + "</p>"; }
                            if (this.OptionF != "") { fhr += "<p><input class=\"answer\" id=\"OptionF\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"F\" />F：" + this.OptionF + "</p>"; }
                            fhr += "</div>";
                        } else if (this.Template == 3) {
                            fhr += "<div class=\"checkbox\">";
                            if (this.OptionA != "") { fhr += "<p><input id=\"rdoOpA\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：" + this.OptionA + "</p>"; }
                            if (this.OptionB != "") { fhr += "<p><input id=\"rdoOpB\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：" + this.OptionB + "</p>"; }
                            if (this.OptionC != "") { fhr += "<p><input id=\"rdoOpC\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：" + this.OptionC + "</p>"; }
                            if (this.OptionD != "") { fhr += "<p><input id=\"rdoOpD\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：" + this.OptionD + "</p>"; }
                            if (this.OptionE != "") { fhr += "<p><input id=\"rdoOpE\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：" + this.OptionE + "</p>"; }
                            if (this.OptionF != "") { fhr += "<p><input id=\"rdoOpF\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：" + this.OptionF + "</p>"; }
                            fhr += "</div>";
                        } else if (this.Template == 2) {
                            fhr += "<div class=\"judge\">";
                            if (this.OptionA != "") { fhr += "<p><input id=\"ckOptionA\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：" + this.OptionA + "</p>"; }
                            if (this.OptionB != "") { fhr += "<p><input id=\"ckOptionB\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：" + this.OptionB + "</p>"; }
                            if (this.OptionC != "") { fhr += "<p><input id=\"ckOptionC\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：" + this.OptionC + "</p>"; }
                            if (this.OptionD != "") { fhr += "<p><input id=\"ckOptionD\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：" + this.OptionD + "</p>"; }
                            if (this.OptionE != "") { fhr += "<p><input id=\"ckOptionE\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：" + this.OptionE + "</p>"; }
                            if (this.OptionF != "") { fhr += "<p><input id=\"ckOptionF\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：" + this.OptionF + "</p>"; }
                            fhr += "</div>";
                        }

                    }
                    //fhr += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    //fhr += " <span >解析：" + this.Analysis + "</span></p>";
                    fhr += "</div>";


                });


            }
        })
    }
    var contrastanswer = "";
    function obtains(id) {
        if ($(".radio input[class='" + id + "']").is(':checked')) {
            $("#" + id + "").attr("class", "on");
        }
    }
    function obtain() {
        var Answer = "";
        var wAnswer = "";
        var question = "";
        var objective = "";
        var score = "";
        var value = "";
        var zhuvalue = "";
        var zhuscore = "";
        if ($(".radio").css("display") == "block") {
            $(".radio input[class='answer']:checked").each(function () {
                Answer += $(this).val() + ",";
            });
        } else if ($(".checkbox").css("display") == "block") {
            //拼接答案
            $(objectiveanswer).each(function () {
                if (this.Template == 2) {
                    $("input[name$='" + this.ID + "']:checked").each(function () {
                        Answer += $(this).val() + "&";
                    });
                    Answer = Answer.substr(0, Answer.length - 1);
                    Answer += ",";
                }
            });
        } else if ($(".judge").css("display") == "block")//判断
        {
            $("input[name='panswer']:checked").each(function () {
                Answer += $(this).val() + ",";
            });
        }
        Answer = Answer.substr(0, Answer.length - 1);
        Answer = Answer.split(",");
        $(objectiveanswer).each(function () {
            objective += this.Answer + ",";
            score += this.Score + ",";
        })
        objective = objective.substr(0, objective.length - 1);
        objective = objective.split(",");
        score = score.substr(0, score.length - 1);
        score = score.split(",");
        for (var i = 0; i < Answer.length; i++) {
            if (objective[i] == Answer[i]) {
                value += score[i] + ",";
            }
            else if (objective[i] != Answer[i]) {
                value += "0" + ",";
            }
        }
        value = value.substr(0, value.length - 1);
        value = value.split(",");
        for (var i = 0; i < objectiveanswer.length; i++) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "addExam_ExamAnswer", "ExamID": exid, "QuestionID": objectiveanswer[i].ID, "ExampaperID": id, "Type": 2, "Answer": Answer[i], "Score": value[i]
                },
                success: function (json) { }
            });
        }
        $(contrastanswer).each(function () {
            question += this.Answer + ",";
            zhuscore += this.Score + ",";
        })
        question = question.substr(0, question.length - 1);
        question = question.split(",");
        zhuscore = zhuscore.substr(0, zhuscore.length - 1);
        zhuscore = zhuscore.split(",");
        $(".txt").each(function () {
            wAnswer += $(this).val() + ",";
        });
        wAnswer = wAnswer.substr(0, wAnswer.length - 1);
        wAnswer = wAnswer.split(",");
        for (var i = 0; i < wAnswer.length; i++) {
            if (question[i] == wAnswer[i]) {
                zhuvalue += zhuscore[i] + ",";
            } else if (question[i] != wAnswer[i]) {
                zhuvalue += "0" + ",";
            }
        }
        zhuvalue = zhuvalue.substr(0, zhuvalue.length - 1);
        zhuvalue = zhuvalue.split(",");
        for (var i = 0; i < contrastanswer.length; i++) {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "addExam_ExamAnswer", "ExamID": exid, "QuestionID": contrastanswer[i].ID, "ExampaperID": id, "Type": 2, "Answer": wAnswer[i], "Score": zhuvalue[i]
                },
                success: function (json) { }
            });
        }
        window.location.href = "ExamPaperDetail.aspx?id=" + id + "";
    }
    function chaxunzhutimuzhu(Title, idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuyulanzhu", "ID": idd, "Title": Title
            },
            success: function (json) {
                contrastanswer = json.result.retData;
                $.each(json.result.retData, function () {
                    QCount++;
                    htmll += "<div  style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    htmll += "<h1>";
                    htmll += "	<em>" + this.Content + "</em>";
                    htmll += "	<span>(" + this.Score + "分)</span>";
                    htmll += "	</h1>";
                    htmll += "<p><input id=\"ckOptionE\" type=\"text\" name=\"OptionE\" class=\"txt\" /></input></p>";
                    //htmll += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    //htmll += " <span >解析：" + this.Analysis + "</span></p>";
                    htmll += "</div>";


                });


            }
        })
    }
</script>
