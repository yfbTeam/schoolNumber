﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="onlineanswer.aspx.cs" Inherits="SMSWeb.Exam.onlineanswer" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title>我的试卷</title>
		<!--图标样式-->
<link href="../css/font-awesome.min.css" type="text/css" rel="stylesheet" />
    <link href="../css/reset.css" type="text/css" rel="stylesheet" />
    <link href="../css/common.css" type="text/css" rel="stylesheet" />
    <link href="../css/repository.css" type="text/css" rel="stylesheet" />
    <link href="../css/onlinetest.css" type="text/css" rel="stylesheet" />
        <script src="../js/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="../Scripts/Uploadyfy/uploadify/jquery.uploadify-3.1.js"></script>
        <link href="../Scripts/Uploadyfy/uploadify/uploadify.css" rel="stylesheet" />
    <script src="../js/menu_top.js" type="text/javascript"></script>
        <!--<script src="../Scripts/jquery-1.11.2.min.js"></script>-->
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
	</head>
	<body>
        <form id="form1" runat="server">
        <input type="hidden" id="hName" runat="server" />
        <input type="hidden" id="hIDCard" runat="server" />
        <input type="hidden" id="hnamee" runat="server" />
        <input type="hidden" id="hid" runat="server" />
		<!--header-->
		<header class="repository_header_wrap manage_header">
			<div class="width repository_header clearfix">
				<a class="logo fl" href="../HZ_Index.aspx">
                <img src="../images/logo.png" /></a>
				<div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
				<nav class="navbar menu_mid fl">
					<ul>
						<%--<li currentClass="active"><a href="ExamQManager.aspx">题库管理</a></li>
						<li currentClass="active"><a href="ExamManager.aspx">试卷管理</a></li>
						<li currentClass="active"><a href="MyExam.aspx">我的试卷</a></li>
						<li currentClass="active"><a href="charts.aspx">分析统计</a></li>--%>
					</ul>
				</nav>
				<div class="search_account fr clearfix">
					<ul class="account_area fl">
						<li>
							<a href="javascript:void(0);" class="dropdown-toggle">
								<i class="icon icon-envelope"></i>
								<span class="badge">3</span>
							</a>
						</li>
						<li>
							<a href="javascript:void(0);" class="login_area clearfix">
								<div class="avatar">
                                    <img src="<%=PhotoURL %>" />
								</div>
								<h2>
									<%=Name %>
								</h2>
							</a>
						</li>
					</ul>
					<div class="settings fl">
						<a href="javascript:void(0);">
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
				</div>
				<div class="answer_paper clearfix mt10">
					<div class="fl answer_paper_left mt20">
                        <span id="paperdiv"></span>
                    <span id="paperdiv1"></span>
                    <span id="paperdiv2"></span>
					</div>
                    <div class="fr mt20 answer_paper_right">
						<div class="answer_remaintime clearfix">
							<div class="remaintime fl">
								剩余时间
								<p><span>1</span>小时<span>50</span>分钟<span>30</span>秒</p>
							</div>
							<div class="stopstart fr">
								<i class="icon  icon-play"></i>
								<p>开始</p>
							</div>
						</div>
						<div class="answer_detail" id="yihuida">
						</div>
						<a href="javascript:;" class="mt10 Confirmassignment" onclick="obtain()">确认交卷</a>
						<a href="javascript:;" class="mt10 Nextcontinute">保存，下次继续</a>
					</div>


					<%--<div class="fr mt20 answer_paper_right">
						<a href="javascript:void(0);" class="mt10 Confirmassignment" onclick="obtain()">确认交卷</a>
						<a href="javascript:void(0);" class="mt10 Nextcontinute">保存，下次继续</a>
					</div>--%>
				</div>
			</div>
			<div class="testbask_backtop">
				<div class="backTop">
					<span class="icon  icon-angle-up"></span>
				</div>
			</div>
		</div>
