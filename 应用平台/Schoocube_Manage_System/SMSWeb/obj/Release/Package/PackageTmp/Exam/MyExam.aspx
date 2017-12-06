<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MyExam.aspx.cs" Inherits="SMSWeb.Exam.MyExam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>试卷管理</title>
    <link rel="stylesheet" type="text/css" href="../css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="../css/reset.css" />
    <link rel="stylesheet" type="text/css" href="../css/common.css" />
    <link rel="stylesheet" type="text/css" href="../css/repository.css" />
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
    <script src="../CourseMenu.js"></script>

    <style>
</style>
</head>
<body>
    <div>
        <input type="hidden" id="HUserIdCard" value="<%=IDCard %>" />

        <input type="hidden" id="hName" runat="server" />
        <input type="hidden" id="hSF" runat="server" />
        <input id="HStatus" type="hidden" value="1" />
        <input id="nohIDCard" type="hidden" value="0" />
        <input id="hIDCard" type="hidden" runat="server" />
        <input id="hClassID" type="hidden" runat="server" />
        <!--header-->
        <header class="repository_header_wrap manage_header">
            <div class="width repository_header clearfix">
                <a class="logo fl" href="../HZ_Index.aspx">
                    <img src="../images/logo.png" /></a>
                <div class="wenzi_tips fl">
                         <img src="/images/testsystem.png" /></div>
                <nav id="teacher" class="navbar menu_mid fl">
                    <ul id="CourceMenu">
                        <%--<li currentclass="active"><a href="ExamQManager.aspx">题库管理</a></li>
                            <li currentclass="active"><a href="ExamManager.aspx">试卷管理</a></li>
                            <li currentclass="active"><a href="MyExam.aspx">我的试卷</a></li>
                            <li currentclass="active"><a href="charts.aspx">分析统计</a></li>--%>
                    </ul>
                </nav>
                <nav id="student" class="navbar menu_mid fl">
                    <ul>
                        <li currentclass="active"><a href="/PersonalSpace/Learning_center_portal.aspx">学习中心门户</a></li>
                        <li currentclass="active"><a href="/OnlineLearning/MyLessons.aspx">在线学习</a></li>
                        <li currentclass="active"><a href="/CourseManage/Cource_OnlineChose.aspx">在线选课</a></li>
                        <li currentclass="active"><a href="/Exam/MyExam.aspx">在线考试</a></li>
                        <li><a href="/Recommended/RecommendedStu.aspx">推荐就业</a></li>
                        <li><a href="/OnlineLearning/Innovation.aspx">教学互动</a></li>
                        <li><a href="/analysisa/student_studyprocess(4).html">个人学习进度</a></li>

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
                <div class="stytem_select clearfix">

                    <div id="student1" class="stytem_select_left fl">
                        <a href="javascript:;" onclick="onquery(1)">未答试卷</a>
                        <a href="javascript:;" class="on" onclick="onquery(0)">已答试卷</a>
                    </div>
                    <div id="teacher1" class="stytem_select_left fl">
                        <a href="javascript:;" class="on" onclick="on(1)">未阅试卷</a>
                        <a href="javascript:;" onclick="on(2)">已阅试卷</a>
                    </div>
                    <div class="stytem_select_right fr">
                        <div class="search_exam fl pr">
                            <input type="text" name="" id="chaxun" onblur="getData(1, 10)" value="" placeholder="试卷名称" />
                            <i class="icon  icon-search"></i>
                        </div>
                        <span class="enable">
                            <span value="" id="sel_Type">请选择</span><i class="icon icon-angle-down"></i>
                            <div class="enable_wrap none">
                                <span value="" class="active" onclick="ChangePaperType(null)">全部</span>
                                <span value="1" onclick="ChangePaperType(1)">考试</span>
                                <span value="2" onclick="ChangePaperType(2)">测试</span>
                                <span value="3" onclick="ChangePaperType(3)">作业</span>
                                <span value="4" onclick="ChangePaperType(4)">问卷调查</span>
                            </div>
                        </span>
                        <%--						<select name="" class="enable">
							<option value=""></option>
						</select>--%>
                    </div>
                </div>
                <div class="test_norelase">
                    <ul class="test_lists exam_lists" id="NoExam">
                    </ul>
                    <ul class="test_lists exam_lists none" id="YesExam">
                    </ul>
                </div>
                <!--分页-->
                <div class="page">
                    <span id="pageBar"></span>
                    <span id="neverpageBar"></span>
                </div>
                <div id="main1"></div>
                <!---->
            </div>
        </div>
        <script src="../js/common.js" type="text/javascript" charset="utf-8"></script>
        <script src="../js/system.js" type="text/javascript" charset="utf-8"></script>
    <%--</form>--%>
</body>
</html>

