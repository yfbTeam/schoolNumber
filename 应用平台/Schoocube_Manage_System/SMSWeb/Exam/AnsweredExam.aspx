<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AnsweredExam.aspx.cs" Inherits="SMSWeb.Exam.AnsweredExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>我的试卷</title>
    <!--图标样式-->
    <link href="/css/font-awesome.min.css" type="text/css" rel="stylesheet" />
    <link href="/css/reset.css" type="text/css" rel="stylesheet" />
    <link href="/css/common.css" type="text/css" rel="stylesheet" />
    <link href="/css/repository.css" type="text/css" rel="stylesheet" />
    <link href="/css/onlinetest.css" type="text/css" rel="stylesheet" />
    <script src="/js/jquery-1.8.3.min.js" type="text/javascript"></script>
    <script src="/js/menu_top.js" type="text/javascript"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
<body style="background: #fff;">

    <form id="form1" runat="server">
        <asp:HiddenField ID="QID" runat="server" />
        <asp:HiddenField ID="name" runat="server" />
        <input type="hidden" id="hSF" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="/HZ_Index.aspx">
                    <img src="/images/logo.png" /></a>
                <%--<div class="wenzi_tips fl">
                    <img src="/images/testsystem.png" />
                </div>--%>
                <nav class="navbar menu_mid fl">
                    <ul>
                        <li><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <li class="active"><a href="/OnlineLearning/MyExam.aspx">在线考试</a></li>
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
        <div class="onlinetest_item width pt90">
            <div class="myexam bordshadrad">
                <div>
                    <div class="previewpaper_mes">
                        <span id="paperdiv"></span>
                        <span id="paperdiv1"></span>
                        <span id="paperdiv2"></span>
                        <span id="paperdiv3"></span>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>

    <script>
        //$(function () {
        //    //menu显示隐藏
        //    $('.grade').find('.item').click(function () {
        //        clickTab($('.grade'), '.icon_right');
        //    });
        //    //预览试卷 手风琴
        //    $('.paper_numer h1').find('.icon').click(function () {
        //        var $next = $(this).parents('h1').next();
        //        var $this = $(this);
        //        $this.toggleClass('active');
        //        $next.stop().slideToggle();
        //        $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
        //        $('.paper_numer h1').find('.icon').not($this).removeClass('active');
        //    });
        //    //选择专业班
        //    $('.class_nav li').click(function () {
        //        $(this).addClass('active').siblings().removeClass('active');
        //        var n = $(this).index();
        //        $('.class_select .select_class').eq(n).show().siblings().hide();
        //    })
        //    //
        //    onscroll($('.testsystem_wrap>.menu'));
        //})
        //$(document).ready(function () {
        //    var str = $('#hSF').val();
        //    if (str == "学生") {
        //        $('#teacher').hide();
        //        $('#student').show();
        //    } else {
        //        $('#teacher').show();
        //        $('#student').hide();
        //    }
        //    quanxian();

        //})
    </script>

