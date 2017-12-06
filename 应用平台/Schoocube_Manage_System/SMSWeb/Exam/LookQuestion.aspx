<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LookQuestion.aspx.cs" Inherits="SMSWeb.Exam.LookQuestion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>查看试题</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/KindUeditor/kindeditor-min.js"></script>
    <script src="/Script/KindUeditor/plugins/code/prettify.js"></script>
    <script src="/Script/KindUeditor/lang/zh_CN.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/js/common.js"></script>
    <style> 

        .select_adb span{line-height:40px;font-size:14px;color:#666;}
    </style>
</head>
<body style="background:#fff;">
    <form id="form2" runat="server">
        <div>
            <asp:HiddenField ID="hIDCard" runat="server" />
            <asp:HiddenField ID="HSchoolID" runat="server" Value="1" />
            <asp:HiddenField ID="HPeriod" runat="server" />
            <asp:HiddenField ID="HSubject" runat="server" Value="1" />
            <asp:HiddenField ID="bookVersion" runat="server" />
            <asp:HiddenField ID="HTextboox" runat="server" Value="1" />
            <asp:HiddenField ID="HChapterID" runat="server" />
            <!--添加试卷dialog-->
                <%--<div class="testdialog_title">
                    添加试题
						<span class="close fr">
                            <i class="icon icon-remove"></i>
                        </span>
                </div>--%>
                <div class="dialog_detail">
                    <h1 class="clearfix">
                        <div class="select_left fl">
                            当前选择：
                        </div>
                        <div class="select_right fl clearfix">

                            <div class="clearfix fl select_adb">
                                <label for="">学科：</label>
                                <span id="Subject"></span>
                            </div>
                            <div class="clearfix fl select_adb">
                                <label for="">教材：</label>
                                <span id="Book"></span>
                            </div>
                            <div class="clearfix fl select_adb">
                                <label for="">章：</label>
                                <span id="Chapter"></span>
                            </div>
                            <div class="clearfix fl select_adb">
                                <label for="">节：</label>
                                <span id="Part"></span>
                            </div>

                        </div>
                    </h1>
                    <div class="row clearfix mt10">
                        <div class="clearfix">
                            <div class="clearfix fl select_adb">
                                <label for="">题型：</label>
                                <span id="Type"></span>
                            </div>
                            <div class="clearfix fl select_adb">
                                <label for="">难易程度：</label>
                                <span id="Difficult"></span>
                            </div>
                            <div class="clearfix fl select_adb">
                                <label for="">状态：</label>
                                <span id="Status"></span>
                            </div>
                        </div>
                    </div>
                    <div class="row clearfix mt10 select_adb">
                        <label for="">题目：</label>
                        <span id="Title"></span>
                    </div>
                    <div class="row clearfix mt10 select_adb">
                        <label for="">备注：</label>
                        <div class="froala">
                            <span id="Question"></span>
                        </div>
                    </div>
                    <div class="row clearfix mt10 radio none">
                        <span id="Option"></span>
                    </div>
                    <div class="row clearfix mt10 judge none">
                        <span id="ckradio"></span>
                    </div>
                    <div class="row clearfix mt10 checkbox none">
                        <span id="radio"></span>
                    </div>
                    <div id="answerdiv" class="row clearfix canswer mt10 select_adb">
                        <label for="">答案：</label>
                        <span id="answer"></span>
                    </div>
                    <div class="row clearfix select_adb">
                        <label for="">解析：</label>
                        <div class="froala">
                            <span id="Analysis" style="color:red;"></span>
                        </div>
                    </div>
                </div>
        </div>
        <asp:HiddenField ID="qtype" runat="server" Value="1" />
        <asp:HiddenField ID="QID" runat="server" Value="1" />
    </form>
</body>
</html>








<script type="text/javascript">
    $(function () {
        Chapator();
        BindCatagory();
        BindQuestion();
    });
    var CatagoryJson = "";
    var chapterjson = "";
    function BindCatagory() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",

            data: { "Func": "Period" },
            success: function (json) {
                CatagoryJson = json;
            },
            error: function (errMsg) {
                alert(errMsg);
            }
        });
    }
    function Chapator() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "Chapator" },
            success: function (json) {
                chapterjson = json;
            }
        })
    }
    
    function BindQuestion() {
        var id = $('#<%=QID.ClientID%>').val();
        var qtype = $('#<%=qtype.ClientID%>').val();
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetQuestion", "ID": id, "Qtype": qtype
            },
            success: function (json) {
                //json = $.parseJSON(json);
                var result = json.result;
                var Data =result.retData;
                var html = "";
                var bookid = Data[0].Book.split("|");
                if (CatagoryJson.GradeOfSubject.errNum.toString() == "0") {
                    $(CatagoryJson.GradeOfSubject.retData).each(function () {

                        if (this.GradeID == bookid[0] && this.SubjectID == bookid[1]) {
                            
                            $('#Subject').html("(" + this.GradeName + ")" + this.SubjectName);
                        }

                    });
                }
                if (CatagoryJson.Textbook.errNum.toString() == "0") {
                    $(CatagoryJson.Textbook.retData).each(function () {
                        if (this.VersionID == bookid[bookid.length - 2] && this.Id == bookid[bookid.length - 1]) {

                            $('#Book').html(this.Name + "(" + this.VersionName + ")");
                        }
                    });
                }
                var Klpoint = Data[0].Klpoint;
                if (chapterjson != "") {
                    $(chapterjson.result.retData).each(function () {
                        
                        if (this.Id == Klpoint) {
                            var i = this.PID
                            $(chapterjson.result.retData).each(function () {
                                if (this.Id == i) {$('#Chapter').html(this.Name); }
                            })
                            
                        }
                        if (this.Id == Klpoint && this.PID != "0") {
                            $('#Part').html(this.Name);
                        }
                    });
                }
                $("#Difficult").text(Data[0].DifficultyShow);
                $("#Title").text(Data[0].Title);
                $("#Question").text(Data[0].Question);
                $("#Type").text(Data[0].Typeshow);

                $("#Analysis").text(Data[0].Analysis);
                $("#Status").text(Data[0].StatusShow);
                $("#answer").text(Data[0].Answer);
                var optionstr = "";
                var OptionA = "";
                OptionA = ""+Data[0].OptionA+"";
                OptionA = OptionA.substr(OptionA.lastIndexOf("."), OptionA.length);
                var OptionB = "";
                OptionB = ""+Data[0].OptionB+"";
                OptionB = OptionB.substr(OptionB.lastIndexOf("."), OptionB.length);
                var OptionC = "";
                OptionC = ""+Data[0].OptionC+"";
                OptionC = OptionC.substr(OptionC.lastIndexOf("."), OptionC.length);
                var OptionD = "";
                OptionD = ""+Data[0].OptionD+"";
                OptionD = OptionD.substr(OptionD.lastIndexOf("."), OptionD.length);
                var OptionE = "";
                OptionE = ""+Data[0].OptionE+"";
                OptionE = OptionE.substr(OptionE.lastIndexOf("."), OptionE.length);
                var OptionF = "";
                OptionF = ""+Data[0].OptionF+"";
                OptionF = OptionF.substr(OptionF.lastIndexOf("."), OptionF.length);
                if (OptionA == ".png" || OptionA == ".jpeg" || OptionA == ".jpg") {
                    optionstr += "A.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionA + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionA == "" ? "" : "A." + Data[0].OptionA + "</br>"); }
                if (OptionB == ".png" || OptionB == ".jpeg" || OptionB == ".jpg") {
                    optionstr += "B.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionB + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionB == "" ? "" : "B." + Data[0].OptionB + "</br>"); }
                if (OptionC == ".png" || OptionC == ".jpeg" || OptionC == ".jpg") {
                    optionstr += "C.<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionC + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionC == "" ? "" : "C." + Data[0].OptionC + "</br>"); }
                if (OptionD == ".png" || OptionD == ".jpeg" || OptionD == ".jpg") {
                    optionstr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionD + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionD == "" ? "" : "D." + Data[0].OptionD + "</br>"); }
                if (OptionE == ".png" || OptionE == ".jpeg" || OptionE == ".jpg") {
                    optionstr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionE + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionE == "" ? "" : "E." + Data[0].OptionE + "</br>"); }
                if (OptionF == ".png" || OptionF == ".jpeg" || OptionF == ".jpg") {
                    optionstr += "<img id=\"img_PicAnalysis\" alt=\"\" src=\"" + Data[0].OptionF + "\" style=\"width: 100px; height: auto;\" />";
                } else { optionstr = optionstr + (Data[0].OptionF == "" ? "" : "F." + Data[0].OptionF); }
                    if (Data[0].QType == "1") {
                        $(".checkbox").hide();
                        $(".judge").hide();
                        $(".radio").show();
                    } else if (Data[0].QType == "2") {
                        $(".checkbox").show();
                        $(".judge").hide();
                        $(".radio").hide();
                    } else if (Data[0].QType == "6") {
                        $(".checkbox").hide();
                        $(".judge").show();
                        $(".radio").hide();
                    }
                    $("#ckradio").html(optionstr);
                    $("#radio").html(optionstr);
                    $("#Option").html(optionstr);

            },
            error: function (errMsg) {
                layer.msg('试题信息获取失败！');
            }
        });
    }
</script>