<script type="text/javascript">
    function accountManagement() {
        window.location.href = "/Gopay/Gopay.aspx";
    }
    function Mycenter() {
        window.open("/PersonalSpace/PersonalSpace_Student.aspx", "_blank")
    }
    var classid = $("#hClassID").val();

    var userid = $("#hIDCard").val();
    var classid = "";
    var subjectid = "";
    $(document).ready(function () {
        CourceMenu();

        var str = $('#hSF').val();
        if (str == "学生") {
            $('#teacher').hide();
            $('#student').show();
        } else {
            $('#teacher').show();
            GetClass();
            $('#student').hide();
        }
        quanxian();
        getData(1, 10);

    })

    function ChangePaperType(type) {
        $("#sel_Type").attr("value", type);
        getData(1, 10);
    }
    function on(relvalue) {
        $("#HStatus").val(relvalue);
        getData(1, 10);
    }
    var relvalueid = 0;
    function onquery(relvalue) {
        relvalueid = relvalue;
        $("#nohIDCard").val(relvalue);
        getData(1, 10);
    }
    //权限判断
    function quanxian() {
        var str = $('#hSF').val();
        if (str == "学生") {
            $('#student1').show();
            $('#teacher1').hide();
        } else {
            $('#student1').hide();
            $('#teacher1').show();
        }
    }
    function GetClass() {
        $.ajax({
            url: "../SystemSettings/CommonInfo.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            async: false,
            dataType: "json",
            data: { "Func": "MyExamination", "userid": userid },
            success: function (json) {
                $.each(json.result.retData, function () {
                    classid += "," + this.ClassID + "," + "|";
                    subjectid += "%|" + this.SubjectID + "|%|%" + ",";
                });
                classid = classid.substr(0, classid.length - 1);
                subjectid = subjectid.substr(0, subjectid.length - 1);
            }
        });
    }

    function getData(startIndex, pageSize) {

        var hsubjectid = "";
        var hClassID = "";
        var str = $('#hSF').val();
        if (str == "学生") {
            hClassID = "," + $("#hClassID").val() + ",";
            var noCreateUID = "";
            var CreateUID = "";
            if ($("#nohIDCard").val() == "1") {

                noCreateUID = $("#hIDCard").val();
            } else {
                CreateUID = $("#hIDCard").val();

            }
        } else {
            hClassID = classid;
            hsubjectid = subjectid;
        }

        //var MajorID = Period.trim() == "" ? "" : (Subject.trim() == "" ? Period : (Period + "|" + Subject));
        //MajorID = bookVersion.trim() == "" ? MajorID : (Textbook.trim() == "" ? MajorID + "&" + bookVersion : (MajorID + "&" + bookVersion + "|" + TextBook));
        if (str == "学生") {
            var Status = "";
        } else { var Status = $("#HStatus").val(); }
        var Title = $('#chaxun').val();
        var TypeId = $("#sel_Type").attr("value");
        //初始化序号 
        // pageNum = (startIndex - 1) * pageSize + 1;
        //name = name || '';
        $.ajax({
            url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
            type: "post",
            //async: false,
            dataType: "json",
            data: {
                PageName: "/Exam/ExamHandler.ashx",
                "action": "GetExamNPageList",
                PageIndex: startIndex,
                pageSize: pageSize,
                "Status": Status,
                "Type": TypeId,
                "Title": Title,
                "ClassID": hClassID,
                "noCreateUID": noCreateUID,
                "CreateUID": CreateUID,
                "Book": hsubjectid,
            },
            success: OnSuccess,
            //error: OnError
        });
    }
    var jsonsubjecket = "";
    var createname = "";
    function OnSuccess(json) {
        var str = $('#hSF').val();
        var myDate = new Date();
        var mydtim = myDate.toLocaleString();
        mydtim = mydtim.replace("下午", "");
        mydtim = mydtim.replace("上午", "");
        var states = $("#HStatus").val();
        if (json.result.errNum.toString() == "0") {
            var html = "";
            $.each(json.result.retData.PagedData, function () {
                jsonsubjecket = json.result.retData.PagedData;
                html += "<li class=\"clearfix\">"
                            + "<div class=\"exam_img fl\">"
                                + "<img src=\"../images/exam_img.png\" />"
                            + "</div>"
                            + "<div class=\"test_description exam_description fl\" style=\"width:200px\">";
                if (str == "学生") {
                    if (this.Statushow == "未阅" && this.typeid != 4) {
                        html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                    } else if (this.Statushow == "已阅" && this.typeid != 4) {
                        html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                    } else if (relvalueid == 1 && ((Date.parse(this.WorkBeginTime) < Date.parse(mydtim)) && (Date.parse(mydtim) < Date.parse(this.WorkEndTime)))) {
                        if (this.typeid == 4) { html += "<h2 style=\"width:200px\"><a href='window.open('QuestionnaireSurvey .aspx?id=" + this.ID + "');'>" + this.Title + "(可答)</a></h2>"; }
                        html += "<h2 style=\"width:200px\"><a href='#' onclick=\"onlineanswer(" + this.ID + ")\">" + this.epname + "(可答)</a></h2>";
                    } else {
                        html += "<h2 style=\"width:200px\"><a href='javacript:void(0);' style=\"color:gray;\" onclick=\"return confirm('不再规定时间内，无法答题')\">" + this.epname + "(不可答)</a></h2>";
                    }
                } else {
                    if (this.Statushow == "未阅" && this.typeid != 4) {
                        html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                    } else if (this.Statushow == "已阅" && this.typeid != 4) {
                        html += "<h2 style=\"width:200px\"><a href='#' onclick=\"AnsweredExam(" + this.ID + ",this)\" id='" + this.CreateUID + "'>" + this.Title + "</a></h2>";
                    } else if (relvalueid == 1 && ((Date.parse(this.WorkBeginTime) < Date.parse(mydtim)) && (Date.parse(mydtim) < Date.parse(this.WorkEndTime)))) {
                        if (this.typeid == 4) { html += "<h2 style=\"width:200px\"><a href='window.open('QuestionnaireSurvey .aspx?id=" + this.ID + "');''>" + this.Title + "</a></h2>"; }
                    } else {
                        html += "<h2 style=\"width:200px\"><a href='javacript:void(0);' style=\"color:gray;\" onclick=\"return confirm('不再规定时间内，无法评价')\">" + this.Title + "</a></h2>";
                    }
                }

                html += "<p style=\"width:400px\"><span class=\"test_easy\">" + this.Difficultyshow + "</span><span class=\"test_easy\">" + this.typeid + "</span>";
                if (relvalueid != 1) {
                    if (this.typeid != 4) { html += "<span class=\"test_easy\">" + this.Statushow + "</span></p>"; }
                }
                html += "</div>"
                            + "<div class=\"test_lists_right fr clearfix\" style=\"width:300px\">"
                                + "<div class=\"public_name fl\">";
                if (str == "学生") {
                    html += "创建人：" + this.Author;
                    createname = this.Author;
                } else {
                    html += "作答人：" + this.UserName;
                }
                html += "</div>"
                + "<div class=\"dates_a dates_b fr pr\" style=\"width:200px\">"
                    + "<div class=\"data\" style=\"width:200px\">"
                        + "创建时间：" + this.CreateTime_Format
                    + "</div></div></div></li>";
            });
            if (states == 1) {
                $("#YesExam").html(html);
                $("#NoExam").hide();
                $("#YesExam").show();
                $("#neverpageBar").hide();
                $("#pageBar").show();
                makePageBar(getData, document.getElementById("pageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            } else {
                $("#NoExam").html(html);
                $("#NoExam").show();
                $("#YesExam").hide();
                $("#pageBar").hide();
                $("#neverpageBar").show();
                makePageBar(getData, document.getElementById("neverpageBar"), json.result.retData.PageIndex, json.result.retData.PageCount, 8, json.result.retData.RowCount);
            }
            //HoverPaper();
            //生成页码条方法（方法对象,页码条容器，当前页码，总页数，页码组容量，总行数）
        } else {
            var html = '<div style="background: url(../images/error.png) no-repeat center center; height: 500px;"></div>';
            if (states == 0) {
                $("#YesExam").hide();
                $("#NoExam").show();
                $("#neverpageBar").hide();
                $("#pageBar").hide();
                $("#NoExam").html(html);
            } else {
                $("#NoExam").hide();
                $("#YesExam").show();
                $("#neverpageBar").hide();
                $("#pageBar").hide();
                $("#YesExam").html(html);
            }
        }
    }
    function AnsweredExam(idd, em) {
        //var parm = "?id=" + ID + "&name=" + em.id;
        //location.href = 'AnsweredExam.aspx' + parm;
        //OpenIFrameWindow('查看试卷', 'AnsweredExam.aspx?id=' + ID + '&name=' + em.id, '800px', '80%');
        window.open('AnsweredExam.aspx?id=' + idd + '&name=' + em.id);
        //window.location.href = 'AnsweredExam.aspx?id=' + ID + '&name=' + em.id;
    }
    function onlineanswer(josn) {
        var userid = $("#hIDCard").val();
        var name = $("#hName").val();
        var id = 0;
        $.each(jsonsubjecket, function () {
            if (this.ID == josn) {
                $.ajax({
                    url: "/Common.ashx",//random" + Math.random(),//方法所在页面和方法名
                    type: "post",
                    data: {
                        PageName: "/Exam/ExamHandler.ashx",
                        "action": "addExamination", "Title": this.epname, "CreateUID": userid, "UserName": name, "ExampaperID": this.ID, "Score": this.FullScore, "Status": 1, "Marker": 1, "AnswerBeginTime": this.WorkBeginTime, "AnswerEndTime": this.WorkEndTime
                    },
                    success: function (data) {
                        window.open(" onlineanswer.aspx?id=" + josn);
                        //OpenIFrameWindow('答卷', 'onlineanswer.aspx?id=' + ID + '&name=' + name, '780px', '70%');
                    }
                });
            }
        });
        //window.location.href = "" + josn;

    }
</script>