</body>
</html>
<script type="text/javascript">
    var str = $('#hSF').val();
    var yue = "";
    $(function () {
        getExamPaper();
        if (str == "教师" && status == 1) {
            yue += "<p style=\"text-align:center;\"><input type='button' class=\"btn\"  value=\"阅卷\" onclick=\"obtain()\"></p>";
            $("#paperdiv3").html(yue);
        }
    });
    function MenuShow() {
        //$('.paper_more:eq(0)').children('i').addClass('active');
        //$('.paper_number_mes:eq(0)').css('display', 'block');
        //预览试卷 手风琴
        $('.paper_numer h1').find('.icon').click(function () {
            var $next = $(this).parents('h1').next();
            var $this = $(this);
            $this.toggleClass('active');
            $next.stop().slideToggle();
            $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
            $('.paper_numer h1').find('.icon').not($this).removeClass('active');
        });
    }
    var CreateUID = $("#name").val();
    var id = $("#QID").val();
    var TCount = 0;
    var QCount = 0;
    var html = "";
    var fhr = "";
    var htmll = "";
    var status = "";
    //获取试卷信息
    function getExamPaper() {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetExamPaper", "ID": id, "CreateUID": CreateUID
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        status = this.Status;
                        chaxuntileike(this.exid, id);
                        chaxuntileizhu(this.exid, id);
                        var html = "<div class=\"paper_title\">"
                              + "<h2>" + this.Title + "</h2>"
                              + "<p>试卷满分" + this.FullScore + "分，考试时间" + this.ExamTime + "分钟，";
                        if ($("#hSF").val() == "教师") {
                            html += "作答人：" + this.UserName + "，";
                        }
                        html += "得分：<span id=\"examscore\"></span>";
                        html += "</p>";
                        html += "</div>";
                        $("#paperdiv").html(html);
                        examscore(this.exid);
                    });


                }
                else {
                    var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                    $("#paperdiv").html(html);
                }
                $('.previewpaper_mes').children("span").eq(1).find('.paper_more:eq(0)').children('i').addClass('active');
                $('.previewpaper_mes').children("span").eq(1).find('.paper_number_mes:eq(0)').show();

                MenuShow();
            },
            error: function (errMsg) {
                $("#paperdiv").html(json.result.errMsg.toString());
            }
        });

    }

    //获取试卷总分
    function examscore(exid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetdataEA", "ExamID": exid
            },
            success: function (json) {
                $(json.result.retData).each(function () {
                    $("#examscore").html("" + this.examscoree + "");
                })

            }
        });
    }
    //查询 客观题 题数及分数
    function chaxuntileike(exid,idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileikeyulan", "ExampaperID": idd
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $.each(json.result.retData, function () {
                        TCount++;
                        fhr += "<div class=\"paper_mes\">"
                            + "<div class=\"paper_numer\">"
                                + "<h1 class=\"clearfix\">"
                                    + "<div class=\"paper_number_name fl\"><span>"
                                    + this.Title + "</span>（本大题共" + this.sum + "小题，共" + this.score + "分）"
                                    + "</div>"
                                    + "<div class=\"paper_more fr\">"
                                        + "<i class=\"icon icon-angle-up\"></i>"
                                    + "</div>"
                                + "</h1>"
                                + "<div class=\"paper_number_mes\" >";
                        inquirycategory(this.Title, exid);
                        fhr += "</div>";
                        fhr += "</div>";
                        fhr += "</div>";
                        $("#paperdiv1").html(fhr);
                    });

                } else {
                    $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
                }
            },
            error: function (errMsg) {
                $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
            }
        });

    }

    //查询 主观题 题数及分数
    function chaxuntileizhu(exid,idd) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "chaxuntileizhuyulan", "ExampaperID": idd
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
                                        + "<i class=\"icon icon-angle-up\"></i>"
                                    + "</div>"
                                + "</h1>"
                                + "<div class=\"paper_number_mes\">";
                        inquirycategoryzhu(this.Title, exid);
                        htmll += "</div>";
                        htmll += "</div>";
                        htmll += "</div>";
                        $("#paperdiv2").html(htmll);
                    });

                }

            },
            error: function (errMsg) {
                $("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
            }
        });

    }

    //根据题型名称获取题型id
    function inquirycategory(Title,exid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "inquirycategory", "Title": Title
            },
            success: function (json) {
                if (json.result.errNum == "0") {
                    $(json.result.retData).each(function () {
                        chaxunzhutimuke(this.ID, exid);
                    });
                }
            }
        });
    }
    //根据题型名称获取题型id
    function inquirycategoryzhu(Title,exid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "inquirycategory", "Title": Title
            },
            success: function (json) {
                if (json.result.errNum == "0") {
                    $(json.result.retData).each(function () {
                        chaxunzhutimuzhu(this.ID, exid);
                    });
                }
            }
        });
    }
    function chaxunzhutimuke(type, exid) {

        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "inquirytitle", "ExamID": exid, "Type": type
            },
            success: function (json) {
                $.each(json.result.retData, function () {
                    QCount++;
                    fhr += "<div style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    fhr += "<h1>";
                    fhr += "	<em>" + this.Content + "</em>";
                    fhr += "	<span>(" + this.Score + "分)</span>";
                    fhr += "	</h1>";
                    if (this.mescore > 0) {
                        fhr += "	<span>对</span>";
                    } else {
                        fhr += "	<span>错</span>";
                    }
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
                    fhr += " <p><span class=\"rightanswer\">我的答案为：" + this.meAnswer + "</span>";
                    fhr += "</div>";


                });
            }
        })
    }
    var canweranwser = "";
    var examid = "";
    var typeid = "";
    function obtain() {
        var i = 0;
        var score = "";
        $("input[name='fengsu']").each(function () {
            score += $(this).val() + ",";
            if ($(this).val() == "") {
                i++;
            }
        })
        if (i == 0) {
            score = score.substr(0, score.length - 1);
            score = score.split(",");

            for (var i = 0; i < canweranwser.length; i++) {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    async: false,
                    dataType: "json",
                    data: {
                        PageName: "/Exam/ExamHandler.ashx",
                        "action": "upExam_ExamAnswer", "ExamID": examid, "Type": typeid, "Score": score[i], "QuestionID": canweranwser[i].QuestionID
                    },
                    success: function (json) {

                    }
                });
            }
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "upExam_Examination", "ID": examid, "Status": 2
                },
                success: function (json) {
                    if (json.result.errNum == "0") {
                        alert('阅卷成功');
                        window.location.href = "MyExam.aspx";
                    } else { alert('阅卷失败，请重新阅卷'); }
                }
            });
        }
        else {
            layer.msg("有未阅主观题");
        }
    }
    function chaxunzhutimuzhu(type, exid) {
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "inquirytitlezhu", "ExamID": exid, "Type": type
            },
            success: function (json) {
                examid = exid;
                typeid = type;
                canweranwser = json.result.retData;
                $.each(json.result.retData, function () {
                    QCount++;
                    htmll += "<div  style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    htmll += "<p>";
                    htmll += "	<em>" + this.Content + "</em>";
                    htmll += "	<span>(" + this.Score + "分)</span>";
                    htmll += "	</p>";
                    htmll += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    htmll += " <p><span class=\"rightanswer\">我的答案为：" + this.meAnswer + "</span>";
                    htmll += " <p><span >解析：" + this.Analysis + "</span></p>";
                    if ($("#hSF").val() == "教师" && status == 1) {
                        htmll += "<p><input id=\"ckOptionE\" type=\"text\" name=\"fengsu\" placeholder=\"请输入分数\" /></input><i class=\"star\"></i></p>";
                    } else {
                        htmll += " <p><span class=\"rightanswer\">得分：" + this.mescore + "</span>";
                    }
                    htmll += "</div>";
                });

            }
        })
    }
</script>