<%--        <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
		<script>
		    $(function (id) {
		        //预览试卷 手风琴
		        
		    })
		</script>--%>
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
    var contrastanswer = "[";
    var objectiveanswer = "[";
    var id = "";
    id = $("#hid").val();
    //var hnamee=$("#hnamee").val();
    var hIDCard=$("#hIDCard").val();
    var examname = "";
    $(function () {
        //getEmailInfo();
        getExamPaper();
        //$('.paper_numer h1').find('.icon').click(function () {
        //    var $next = $(this).parents('h1').next();
        //    var $this = $(this);
        //    $this.toggleClass('active');
        //    $next.stop().slideToggle();
        //    $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
        //    $('.paper_numer h1').find('.icon').not($this).removeClass('active');
        //});
        //返回顶部
        //backTop($('.backTop'), 400);
        //试题回答情况
        //$('.answer_number li').click(function () {
        //    $(this).addClass('on');
        //});
        ////开始答题
        //var h = $('.remaintime p').find('span:eq(0)').text();
        //var m = $('.remaintime p').find('span:eq(1)').text();
        //var s = $('.remaintime p').find('span:eq(2)').text();
        //var timer;
        //$('.stopstart').click(function () {
        //    var $icon = $(this).find('.icon');
        //    var $text = $(this).find('p');
        //    if ($text.text() == '开始') {
        //        $icon.removeClass('icon-play').addClass('icon-pause');
        //        $text.text('暂停');
        //        timer = setInterval(run, 1000);
        //    } else {
        //        $icon.removeClass('icon-pause').addClass('icon-play');
        //        $text.text('开始');
        //        clearInterval(timer);
        //    }
        //});
        //function run() {
        //    --s;
        //    if (s < 0) {
        //        --m;
        //        s = 59;
        //    }
        //    if (m < 0) {
        //        --h;
        //        m = 59
        //    }
        //    if (h < 0) {
        //        s = 0;
        //        m = 0;
        //    }
        //    $('.remaintime p').find('span:eq(0)').text(h);
        //    $('.remaintime p').find('span:eq(1)').text(m);
        //    $('.remaintime p').find('span:eq(2)').text(s);
        //}
    });
    function UploadFile(idd) {
        $("#uploadify" + idd + "").uploadify({
            'auto': true,                      //是否自动上传
            'swf': '../Scripts/Uploadyfy/uploadify/uploadify.swf',
            'uploader': '../CourseManage/Uploade.ashx',
            'formData': { Func: "UplodeCourse_Work" }, //参数
            //'fileTypeDesc': '',
            //'fileTypeExts': '*.jpg;*.jpeg;*.png',   //文件类型限制,默认不受限制
            'buttonText': '选择作业',//按钮文字
            // 'cancelimg': 'uploadify/uploadify-cancel.png',
            'width': 90,
            'height': 30,
            //最大文件数量'uploadLimit':
            'multi': false,//单选            
            'fileSizeLimit': '1024MB',//最大文档限制
            'queueSizeLimit': 1,  //队列限制
            'removeCompleted': true, //上传完成自动清空
            'removeTimeout': 0, //清空时间间隔
            //'overrideEvents': ['onDialogClose', 'onUploadSuccess', 'onUploadError', 'onSelectError'],
            'onUploadSuccess': function (file, data, response) {
                var json = $.parseJSON(data);
                $("#" + idd + "").attr("value", json.result.retData);
                myFunction(idd);
            }
        });
    }

    var TCount = 0;
    var QCount = 0;
    var html = "";
    var fhr = "";
    var htmll = "";
    var exid = "";
    function getExamPaper() {
        var namee = $("#hName").val();
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
                              + "<p>(满分" + this.FullScore + "分 考试时间" + this.ExamTime + "分钟)</p>"
                        "</div>";
                        $("#paperdiv").html(html);
                        examname = this.Title;
                    });


                } //else {
                //    var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
                //    $("#paperdiv").html(html);
                //}
            },
            error: function (errMsg) {
                $("#paperdiv").html(json.result.errMsg.toString());
            }
        });

    }
    var onclickd="";
    function chaxuntileike(idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            //async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileikeyulan", "ExampaperID": idd
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        TCount++;
                        onclickd += "<p class=\"answer_type\">" + this.Title + " (共有：" + this.sum + ")</p>"
							+ "<ul class=\"answer_number clearfix\" id=\"dongt\">";
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
                        onclickd += "</ul>";
                        //$("#yihuida").html(onclickd);
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
                "action": "chaxuntileizhuyulan", "ExampaperID": idd
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        TCount++;
                        onclickd += "<p class=\"answer_type\">" + this.Title + " (共有：" + this.sum + ")</p>"
							+ "<ul class=\"answer_number clearfix\" id=\"dongt\">";
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
                        onclickd += "</ul>";
                        $("#yihuida").html(onclickd);
                        $("#paperdiv2").html(htmll);
                    });
                    for (var i = 0; i < thisid.length; i++) {
                        UploadFile(thisid[i]);
                    }
                } else { $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString()); }
            },
            error: function (errMsg) {
                $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
            }
        });

    }
    
    
    function chaxunzhutimuke(Title, idd) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuyulanke", "ExampaperID": idd, "Title": Title
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    objectiveanswer += '{"ID":"' + this.ID + '","Type":"' + this.Type + '","Answer":"' + this.Answer + '","Template":"' + this.Template + '","Score":"' + this.Score + '"},';
                    QCount++;
                    onclickd += "<li id=\"" + this.ID + "\">" + QCount + "</li>";
                    fhr += "<div style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    fhr += "<h1>";
                    fhr += "" + QCount + "：	" + this.Content + "<i class=\"star\"></i>";
                    fhr += "	<span>(" + this.Score + "分)</span>";
                    fhr += "	</h1>";
                    if (this.QType == 2) {
                        if (this.Template == 1) {
                            fhr += "<div class=\"radio\">";
                            if (this.OptionA != "") {
                                var OptionA = "";
                                OptionA = "" + this.OptionA + "";
                                OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                                if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionA\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"A\" />A：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionA\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"A\" />A：" + this.OptionA + "</p>"; }

                            }
                            if (this.OptionB != "") {
                                var OptionB = "";
                                OptionB = "" + this.OptionB + "";
                                OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                                if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionB\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"B\" />B：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionB\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"B\" />B：" + this.OptionB + "</p>"; }

                            }
                            if (this.OptionC != "") {
                                var OptionC = "";
                                OptionC = "" + this.OptionC + "";
                                OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                                if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionC\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"C\" />C：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionC\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"C\" />C：" + this.OptionC + "</p>"; }

                            }
                            if (this.OptionD != "") {
                                var OptionD = "";
                                OptionD = "" + this.OptionD + "";
                                OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                                if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionD\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"D\" />D：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionD\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"D\" />D：" + this.OptionD + "</p>"; }

                            }
                            if (this.OptionE != "") {
                                var OptionE = "";
                                OptionE = "" + this.OptionE + "";
                                OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                                if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionE\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"E\" />E：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionE\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"E\" />E：" + this.OptionE + "</p>"; }

                            }
                            if (this.OptionF != "") {
                                var OptionF = "";
                                OptionF = "" + this.OptionF + "";
                                OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                                if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                                    fhr += "<p><input class=\"answer\" id=\"OptionF\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"F\" />F：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input class=\"answer\" id=\"OptionF\" name=\"" + this.ID + "\" onclick=\"obtains(" + this.ID + ")\" type=\"radio\" value=\"F\" />F：" + this.OptionF + "</p>"; }

                            }
                            fhr += "</div>";
                        } else if (this.Template == 3) {
                            fhr += "<div class=\"checkbox\">";
                            if (this.OptionA != "") {
                                var OptionA = "";
                                OptionA = "" + this.OptionA + "";
                                OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                                if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpA\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpA\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：" + this.OptionA + "</p>"; }

                            }
                            if (this.OptionB != "") {
                                var OptionB = "";
                                OptionB = "" + this.OptionB + "";
                                OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                                if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpB\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpB\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：" + this.OptionB + "</p>"; }

                            }
                            if (this.OptionC != "") {
                                var OptionC = "";
                                OptionC = "" + this.OptionC + "";
                                OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                                if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpC\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpC\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：" + this.OptionC + "</p>"; }

                            }
                            if (this.OptionD != "") {
                                var OptionD = "";
                                OptionD = "" + this.OptionD + "";
                                OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                                if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpD\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpD\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：" + this.OptionD + "</p>"; }

                            }
                            if (this.OptionE != "") {
                                var OptionE = "";
                                OptionE = "" + this.OptionE + "";
                                OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                                if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpE\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpE\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：" + this.OptionE + "</p>"; }

                            }
                            if (this.OptionF != "") {
                                var OptionF = "";
                                OptionF = "" + this.OptionF + "";
                                OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                                if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                                    fhr += "<p><input id=\"rdoOpF\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"rdoOpF\" class=\"panswer\" name=\"" + this.ID + "\" type=\"radio\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：" + this.OptionF + "</p>"; }

                            }
                            fhr += "</div>";
                        } else if (this.Template == 2) {
                            fhr += "<div class=\"judge\">";
                            if (this.OptionA != "") {
                                var OptionA = "";
                                OptionA = "" + this.OptionA + "";
                                OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                                if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionA\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionA + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionA\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"A\" />A：" + this.OptionA + "</p>"; }

                            }
                            if (this.OptionB != "") {
                                var OptionB = "";
                                OptionB = "" + this.OptionB + "";
                                OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                                if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionB\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionB + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionB\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"B\" />B：" + this.OptionB + "</p>"; }

                            }
                            if (this.OptionC != "") {
                                var OptionC = "";
                                OptionC = "" + this.OptionC + "";
                                OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                                if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionC\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionC + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionC\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"C\" />C：" + this.OptionC + "</p>"; }

                            }
                            if (this.OptionD != "") {
                                var OptionD = "";
                                OptionD = "" + this.OptionD + "";
                                OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                                if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionD\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionD\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"D\" />D：" + this.OptionD + "</p>"; }

                            }
                            if (this.OptionE != "") {
                                var OptionE = "";
                                OptionE = "" + this.OptionE + "";
                                OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                                if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionE\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionE\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"E\" />E：" + this.OptionE + "</p>"; }

                            }
                            if (this.OptionF != "") {
                                var OptionF = "";
                                OptionF = "" + this.OptionF + "";
                                OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                                if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                                    fhr += "<p><input id=\"ckOptionF\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" /></p>";
                                } else { fhr += "<p><input id=\"ckOptionF\" name=\"" + this.ID + "\" type=\"checkbox\" onclick=\"obtains(" + this.ID + ")\" value=\"F\" />F：" + this.OptionF + "</p>"; }

                            }
                            fhr += "</div>";
                        }

                    }
                    //fhr += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    //fhr += " <span >解析：" + this.Analysis + "</span></p>";
                    fhr += "</div>";


                });


            }
        });
    }
    
    function obtains(id)
    {
        if ($("input[name='" + id + "']").is(':checked')) {
            $("#" + id + "").attr("class", "on");
        } else { $("#" + id + "").attr("class", ""); }
    }

    function obtain()
    {
        objectiveanswer = objectiveanswer.substr(0, objectiveanswer.length - 1);
        objectiveanswer += "]";
        objectiveanswer = eval(objectiveanswer);
        contrastanswer = contrastanswer.substr(0, contrastanswer.length - 1);
        contrastanswer += "]";
        contrastanswer = eval(contrastanswer);
        var zdrname = $("#hName").val();
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
        }
        if ($(".checkbox").css("display") == "block") {
            //拼接答案
            for (var i = 0; i < objectiveanswer.length; i++) {
                if (objectiveanswer[i].Template == "2") {
                    $("input[name$='" + objectiveanswer[i].ID + "']:checked").each(function () {
                        Answer += $(this).val() + "&";
                    });
                    Answer = Answer.substr(0, Answer.length - 1);
                    Answer += ",";
                }
            }
        }
        if ($(".judge").css("display") == "block")//判断
        {
            $("input[class='panswer']:checked").each(function () {
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
                    "action": "addExam_ExamAnswer", "ExamID": exid, "QuestionID": objectiveanswer[i].ID, "ExampaperID": id, "Type": objectiveanswer[i].Type, "Answer": Answer[i], "Score": value[i]
                },
                success: function (json) {
                    
                }
            });
        }
        $(contrastanswer).each(function () {
            question += this.Answer + ",";
            zhuscore += this.Score + ",";
        });
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
                data: { PageName: "/Exam/ExamHandler.ashx", "action": "addExam_ExamAnswer", "ExamID": exid, "QuestionID": contrastanswer[i].ID, "ExampaperID": id, "Type": contrastanswer[i].Type, "Answer": wAnswer[i], "Score": 0 },
                success: function (json) {  }
            });
        }
        //addSysNotice(zdrname + examname, zdrname + "待阅试卷", 1, hIDCard, hnamee, "", "");
        window.location.href = "AnsweredExam.aspx?id=" + id + "&name=" + hIDCard;
    }
    var thisid = "";
    function chaxunzhutimuzhu(Title, idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxunzhutimuyulanzhu", "ExampaperID": idd, "Title": Title
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    contrastanswer += '{"ID":"' + this.ID + '","Type":"' + this.Type + '","Answer":"' + this.Answer + '","Template":"' + this.Template + '","Score":"' + this.Score + '"},';
                    thisid += this.ID + ",";
                    QCount++;
                    onclickd += "<li id=\"" + this.ID + "\">" + QCount + "</li>";
                    htmll += "<div  style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    htmll += "<p>";
                    htmll += "" + QCount + "：题文：" + this.Content + "";
                    htmll += "	<span>(" + this.Score + "分)</span>";
                    htmll += "	</p>";
                    htmll += "<p><input id=\"" + this.ID + "\" type=\"text\" name=\"OptionE\" class=\"txt\" onblur=\"myFunction(" + this.ID + ");\"  /><input type=\"file\" id=\"uploadify" + this.ID + "\" name=\"uploadify\" /><i class=\"star\"></i></p>";
                    //html += "<input type=\"text\" placeholder=\"\" class=\"text\" id=\"txt_File\" readonly=\"true\"/>";
                    //html += "<input type=\"file\" id=\"uploadify" + this.ID + "\" name=\"uploadify\" />";
                    //htmll += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    //htmll += " <span >解析：" + this.Analysis + "</span></p>";
                    htmll += "</div>";
                });
                thisid = thisid.substr(0,thisid.length-1);
                thisid = thisid.split(",");
            }
        })
    }
    function myFunction(id)
    {
        var str = $("input[id='" + id + "']").val();
        if (str != "") {
            $("li[id='" + id + "']").attr("class", "on");
        } else if (str == "") { $("li[id='" + id + "']").attr("class", ""); }
    }
</script>


