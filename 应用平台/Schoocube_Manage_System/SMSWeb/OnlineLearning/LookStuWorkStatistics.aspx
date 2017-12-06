<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LookStuWorkStatistics.aspx.cs" Inherits="SMSWeb.OnlineLearning.LookStuWorkStatistics" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <title>查看学生提交作业信息</title>
    <!--图标样式-->
    <link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css" />
    <link rel="stylesheet" type="text/css" href="/css/reset.css" />
    <link rel="stylesheet" type="text/css" href="/css/common.css" />
    <link rel="stylesheet" type="text/css" href="/css/repository.css" />
    <link rel="stylesheet" type="text/css" href="/css/onlinetest.css" />
    <script src="/Scripts/jquery-1.11.2.min.js"></script>
    <script src="/Scripts/layer/layer.js"></script>
    <script src="/Scripts/Common.js"></script>
    <script src="/Scripts/jquery.tmpl.js"></script>
    <script src="/Scripts/PageBar.js"></script>
    <script type="text/javascript" src="/js/menu_top.js"></script>
    <style type="text/css">
        .h-ico {
            display: inline-block;
        }
    </style>
    <!--[if IE]>
			<script src="js/html5.js"></script>
		<![endif]-->
    <script id="tr_stuwork" type="text/x-jquery-tmpl">
        <tr>           
            <td>${Name}</td>
            <td>${GradeName}</td>
            <td>${ClassName}</td>          
            <td>${comCount}</td>
            <td>${ScoreStatus1}</td>
            <td>${ScoreStatus2}</td>
            <td>${ScoreStatus3}</td>
            <td>${ScoreStatus4}</td>
            <td>${uncorrect}</td>
        </tr>
    </script>

</head>
<body>
    <input type="hidden" id="HUserIdCard" runat="server" />
    <input type="hidden" id="HUserName" runat="server" />
    <form id="form1" runat="server">
        <!--header-->        
        <div class="onlinetest_item" style="width:100%;">
            <div class="course_manage bordshadrad" style="padding:10px 10px;">
                <div style="height:30px;line-height:30px;">当前课程共有 <span style="color:red;" id="span_WorkCount"></span> 项作业：</div>
                <div class="wrap" style="margin-top:0px;">
                    <table>
                        <thead>
                            <tr>
                                <th>姓名</th>              
                                <th>年级</th>
                                <th>班级</th>
                                <th>提交作业总数</th>
                                <th>优</th>
                                <th>良</th>
                                <th>中</th>
                                <th>差</th>
                                <th>未批改</th>
                            </tr>
                        </thead>
                        <tbody id="tb_Statistics"></tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="/js/common.js"></script>
    </form>
</body>
<script type="text/javascript">
    var UrlDate = new GetUrlDate();
    $(document).ready(function () {
        GetWorkDataPage();
        GetCourseWorkStatistics();
    });
    //绑定作业
    function GetWorkDataPage() {       
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/WorkHandler.ashx",
                Func: "GetWorkDataPage",
                CourseID: UrlDate.courseid,
                ispage:false,                
                UserIdCard: $("#HUserIdCard").val()
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#span_WorkCount").html(json.result.retData.length);
                }
                else { $("#span_WorkCount").html(0); }
            },
            error: function (errMsg) {
                $("#span_WorkCount").html(errMsg);
            }
        });
    }
    function GetCourseWorkStatistics() {
        $.ajax({
            url: "/Common.ashx",
            type: "post",
            async: false,
            dataType: "json",
            data: {
                PageName: "/OnlineLearning/WorkHandler.ashx",
                Func: "GetCourseWorkStatistics",
                CourseID: UrlDate.courseid,
                CourseType: UrlDate.coursetype
            },
            success: function (json) {
                if (json.result.errNum.toString() == "0") {
                    $("#tb_Statistics").html('');
                    $("#tr_stuwork").tmpl(json.result.retData).appendTo("#tb_Statistics");
                }
                else {
                    $("#tb_Statistics").html("<tr><td colspan='9'>暂无作业统计信息！</td></tr>");
                }
            },
            error: function (errMsg) {
                $("#tb_Statistics").html("<tr><td colspan='9'>暂无作业统计信息！</td></tr>");
            }
        });
    }    
</script>
</html>
