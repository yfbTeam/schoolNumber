<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReleaseExam.aspx.cs" Inherits="SMSWeb.Exam.ReleaseExam" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
        <script src="/Scripts/My97DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <script type="text/javascript" src="/js/jquery-1.8.3.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
        <script src="/Scripts/Common.js"></script>
    <!--[if IE]>
			<script src="/js/html5.js"></script>
		<![endif]-->
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
</head>
	<body>
        <form id="form1" runat="server">
            <asp:HiddenField ID="name" runat="server" />
            <asp:HiddenField ID="QID" runat="server" />
            <asp:HiddenField ID="hIDCard" runat="server" />
            <asp:HiddenField ID="qtype" runat="server" />
            <div class="newtest_detail">
                <div class="newtest_title clearfix">
					<p class="newtest_name"><span>试卷名称：</span><span id="content"></span></p>
					<div class="newtest_starttime fl clearfix">
						<label for="">试卷有效开始时间：</label>
						<span class="fl pr"><input id="startime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
						</span>
						<i class="star"></i>
					</div>
					<div class="newtest_startend fl clearfix">
						<label for="">试卷有效结束时间：</label>
						<span class="fl pr"><input id="endtime" class="Wdate fl" type="text" placeholder="选择日期" value="" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
						</span>
						<i class="star"></i>
					</div>
				</div>
                <div class="newtest_class" id="evaluated"></div>
                <div class="newtest_class" id="teacher"></div>
                <div class="newtest_class" id="GetGrade"></div>
                <div style="margin:0 auto;width:246px;" class="clearfix">
                    <input type="button" value="确认发布" class="btn fl " onclick="keep()"/>
                    <input type="button" value="取消发布" class="btn fl" onclick="nokeep()" style="margin-left:10px;"/>
                </div>
            </div>
       </form>
   </body>
</html>
<script type="text/javascript">
    var id = $("#QID").val();
    var name = $("#name").val();
    $("#content").text(name);
    $(function () {
        if ($("#qtype").val() == "4") {
            getteacher();
        }
        getData();
    })
    //function getstudents() {
    //    $.ajax({
    //        url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
    //        type: "post",
    //        async: false,
    //        dataType: "json",
    //        data: { "Func": "MyExamination" },
    //        success: function (json) {
    //            $.each(json.result.retData, function () {
    //                evaluated += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"teacherid\" type=\"radio\" value=\"" + this.IDCard + "\" />" + this.Name + "</span>";
    //            });
    //            $("#evaluated").html(evaluated);
    //        }
    //    });
    //}
    var evaluated = "";
    function getteacher() {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "GetAllTeacherInfo" },
            success: function (json) {
                html += "选择要发布的教师";
                evaluated += "请选择被评价的教师";
                $.each(json.result.retData, function () {
                    html += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"teachid\" type=\"checkbox\" value=\"" + this.IDCard + "\" />" + this.Name + "</span>";
                    evaluated += "<span style='margin-left:10px;'><input id=\""+this.Name+"\" name=\"teacherid\" type=\"radio\" value=\"" + this.IDCard + "\" />" + this.Name + "</span>";
                });
                //getstudents();
                $("#evaluated").html(evaluated);
            }
        });
    }
    function getstudent(Id) {
        $.ajax({
            url: "/SystemSettings/UserInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "MyExamination" },
            success: function (json) {
                $.each(json.result.retData, function () {
                    html += "<input type=\"hidden\" name=\"" + Id + "\" value=\"" + this.IDCard + "\" />";
                });
            }
        });
    }
    var html = "";
    function getData() {
        var i = 0;
            $.ajax({
                url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: { "Func": "GetGrade" },
                success: function (json) {
                    html += "<p>选择参加考试班级</p>";
                    $.each(json.result.retData, function () {
                        html += '<div class="clearfix" style="padding:5px 0px;margin-bottom:10px;border:1px solid #ccc;"><div class="fl" style="width:70px;line-height:20px;font-size:14px;text-align:center;border-right:1px solid #ccc;"> ' + this.GradeName + '</div>';
                        html += '<div class="class_select fl" style="width:">';
                                    GetClass(this.Id);
                        html += '</div></div>';
                        $("#GetGrade").html(html);
                    });
                    
                },
                error: function (errMsg) {
                    layer.msg(errMsg);
                }
            });
    }
    function GetClass(id) {
        $.ajax({
            url: "/SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "GetClass" },
            success: function (json) {
                $.each(json.result.retData, function () {
                    if (this.GradeID == id) {
                        html += "<span style='margin-left:10px;'><input id=\"rdoOpA\" name=\"classid\" type=\"checkbox\" value=\"" + this.Id + "\" />" + this.ClassName + "</span>";
                        getstudent(this.Id);
                    }
                });
            }
        });
    }
    function keep()
    {
        var name="";
        $("input[name='teacherid']:checked").each(function () {
            name += $(this).val() ;
        });
        var title = $("#name").val();
        var username = $("#hIDCard").val();
        var studentcid = "";
        var IsRelease = 1;
        var Answer = "";
        var startime = $("#startime").val();
        var endtime = $("#endtime").val();
        Answer += ",";
        if ($("#qtype").val() == "4") {
            $("input[name='teachid']:checked").each(function () {
                studentcid += $(this).val() + ",";
            });
        }
        var kk="";
        $("input[name='teacherid']:checked").each(function(){
            kk=$(this).attr("id");
        });
        $("input[name='classid']:checked").each(function () {
            var cid = $(this).val();
            Answer += $(this).val() + ",";
            $("input[name='" + cid + "']").each(function () {
                studentcid += $(this).val() + ",";
            });
        });
        studentcid = studentcid.substr(0, studentcid.length - 1);
        studentcid = studentcid.split(",");
        if ($("#qtype").val() == "4")
        {
            addSysNotice(title, "评价" + name, 2, username, studentcid, "", "");
        }
        if (startime != "" && endtime != "") {
            $.ajax({
                url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                type: "post",
                async: false,
                dataType: "json",
                data: {
                    PageName: "/Exam/ExamHandler.ashx",
                    "action": "upExam_ExamPaperDal", "ID": id, "WorkBeginTime": startime, "WorkEndTime": endtime, "ClassID": Answer, "IsRelease": IsRelease, "evaluate": kk
                },
                success: function (json) {
                    //debugger;
                    if (json.result.retData != "") {
                        alert('发布成功');
                        parent.location.href = "ExamManager.aspx?ParentID=19";
                    }
                }
            });
        }
    }
    function nokeep() {
        parent.location.href = "ExamManager.aspx?ParentID=19";
    }
</script>