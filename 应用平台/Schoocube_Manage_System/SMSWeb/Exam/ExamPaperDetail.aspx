<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ExamPaperDetail.aspx.cs" Inherits="SMSWeb.Exam.ExamPaperDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
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
<body style="background:#fff;">
    <form id="form1" runat="server">
        <div>

                <div class="previewpaper_mes">
                    <span id="paperdiv"></span>
                    <span id="paperdiv1"></span>
                    <span id="paperdiv2"></span>
                </div>
            </div>
    </form>
    <script src="/js/common.js" type="text/javascript" charset="utf-8"></script>
    <script src="/js/system.js" type="text/javascript" charset="utf-8"></script>
<%--		<script>
		    $(function () {
		        //menu显示隐藏
		        $('.grade').find('.item').click(function () {
		            clickTab($('.grade'), '.icon_right');
		        });
		        //预览试卷 手风琴
		        
		        //选择专业班
		        $('.class_nav li').click(function () {
		            $(this).addClass('active').siblings().removeClass('active');
		            var n = $(this).index();
		            $('.class_select .select_class').eq(n).show().siblings().hide();
		        })
		        //
		        onscroll($('.testsystem_wrap>.menu'));
		    })
		</script>--%>

</body>
</html>
<script type="text/javascript">
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
    function getExamPaper() {
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
                    $.each(json.result.retData, function () {
                        chaxuntileike(id);
                        chaxuntileizhu(id);
                        var html = "<div class=\"paper_title\">"
                              + "<h2>" + this.name + "</h2>"
                              + "<p>满分" + this.FullScore + "分，考试时间" + this.ExamTime + "分钟。</p>"
                        "</div>";
                        $("#paperdiv").html(html);
                    });
                        
                    
                } else {
                    var html = '<div style="background: url(/images/error.png) no-repeat center center; height: 500px;"></div>';
                    $("#paperdiv").html(html);
                }
            },
            error: function (errMsg) {
                $("#paperdiv").html(json.result.errMsg.toString());
            }
        });

    }
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
                                + "<div class=\"paper_number_mes\">";
                        chaxunzhutimuke(this.Title, idd);
                        fhr += "</div>";
                        fhr += "</div>";
                        fhr += "</div>";
                        $("#paperdiv1").html(fhr);
                    });
                    
                } else {
                    if (json.result.retData == "无数据") {
                        $("#paperdiv1").hide();
                    }
                    //$("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
                }
                $('.paper_more:eq(0)').children('i').addClass('active');
                $('.paper_number_mes:eq(0)').css('display', 'block');
                //预览试卷 手风琴
                $('.paper_numer h1').find('.icon').click(function () {
                    var $next = $(this).parents('h1').next();
                    var $this = $(this);
                    $this.toggleClass('active');
                    $next.stop().slideToggle();
                    $('.paper_numer').find('.paper_number_mes').not($next).slideUp();
                    $('.paper_numer h1').find('.icon').not($this).removeClass('active');
                });
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
                                + "<div class=\"paper_number_mes\" \">";
                        chaxunzhutimuzhu(this.Title, idd);
                        htmll += "</div>";
                        htmll += "</div>";
                        htmll += "</div>";
                        $("#paperdiv2").html(htmll);
                    });

                } else {
                    if (json.result.retData == "无数据") {
                        $("#paperdiv2").hide();
                    }
                    //$("#paperdiv").html($("#paperdiv").html() + json.result.errMsg.toString());
                }
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
                //debugger;
                $.each(json.result.retData, function () {
                    QCount++;
                    fhr += "<div style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    fhr += "<h1>";
                    fhr += "	<em>" + this.Content + "</em>";
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
                                fhr += "D.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionD + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>D：" + this.OptionD + "</p>"; }

                        }
                        if (this.OptionE != "") {
                            var OptionE = "";
                            OptionE = "" + this.OptionE + "";
                            OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                            if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                                fhr += "E.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionE + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>E：" + this.OptionE + "</p>"; }

                        }
                        if (this.OptionF != "") {
                            var OptionF = "";
                            OptionF = "" + this.OptionF + "";
                            OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                            if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                                fhr += "F.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + this.OptionF + "\" style=\"width: 100px; height: auto;\" />";
                            } else { fhr += "<p>F：" + this.OptionF + "</p>"; }

                        }
                    }
                    fhr += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span>";
                    fhr += " <span >解析：" + this.Analysis + "</span></p>";
                    fhr += "</div>";


                });


            }
        })
    }
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
                    QCount++;
                    htmll += "<div  style=\"padding:10px;border: 1px solid #ccc;margin-top: 10px;\">";
                    htmll += "<p>";
                    htmll += "题文：" + this.Content + "";
                    htmll += "	<span>(" + this.Score + "分)</span>";
                    htmll += "	</p>";
                    htmll += " <p><span class=\"rightanswer\">正确答案为：" + this.Answer + "</span></p>";
                    htmll += " <p><span >解析：" + this.Analysis + "</span></p>";
                    htmll += "</div>";
                    

                });

            }
        })
    }
    
</script>
